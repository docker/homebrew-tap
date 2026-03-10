strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

class Ds < Formula
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"
  url "https://github.com/docker/dash-releases/releases/download/v0.14.0/ds-darwin-arm64.tar.gz",
    using: GitHubPrivateRepositoryReleaseDownloadStrategy
  version "0.14.0"

  def install
    bin.install "bin/ds"
    libexec.install Dir["libexec/*"]
    bash_completion.install "completions/bash/ds"
    zsh_completion.install "completions/zsh/_ds"
    fish_completion.install "completions/fish/ds.fish"
  end

  test do
    assert_match "0.14.0", shell_output("#{bin}/ds version")
  end
end
