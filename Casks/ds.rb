cask "ds" do
  version "0.13.0"
  sha256 "262bceea7fea87f632b6cd4b7ffc0dc5c3c830aaa284ad40cfcd444dd7010564"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/docker-dash-darwin-arm64.tar.gz"
  name "Docker Dash CLI"
  desc "Docker Dash CLI"
  homepage "https://github.com/docker/dash-releases"

  depends_on cask: "docker/tap/secrets-engine"

  binary "bin/ds", target: "ds"

  # Stop any running daemon before starting again
  # (Would fail on first install since binary is not yet in place)
  preflight do
    system_command "/bin/chmod",
                   args:         ["+x", "#{staged_path}/bin/ds"],
                   must_succeed: true
    system_command "#{staged_path}/bin/ds",
                   args:         ["daemon", "stop"],
                   must_succeed: false
  end

  # Ensure clean reboot of the dash daemon after installation to align client/server versions
  postflight do
    binary_path = "#{HOMEBREW_PREFIX}/bin/ds"
    system_command binary_path,
                   args:         ["daemon", "stop"],
                   must_succeed: true
    system_command binary_path,
                   args:         ["daemon", "start", "-d"],
                   must_succeed: true
  end
end
