cask "sbx@nightly" do
  version "nightly-202603250349-1536522"
  sha256 "89fb45e7a58ba1405fa9cdc527ffddf4563aacf4ef8ebe240160327469fb7b61"

  url "https://github.com/docker/sbx-releases/releases/download/nightly/DockerSandboxes.tar.gz"
  name "Docker Sandboxes"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/sbx-releases"

  conflicts_with cask: "docker/tap/sbx"
  depends_on arch:  :arm64,
             macos: ">= :tahoe"

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
