cask "ds@0.17.0" do
  version "0.17.0"
  sha256 "8bcbc233564f4b9ff5e98ed1a36e122babbe06bbb8b3a4003c97752e21004e9f"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds-0.17.0"
  bash_completion "completions/bash/ds", target: "ds-0.17.0"
  fish_completion "completions/fish/ds.fish", target: "ds-0.17.0.fish"
  zsh_completion "completions/zsh/_ds", target: "_ds-0.17.0"

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: ds-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end
