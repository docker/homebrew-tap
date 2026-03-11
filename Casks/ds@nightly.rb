strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds@nightly" do
  version "nightly-202603110940-cb035f9"
  sha256 "353a56f1e1b6b141c69536696b7705ff4119b17e71d08875288e3aec05e4373f"

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
