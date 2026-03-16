cask "ds@0.18.5" do
  version "0.18.5"
  sha256 "70fa69be8934cbd77ade3a561ccfc857999f410d82723ca816748095889d3fa7"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds-0.18.5"
  bash_completion "completions/bash/ds", target: "ds-0.18.5"
  fish_completion "completions/fish/ds.fish", target: "ds-0.18.5.fish"
  zsh_completion "completions/zsh/_ds", target: "_ds-0.18.5"

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
