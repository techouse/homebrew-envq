class Envq < Formula
  desc "Byte-preserving .env query and editing tool"
  homepage "https://techouse.github.io/envq/"
  url "https://github.com/techouse/envq/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "c0a618deee7b27ea3fa34da1edd40ae4c8e3c22f03f1239b0df915a3203d8244"
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
