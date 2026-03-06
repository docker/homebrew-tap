strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds@nightly" do
  version "nightly-2026030614-d642ca6"
  sha256 "77bedeef6ad94818f7ac6f786e15d3a0a0e7dcf07f31988f1765fa4531fe8746"

  url "https://github.com/docker/dash-releases/releases/download/nightly/Dash.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle."
  homepage "https://github.com/docker/dash-releases"

  depends_on cask:  "docker/tap/secrets-engine",
             arch:  :arm64,
             macos: ">= :tahoe"

  binary "Dash.app/Contents/MacOS/ds", target: "ds"
  bash_completion "etc/bash_completion.d/ds"
  zsh_completion "share/zsh/site-functions/_ds"
  fish_completion "share/fish/vendor_completions.d/ds.fish"
end
