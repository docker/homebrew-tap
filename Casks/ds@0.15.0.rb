cask "ds@0.15.0" do
  version "0.15.0"
  sha256 "b81b0d71df1a69d45c479848f78f447b2acf4e07b2e402cd29b22db3e572b327"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds-0.15.0"
  bash_completion "completions/bash/ds", target: "ds-0.15.0"
  fish_completion "completions/fish/ds.fish", target: "ds-0.15.0.fish"
  zsh_completion "completions/zsh/_ds", target: "_ds-0.15.0"

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: ds-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end
