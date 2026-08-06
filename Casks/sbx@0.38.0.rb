cask "sbx@0.38.0" do
  version "0.38.0"
  sha256 "6fc2306598b8185228d920c1fd0fc09695d8022ad785a5b6655752f1145e7d3c"

  url "https://github.com/docker/sbx-releases/releases/download/v#{version}/DockerSandboxes-darwin.dmg"
  name "Docker Sandboxes"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/sbx-releases"

  depends_on arch:  :arm64,
             macos: :sonoma

  binary "bin/sbx", target: "sbx-0.38.0"
  bash_completion "completions/bash/sbx", target: "sbx-0.38.0"
  fish_completion "completions/fish/sbx.fish", target: "sbx-0.38.0.fish"
  zsh_completion "completions/zsh/_sbx", target: "_sbx-0.38.0"

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
