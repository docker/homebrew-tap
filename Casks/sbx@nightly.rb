cask "sbx@nightly" do
  version "nightly-202603300814-f116032"
  sha256 "63fec3f990b366002f1ab4514da9078f53c72fb9af7de597b0671af99c04603b"

  url "https://github.com/docker/sbx-releases/releases/download/nightly/DockerSandboxes-darwin.tar.gz"
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
