cask "ds" do
  version "0.18.2"
  sha256 "0a72d036de6cdb5a95ca0e033badd1a4f1b34ddb9f7123123e81ec8f9d8f896c"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  conflicts_with cask: "docker/tap/ds@nightly"
  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds"
  bash_completion "completions/bash/ds"
  fish_completion "completions/fish/ds.fish"
  zsh_completion "completions/zsh/_ds"
end
