cask "ds@0.18.6" do
  version "0.18.6"
  sha256 "eccb3f1bcaa373a43f431201da0de29537e04041414a30158dd8e89e41e64136"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds-0.18.6"
  bash_completion "completions/bash/ds", target: "ds-0.18.6"
  fish_completion "completions/fish/ds.fish", target: "ds-0.18.6.fish"
  zsh_completion "completions/zsh/_ds", target: "_ds-0.18.6"

  uninstall_preflight do
    ds_binary = "#{caskroom_path}/#{version}/bin/ds"
    next unless File.exist?(ds_binary)

    system_command ds_binary,
                   args:         ["daemon", "stop"],
                   print_stderr: false
  end

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: ds-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end
