cask "sbx@nightly" do
  version "nightly-202603290400-e629f15"
  sha256 "82eb0f153f4a124cdef3a3be4b92eb5bf3d1e71e777b3c85a22a9689b467a9f3"

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
