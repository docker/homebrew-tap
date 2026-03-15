cask "ds@0.18.4" do
  version "0.18.4"
  sha256 "63ca0866c9649132a2daa856cba941c41e171dcae274d951f07ab695e33695d9"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds-0.18.4"
  bash_completion "completions/bash/ds", target: "ds-0.18.4"
  fish_completion "completions/fish/ds.fish", target: "ds-0.18.4.fish"
  zsh_completion "completions/zsh/_ds", target: "_ds-0.18.4"

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: ds-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end
