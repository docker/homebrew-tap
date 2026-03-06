require "download_strategy"
require "json"
require "shellwords"
require "utils/curl"

class GitHubPrivateRepositoryReleaseDownloadStrategy < AbstractFileDownloadStrategy
  def initialize(url, name, version, **meta)
    super
    @github_token = ENV["HOMEBREW_GH_TOKEN"]
    parse_url_pattern
  end

  def resolved_basename
    super.gsub(' ', '+')
  end

  def parse_url_pattern
    url_pattern =
      %r{https://github.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(\S+)}
    unless @url =~ url_pattern
      raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Release."
    end

    _, @owner, @repo, @tag, @filename = *@url.match(url_pattern)
  end

  def fetch(timeout: nil)
    if cached_location.exist?
      ohai "Already downloaded: #{cached_location}"
    else
      if @github_token != nil
        ohai "PAT found... using it"
        asset_url =
          "https://api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{asset_id}"

        ::Utils::Curl.curl_download asset_url,
                                    "--header",
                                    "Authorization: Token #{@github_token}",
                                    "--header",
                                    "X-GitHub-Api-Version: 2022-11-28",
                                    "--header",
                                    "Accept: application/octet-stream",
                                    to: temporary_path
      else
        ohai "Downloading to: #{Shellwords.escape(temporary_path.to_s)}"
        cmd =
          "gh --repo=#{@owner}/#{@repo} release download #{@tag} --pattern=#{@filename} --output=#{Shellwords.escape(temporary_path.to_s)} --clobber"
        puts `export PATH=$PATH:/opt/homebrew/bin:/usr/local/bin:~/.local/bin && #{cmd}`
        if not $?.success?
          raise CurlDownloadStrategyError, "You may need to expose a valid HOMEBREW_GH_TOKEN environment variable:\n\nexport HOMEBREW_GH_TOKEN=$(gh auth token)"
        end
      end

      ignore_interrupts { temporary_path.rename(cached_location) }
    end
  end

  def clear_cache
    super
    rm_rf(temporary_path)
  end

  private

  def asset_id
    @asset_id ||= resolve_asset_id
  end

  def resolve_asset_id
    release_metadata = fetch_release_metadata
    assets = release_metadata["assets"]
    if assets.nil?
      raise CurlDownloadStrategyError, "Release not found."
    end
    matching_assets = assets.select { |a| a["name"] == @filename }
    raise CurlDownloadStrategyError, "Asset file not found." if matching_assets.empty?
    matching_assets.first["id"]
  end

  def fetch_release_metadata
    release_url =
      "https://api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}"
    curl_output, = ::Utils::Curl.curl_output(
      release_url,
      "--header", "Authorization: Token #{@github_token}",
      "--header", "Accept: application/vnd.github+json",
      "--header", "X-GitHub-Api-Version: 2022-11-28",
    )
    JSON.parse(curl_output)
  end
end
