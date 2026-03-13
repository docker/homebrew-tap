cask "ds@0.18.2" do
  version "0.18.2"
  sha256 "0a72d036de6cdb5a95ca0e033badd1a4f1b34ddb9f7123123e81ec8f9d8f896c"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds-0.18.2"
  bash_completion "completions/bash/ds", target: "ds-0.18.2"
  fish_completion "completions/fish/ds.fish", target: "ds-0.18.2.fish"
  zsh_completion "completions/zsh/_ds", target: "_ds-0.18.2"

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: ds-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end
