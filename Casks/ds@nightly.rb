cask "ds@nightly" do
  version "nightly-202603200348-8646c0a"
  sha256 "d8cbb902970b09a010e8b41a84762f195d905e955c8398206ae12d87b427a7a5"

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
