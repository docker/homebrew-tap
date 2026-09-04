cask "sbx@rc" do
  version "0.42.0-rc5"
  sha256 "af36980cfc4f863a12c52288f896fb31883dd9fcf4f06abd4dd0ff4ed66c7f7c"

  url "https://github.com/docker/sbx-releases/releases/download/v#{version}/DockerSandboxes-darwin.dmg"
  name "Docker Sandboxes"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/sbx-releases"

  conflicts_with cask: ["docker/tap/sbx", "docker/tap/sbx@nightly"]
  depends_on arch:  :arm64,
             macos: :sonoma

  binary "bin/sbx", target: "sbx"
  bash_completion "completions/bash/sbx"
  fish_completion "completions/fish/sbx.fish"
  zsh_completion "completions/zsh/_sbx"

  uninstall_preflight do
    sbx_binary = "#{caskroom_path}/#{version}/bin/sbx"
    next unless File.exist?(sbx_binary)

    system_command sbx_binary,
                   args:         ["daemon", "stop"],
                   print_stderr: false
  end
end
