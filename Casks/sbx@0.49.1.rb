cask "sbx@0.49.1" do
  version "0.49.1"
  sha256 "42d50e90d3d6054d4eab20fabc9223e15e2fda15004de6007e5352e77018a219"

  url "https://github.com/docker/sbx-releases/releases/download/v#{version}/DockerSandboxes-darwin.dmg"
  name "Docker Sandboxes"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/sbx-releases"

  depends_on arch:  :arm64,
             macos: :sonoma

  binary "Sbx.app/Contents/MacOS/sbx", target: "sbx-0.49.1"
  bash_completion "Sbx.app/Contents/Resources/completions/bash/sbx", target: "sbx-0.49.1"
  zsh_completion "Sbx.app/Contents/Resources/completions/zsh/_sbx", target: "_sbx-0.49.1"
  fish_completion "Sbx.app/Contents/Resources/completions/fish/sbx.fish", target: "sbx-0.49.1.fish"

  uninstall_preflight_steps do
    if_path_exists "#{version}/Sbx.app/Contents/MacOS/sbx", base: :caskroom_path do
      symlink ".", ".user-home", source_base: :home, overwrite: true
      run "/bin/sh",
          args:           ["-c", 'HOME=$(/usr/bin/readlink "$1"); export HOME; exec "$2" daemon stop',
                           "sbx-uninstall", "{{staged_path}}/.user-home",
                           "{{staged_path}}/Sbx.app/Contents/MacOS/sbx"],
          print_stderr:   false,
          writable_paths: ["Library/Application Support/com.docker.sandboxes",
                           ".sbx/run"],
          writable_base:  :home,
          network_access: true
    end
  end

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: sbx-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end
