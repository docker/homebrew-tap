cask "sbx@nightly" do
  version "nightly-202609290318-3f1465e"
  sha256 "3d63023cf4f8bdcf69c602aacf21f9c229d3b3fcaa6b9fa5fe4b873aaa52992e"

  url "https://github.com/docker/sbx-releases/releases/download/#{version}/DockerSandboxes-darwin.dmg"
  name "Docker Sandboxes"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/sbx-releases"

  conflicts_with cask: ["docker/tap/sbx", "docker/tap/sbx@rc"]
  depends_on arch:  :arm64,
             macos: :sonoma

  binary "Sbx.app/Contents/MacOS/sbx", target: "sbx"
  bash_completion "Sbx.app/Contents/Resources/completions/bash/sbx"
  fish_completion "Sbx.app/Contents/Resources/completions/fish/sbx.fish"
  zsh_completion "Sbx.app/Contents/Resources/completions/zsh/_sbx"

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
end
