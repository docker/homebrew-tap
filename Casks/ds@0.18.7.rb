cask "ds@0.18.7" do
  version "0.18.7"
  sha256 "54585c5575e3a96f3357efa250ebf11d700cc9abdc88e39d1964726a92ff609a"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds-0.18.7"
  bash_completion "completions/bash/ds", target: "ds-0.18.7"
  fish_completion "completions/fish/ds.fish", target: "ds-0.18.7.fish"
  zsh_completion "completions/zsh/_ds", target: "_ds-0.18.7"

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
