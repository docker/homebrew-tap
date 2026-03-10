strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds@nightly" do
  version "nightly-2026031021-6142890"
  sha256 :no_check

  url "https://github.com/docker/dash-releases/releases/download/nightly/Dash.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  conflicts_with cask: "docker/tap/ds"
  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "Dash.app/Contents/MacOS/ds", target: "ds"
  bash_completion "Dash.app/Contents/Resources/completions/bash/ds"
  fish_completion "Dash.app/Contents/Resources/completions/fish/ds.fish"
  zsh_completion "Dash.app/Contents/Resources/completions/zsh/_ds"
end
