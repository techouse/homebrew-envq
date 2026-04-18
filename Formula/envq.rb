class Envq < Formula
  desc "Byte-preserving .env query and editing tool"
  homepage "https://techouse.github.io/envq/"
  url "https://github.com/techouse/envq/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "73f8bc6ca3417dfa34b4a3e8b40cc83afdc4052611b9394e87e96f7390ef27cc"
  license "BSD-3-Clause"
  head "https://github.com/techouse/envq.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")

    generate_completions_from_executable(bin/"envq", "completion")
  end

  test do
    env_file = testpath/".env"
    env_file.write "A=1\n"

    assert_equal "1", shell_output("#{bin}/envq get A #{env_file}")

    system bin/"envq", "set", "A", "2", env_file
    assert_equal "A=2\n", env_file.read
  end
end
