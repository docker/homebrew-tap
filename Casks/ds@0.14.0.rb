strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds@0.14.0" do
  version "0.14.0"
  sha256 "260f3425ac0368b16851ddeb67f91061c66764bdc40901e111a983eab235cd14"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Dash by Docker"
  desc "Build, run, and govern agents across the software development lifecycle"
  homepage "https://github.com/docker/dash-releases"

  depends_on cask:  "docker/tap/secrets-engine",
             arch:  :arm64,
             macos: ">= :tahoe"

  binary "Dash by Docker.app/Contents/MacOS/ds", target: "ds-0.14.0"
  bash_completion "Dash by Docker.app/Contents/Resources/completions/bash/ds"
  fish_completion "Dash by Docker.app/Contents/Resources/completions/fish/ds.fish"
  zsh_completion "Dash by Docker.app/Contents/Resources/completions/zsh/_ds"

  caveats <<~EOS
    Since a version-specific cask was installed, the binary to use is: ds-#{version}
    Note: Prompt for update will be disabled for version-specific installations.
  EOS
end

