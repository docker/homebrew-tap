cask "sbx@nightly" do
  version "nightly-202608210323-9a702c7"
  sha256 "a6a4b185d00c37939d8adea2d9a671cfe4449e3fe70faefe0f1f3f4031422bd9"

  url "https://github.com/docker/sbx-releases/releases/download/#{version}/DockerSandboxes-darwin.dmg"
  name "Docker Sandboxes"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/sbx-releases"

  conflicts_with cask: ["docker/tap/sbx", "docker/tap/sbx@rc"]
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
