cask "ds@0.12.0" do
  version "0.12.0"
  sha256 "df93c0e3cec411e601c2327d286e94331625486d11bb8672100dda0c05c016b0"

  url "https://github.com/docker/dash-releases/releases/download/v#{version}/docker-dash-darwin-arm64.gz"
  name "Docker Dash CLI"
  desc "Docker Dash CLI"
  homepage "https://github.com/docker/dash-releases"

  depends_on cask: "docker/tap/secrets-engine"

  binary "docker-dash-darwin-arm64", target: "ds-0.12.0"

  # Stop any running daemon before starting again
  # (Would fail on first install since binary is not yet in place)
  preflight do
    system_command "/bin/chmod",
                   args:         ["+x", "#{staged_path}/docker-dash-darwin-arm64"],
                   must_succeed: true
    system_command "#{staged_path}/docker-dash-darwin-arm64",
                   args:         ["daemon", "stop"],
                   must_succeed: false
  end

  # Ensure clean reboot of the dash daemon after installation to align client/server versions
  postflight do
    binary_path = "#{HOMEBREW_PREFIX}/bin/ds-0.12.0"
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
