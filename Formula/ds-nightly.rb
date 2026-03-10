strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

class DsNightly < Formula
  desc "Build, run, and govern agents across the software development lifecycle (nightly)"
  homepage "https://github.com/docker/dash-releases"
  version "nightly-2026031013-fa5c7f9"

  url "https://github.com/docker/dash-releases/releases/download/nightly/ds-darwin-arm64.tar.gz",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy

  def install
    bin.install "bin/ds"
    (libexec/"ds").install Dir["libexec/*"]
    bash_completion.install "completions/bash/ds"
    zsh_completion.install "completions/zsh/_ds"
    fish_completion.install "completions/fish/ds.fish"
  end

  test do
    assert_match "nightly", shell_output("#{bin}/ds version")
  end
end
