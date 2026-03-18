cask "ds@nightly" do
  version "nightly-202603180352-a97c2c2"
  sha256 "f094c35177a057fcffe1debf9bd2c0cc75243b24a418742db06421fc0ced3f73"

  url "https://github.com/docker/dash-releases/releases/download/nightly/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  conflicts_with cask: "docker/tap/ds"
  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds"
  bash_completion "completions/bash/ds"
  fish_completion "completions/fish/ds.fish"
  zsh_completion "completions/zsh/_ds"

  uninstall_preflight do
    ds_binary = "#{caskroom_path}/#{version}/bin/ds"
    next unless File.exist?(ds_binary)

    system_command ds_binary,
                   args:         ["daemon", "stop"],
                   print_stderr: false
  end
end
