cask "sandbox@0.12.0" do
  version "0.12.0"
  sha256 "df93c0e3cec411e601c2327d286e94331625486d11bb8672100dda0c05c016b0"

  url "https://github.com/docker/sandboxes-releases/releases/download/v#{version}/docker-sandbox-darwin-arm64.gz"
  name "Docker Sandbox CLI"
  desc "Docker Sandbox CLI"
  homepage "https://github.com/docker/sandboxes-releases"

  depends_on cask: "docker/tap/secrets-engine"

  binary "docker-sandbox-darwin-arm64", target: "sandbox"

  # Stop any running daemon before starting again
  # (Would fail on first install since binary is not yet in place)
  preflight do
    system_command "/bin/chmod",
                   args:         ["+x", "#{staged_path}/docker-sandbox-darwin-arm64"],
                   must_succeed: true
    system_command "#{staged_path}/docker-sandbox-darwin-arm64",
                   args:         ["daemon", "stop"],
                   must_succeed: false
  end

  # Ensure clean reboot of the sandbox daemon after installation to align client/server versions
  postflight do
    binary_path = "#{HOMEBREW_PREFIX}/bin/sandbox"
    system_command binary_path,
                   args:         ["daemon", "stop"],
                   must_succeed: true
    system_command binary_path,
                   args:         ["daemon", "start", "-d"],
                   must_succeed: true
  end
end
