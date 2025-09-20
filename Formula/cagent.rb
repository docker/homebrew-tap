class Cagent < Formula
  desc "Agent Builder and Runtime by Docker Engineering"
  homepage "https://github.com/docker/cagent"
  url "https://github.com/docker/cagent/archive/refs/tags/v1.3.6.tar.gz"
  sha256 "7bf46d22ef621f174c0ef38465610a9a275b2a94af6677f58b700088f962397f"
  license "Apache-2.0"
  head "https://github.com/docker/cagent.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -s -w
      -X github.com/docker/cagent/pkg/version.Version=v#{version}
      -X github.com/docker/cagent/pkg/version.Commit=#{tap.user}
      -X github.com/docker/cagent/pkg/version.BuildTime=#{Time.now.iso8601}
    ]

    system "go", "build", *std_go_args(ldflags:), "./main.go"

    generate_completions_from_executable(bin/"cagent", "completion")
  end

  test do
    assert_match "cagent version v#{version}", shell_output("#{bin}/cagent version")
  end
end