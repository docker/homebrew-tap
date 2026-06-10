cask "sbx@0.28.3" do
  version "0.28.3"
  sha256 "ccb7c0295cfbd0145292b840d44582ea9ccc7d6d11fe627aca61e90cce105544"

  url "https://github.com/docker/sbx-releases/releases/download/v#{version}/DockerSandboxes-darwin.tar.gz"
  name "Docker Sandboxes"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/sbx-releases"

  depends_on arch:  :arm64,
             macos: :tahoe

  binary "bin/sbx", target: "sbx-0.28.3"
  bash_completion "completions/bash/sbx", target: "sbx-0.28.3"
  fish_completion "completions/fish/sbx.fish", target: "sbx-0.28.3.fish"
  zsh_completion "completions/zsh/_sbx", target: "_sbx-0.28.3"

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
