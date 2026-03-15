cask "ds@nightly" do
  version "nightly-202603151345-025274f"
  sha256 "893ae3cfbe2faba3502b0a12bf495304efda81b77cdb35f61d7ae16fb0be7329"

  url "https://github.com/docker/dash-releases/releases/download/nightly/Dash.tar.gz"
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  conflicts_with cask: "docker/tap/ds"
  depends_on arch:  :arm64,
             macos: ">= :tahoe"

  binary "bin/ds", target: "ds"
  bash_completion "completions/bash/ds"
  fish_completion "completions/fish/ds.fish"
  zsh_completion "completions/zsh/_ds"
end
