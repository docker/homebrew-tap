cask "secrets-engine@0.3.2" do
  version "0.3.2"
  sha256 "f70d57f44d39fdaeb2cb101be76803699eeddefdd515a588287ecc2981ca331a"

  url "https://github.com/docker/secrets-engine/releases/download/v#{version}/DockerSecretsEngine.dmg"
  name "Docker Secrets Engine"
  desc "Docker credential management tool"
  homepage "https://github.com/docker/secrets-engine"

  app "DockerSecretsEngine.app"

  preflight do
    app_path = "#{appdir}/DockerSecretsEngine.app"
    if File.directory?(app_path)
      system_command "#{app_path}/Contents/MacOS/setup",
                     args:         ["uninstall"],
                     must_succeed: false
      FileUtils.rm_r app_path
    end
  end

  postflight do
    system_command "#{appdir}/DockerSecretsEngine.app/Contents/MacOS/setup",
                   args: ["install"]
  end

  uninstall_preflight do
    setup = "#{appdir}/DockerSecretsEngine.app/Contents/MacOS/setup"
    system_command setup, args: ["uninstall"] if File.exist?(setup)
  end

  zap trash: [
    "~/Library/Application Support/com.docker.secrets-engine",
    "~/Library/Caches/com.docker.secrets-engine",
    "~/Library/Preferences/com.docker.secrets-engine.plist",
  ]
end
