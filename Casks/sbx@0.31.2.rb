cask "sbx@0.31.2" do
  version "0.31.2"
  sha256 "2b8e6aefb10f37c1a1afa41e07c08e4aaee9eeefe59671ff56b6e6b313b547b5"

  url "https://github.com/docker/sbx-releases/releases/download/v#{version}/DockerSandboxes-darwin.tar.gz"
  name "Docker Sandboxes"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/sbx-releases"

  depends_on arch:  :arm64,
             macos: :sonoma

  binary "bin/sbx", target: "sbx-0.31.2"
  bash_completion "completions/bash/sbx", target: "sbx-0.31.2"
  fish_completion "completions/fish/sbx.fish", target: "sbx-0.31.2.fish"
  zsh_completion "completions/zsh/_sbx", target: "_sbx-0.31.2"

  uninstall_preflight do
    sbx_binary = "#{caskroom_path}/#{version}/bin/sbx"
    next unless File.exist?(sbx_binary)

    system_command sbx_binary,
                   args:         ["daemon", "stop"],
                   print_stderr: false
  end

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: sbx-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end
