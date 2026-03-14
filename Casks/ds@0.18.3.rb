cask "ds@0.18.3" do
  version "0.18.3"
  sha256 "f46ea3f92106ef24b6486733fe3395b52169b491c362c95b170a4dc28efb7085"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds-0.18.3"
  bash_completion "completions/bash/ds", target: "ds-0.18.3"
  fish_completion "completions/fish/ds.fish", target: "ds-0.18.3.fish"
  zsh_completion "completions/zsh/_ds", target: "_ds-0.18.3"

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: ds-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end
