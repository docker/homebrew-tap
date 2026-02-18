cask "secrets-engine" do
  version "0.1.0"
  sha256 "5405dcf7da06bf4b740efd9075ae37f5cd81b040ec23f599dee2747437cb2adc"

  url "https://github.com/docker/secrets-engine/releases/download/v#{version}/DockerSecretsEngine.dmg"
  name "Docker Secrets Engine"
  desc "Docker credential management tool"
  homepage "https://github.com/docker/secrets-engine"

  app "DockerSecretsEngine.app"

  postflight do
    system_command "#{appdir}/DockerSecretsEngine.app/Contents/MacOS/setup",
                   args: ["install"]
  end

  uninstall_preflight do
    system_command "#{appdir}/DockerSecretsEngine.app/Contents/MacOS/setup",
                   args: ["uninstall"]
  end

  zap trash: [
    "~/Library/Application Support/com.docker.secrets-engine",
    "~/Library/Caches/com.docker.secrets-engine",
    "~/Library/Preferences/com.docker.secrets-engine.plist",
  ]
end
