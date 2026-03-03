cask "ds@0.13.0" do
  version "0.13.0"
  sha256 "8f73a12ef387e40b25235e66a83520f9c57eb5c34a1e9879cac77735e1a07b8e"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/ds-darwin-arm64.tar.gz"
  name "Docker Dash CLI"
  desc "Docker Dash CLI"
  homepage "https://github.com/docker/dash-releases"

  depends_on cask: "docker/tap/secrets-engine"

  binary "bin/ds", target: "ds@0.13.0"

  # Stop any running daemon before starting again
  # (Would fail on first install since binary is not yet in place)
  preflight do
    system_command "/bin/chmod",
                   args:         ["+x", "\#{staged_path}/bin/ds"],
                   must_succeed: true
    system_command "\#{staged_path}/bin/ds",
                   args:         ["daemon", "stop"],
                   must_succeed: false
  end

  # Ensure clean reboot of the Dash daemon after installation to align client/server versions
  postflight do
    binary_path = "\#{HOMEBREW_PREFIX}/bin/ds@0.13.0"
    system_command binary_path,
                   args:         ["daemon", "stop"],
                   must_succeed: true
    system_command binary_path,
                   args:         ["daemon", "start", "-d"],
                   must_succeed: true
  end
  caveats <<~EOS
  Since a version-specific cask was installed, the binary to use is: ds-#{version}
  Note: Prompt for update will be disabled for version-specific installations.
EOS
end
