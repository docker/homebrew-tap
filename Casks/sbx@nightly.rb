cask "sbx@nightly" do
  version "nightly-202605180429-c2da5ce"
  sha256 "19c683b083e66c9f55d8238eef49f1f92bf81bdc0500bae3238de0f9e4d83224"

  url "https://github.com/docker/sbx-releases/releases/download/nightly/DockerSandboxes-darwin.tar.gz"
  name "Docker Sandboxes"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/sbx-releases"

  conflicts_with cask: "docker/tap/sbx"
  depends_on arch:  :arm64,
             macos: ">= :sonoma"

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
