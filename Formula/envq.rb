class Envq < Formula
  desc "Byte-preserving .env query and editing tool"
  homepage "https://techouse.github.io/envq/"
  url "https://github.com/techouse/envq/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "afa1fedbfeda3862605cc5dcf83a64f0f1ed444ee2c20f2b03b4fedfd176fd3c"
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
