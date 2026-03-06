strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds@nightly" do
  version "nightly"
  sha256 "568375b1d586e6719b6f2549139caacba4172ff1409bbe58a9341aa5c30b2d26"

  url "https://github.com/docker/dash-releases/releases/download/#{version}/Dash.dmg",
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
