strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds@nightly" do
  version "nightly-2026030613-d09845d"
  sha256 "62c30edc0d948ae2fce7d4d6db864d862fdd97838ded3ac90b9a4b15d7e6d05b"

  url "https://github.com/docker/dash-releases/releases/download/nightly/Dash.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle."
  homepage "https://github.com/docker/dash-releases"

  depends_on cask:  "docker/tap/secrets-engine",
             arch:  :arm64,
             macos: ">= :tahoe"

  binary "Dash.app/Contents/MacOS/ds-nightly", target: "ds-nightly"
  bash_completion "etc/bash_completion.d/ds-nightly"
  zsh_completion "share/zsh/site-functions/_ds-nightly"
  fish_completion "share/fish/vendor_completions.d/ds-nightly.fish"
end
