cask "sbx@nightly" do
  version "nightly-202609090317-df5c96b"
  sha256 "d4e23458dd9cb038d0fe5bc1bf05ff70f1598c4ffd4fa69f6eb41ab108582bf5"

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

  uninstall_preflight_steps do
    if_path_exists "#{version}/bin/sbx", base: :caskroom_path do
      symlink ".", ".user-home", source_base: :home, overwrite: true
      run "/bin/sh",
          args:           ["-c", 'HOME=$(/usr/bin/readlink "$1"); export HOME; exec "$2" daemon stop',
                           "sbx-uninstall", "{{staged_path}}/.user-home", "{{staged_path}}/bin/sbx"],
          print_stderr:   false,
          writable_paths: ["Library/Application Support/com.docker.sandboxes",
                           ".sbx/run"],
          writable_base:  :home,
          network_access: true
    end
  end
end
