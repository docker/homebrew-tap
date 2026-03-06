strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds@nightly" do
  version "nightly-2026030613-8ae844f"
  sha256 "c0b49e28aa97c9e0512389a54248a9e14cc3e8230b685909a57d495454c0418d"

  url "https://github.com/docker/dash-releases/releases/download/nightly/Dash.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle."
  homepage "https://github.com/docker/dash-releases"

  depends_on cask:  "docker/tap/secrets-engine",
             arch:  :arm64,
             macos: ">= :tahoe"

  binary "Dash.app/Contents/MacOS/ds", target: "ds-nightly"
  bash_completion "etc/bash_completion.d/ds"
  zsh_completion "share/zsh/site-functions/_ds"
  fish_completion "share/fish/vendor_completions.d/ds.fish"
end
