strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds@0.16.0" do
  version "0.16.0"
  sha256 "a7a06f156fa03f310146455009f8bea18ff44bb2b9c5ff81643a57dfe3957be1"

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
