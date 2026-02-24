cask "secrets-engine@0.3.0" do
  version "0.3.0"
  sha256 "2ad429e2b747ca80c0220881fc85bdad7e220356aafc82511f60087d43078269"

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
