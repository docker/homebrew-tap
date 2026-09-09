cask "sbx@0.25.0" do
  version "0.25.0"
  sha256 "4c8ba31df9bdfa469cacef28f92e52ef370cac9df8020d578e26111518a3d3ce"

  url "https://github.com/docker/sbx-releases/releases/download/v#{version}/DockerSandboxes-darwin.tar.gz"
  name "Docker Sandboxes"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/sbx-releases"

  depends_on arch:  :arm64,
             macos: :tahoe

  binary "bin/sbx", target: "sbx-0.25.0"
  bash_completion "completions/bash/sbx", target: "sbx-0.25.0"
  fish_completion "completions/fish/sbx.fish", target: "sbx-0.25.0.fish"
  zsh_completion "completions/zsh/_sbx", target: "_sbx-0.25.0"

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

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: sbx-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end
