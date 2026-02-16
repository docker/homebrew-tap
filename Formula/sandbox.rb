class Sandbox < Formula
  desc "Docker Sandbox CLI"
  homepage "https://github.com/docker/sandboxes-releases"
  version "0.12.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/docker/sandboxes-releases/releases/download/v#{version}/docker-sandbox-darwin-arm64.gz"
      sha256 "b37bc991161734b99205a61fd099c465f811d76f2484226a4896b49f24b5266c"
    end
  end

  def install
    system "#{HOMEBREW_PREFIX}/bin/sandbox", "daemon", "stop" if File.exist?("#{HOMEBREW_PREFIX}/bin/sandbox")
    binary_name = "docker-sandbox-darwin-arm64"
    bin.install binary_name => "sandbox"
  end

  def caveats
    <<~EOS
      Start the daemon after installing:
        sandbox daemon start -d

      Restart the daemon after upgrading:
        sandbox daemon stop && sandbox daemon start -d
    EOS
  end

  test do
    assert_match "Client Version: v#{version}", shell_output("#{bin}/sandbox version")
  end
end
