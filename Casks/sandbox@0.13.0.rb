cask "sandbox@0.13.0" do
  version "0.13.0"
  sha256 "262bceea7fea87f632b6cd4b7ffc0dc5c3c830aaa284ad40cfcd444dd7010564"

  url "https://github.com/docker/sandboxes-releases/releases/download/v#{version}/docker-sandbox-darwin-arm64.tar.gz"
  name "Docker Sandbox CLI"
  desc "Docker Sandbox CLI"
  homepage "https://github.com/docker/sandboxes-releases"

  depends_on cask: "docker/tap/secrets-engine"

  binary "bin/sandbox", target: "sandbox"

  # Stop any running daemon before starting again
  # (Would fail on first install since binary is not yet in place)
  preflight do
    system_command "/bin/chmod",
                   args:         ["+x", "#{staged_path}/bin/sandbox"],
                   must_succeed: true
    system_command "#{staged_path}/bin/sandbox",
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
