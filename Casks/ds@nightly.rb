cask "ds@nightly" do
  version "nightly-202603220350-b240327"
  sha256 "99b547c28f5564f6550a5c62a79fd094ff25bb72a54266bb40d31347c509773c"

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
