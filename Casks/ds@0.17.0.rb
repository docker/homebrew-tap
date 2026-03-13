strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds@0.17.0" do
  version "0.17.0"
  sha256 "4da32a13ee6865b1ac395057948b7fdcbae47fafcf835ed38f3c82a7561060c4"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds-0.17.0"
  bash_completion "completions/bash/ds", target: "ds-0.17.0"
  fish_completion "completions/fish/ds.fish", target: "ds-0.17.0.fish"
  zsh_completion "completions/zsh/_ds", target: "_ds-0.17.0"

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: ds-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end
