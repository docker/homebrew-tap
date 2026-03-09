strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds" do
  version "0.14.0"
  sha256 "0cda57098f93abe7003909135afc3ee72187c61df36c1c6903fb9a0f37718ff7"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  conflicts_with cask: "docker/tap/ds@nightly"
  depends_on cask:  "docker/tap/secrets-engine",
             arch:  :arm64,
             macos: ">= :tahoe"

  binary "Dash by Docker.app/Contents/MacOS/ds", target: "ds"
  bash_completion "Dash by Docker.app/Contents/Resources/completions/bash/ds"
  fish_completion "Dash by Docker.app/Contents/Resources/completions/fish/ds.fish"
  zsh_completion "Dash by Docker.app/Contents/Resources/completions/zsh/_ds"
end
