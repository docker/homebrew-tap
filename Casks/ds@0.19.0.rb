cask "ds@0.19.0" do
  version "0.19.0"
  sha256 "61b4736a98ba979c6370531bf481786ae70ae86ceff88d677019f76e18494feb"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds-0.19.0"
  bash_completion "completions/bash/ds", target: "ds-0.19.0"
  fish_completion "completions/fish/ds.fish", target: "ds-0.19.0.fish"
  zsh_completion "completions/zsh/_ds", target: "_ds-0.19.0"

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
