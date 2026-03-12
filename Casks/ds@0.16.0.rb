strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds@0.16.0" do
  version "0.16.0"
  sha256 "707ae37109499205c9becbec92c336ab60738d5d99af4274316c4e5da80c9e45"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds-0.16.0"
  bash_completion "completions/bash/ds", target: "ds-0.16.0"
  fish_completion "completions/fish/ds.fish", target: "ds-0.16.0.fish"
  zsh_completion "completions/zsh/_ds", target: "_ds-0.16.0"

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: ds-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end
