strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds@nightly" do
  version "nightly-202603111032-738e082"
  sha256 "3a59850c2fbb79b7990ab1212c3eeb09df2d8368c72393e407e246a8d34eb9bf"

  url "https://github.com/docker/dash-releases/releases/download/nightly/Dash.tar.gz",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  conflicts_with cask: "docker/tap/ds"
  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds"
  bash_completion "completions/bash/ds"
  fish_completion "completions/fish/ds.fish"
  zsh_completion "completions/zsh/_ds"
end
