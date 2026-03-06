strategy_path = File.expand_path("../custom_download_strategy", __dir__)
require strategy_path if File.exist?("#{strategy_path}.rb")

cask "ds" do
  version "0.13.0"
  sha256 "60847835245aafce7d280df177d3ef2711e1fba396dafc5b190e77b612bc2431"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/Dash.dmg",
      using: GitHubPrivateRepositoryReleaseDownloadStrategy
  name "Docker Dash CLI"
  desc "Docker Dash CLI"
  homepage "https://github.com/docker/dash-releases"

  conflicts_with cask: "docker/tap/ds@nightly"
  depends_on cask:  "docker/tap/secrets-engine",
             arch:  :arm64,
             macos: ">= :tahoe"

  binary "Dash.app/Contents/MacOS/ds", target: "ds"
end
