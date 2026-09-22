cask "sbx@0.45.1" do
  version "0.45.1"
  sha256 "f4ef0cc087a8fc7597d591d8fc2df2591dfbf348cdfe3f50354b4d961593535e"

  url "https://github.com/docker/sbx-releases/releases/download/v#{version}/DockerSandboxes-darwin.dmg"
  name "Docker Sandboxes"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/sbx-releases"

  depends_on arch:  :arm64,
             macos: :sonoma

  binary "Sbx.app/Contents/MacOS/sbx", target: "sbx-0.45.1"
  bash_completion "Sbx.app/Contents/Resources/completions/bash/sbx", target: "sbx-0.45.1"
  fish_completion "Sbx.app/Contents/Resources/completions/fish/sbx.fish", target: "sbx-0.45.1.fish"
  zsh_completion "Sbx.app/Contents/Resources/completions/zsh/_sbx", target: "_sbx-0.45.1"

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
