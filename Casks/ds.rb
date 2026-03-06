strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds" do
  version "nightly"
  sha256 "26fd3e474f7f79b7b4344957ec72589b2fbef529ab2c44dad128bc72066a31a6"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle."
  homepage "https://github.com/docker/dash-releases"

  depends_on cask:  "docker/tap/secrets-engine",
             arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds"
  bash_completion "etc/bash_completion.d/ds"
  zsh_completion "share/zsh/site-functions/_ds"
  fish_completion "share/fish/vendor_completions.d/ds.fish"
end
