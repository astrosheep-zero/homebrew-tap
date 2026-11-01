class Reminder < Formula
  desc "Native Apple Reminders CLI and MCP server"
  homepage "https://github.com/astrosheep-zero/reminders-cli"
  url "https://github.com/astrosheep-zero/reminders-cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f69a25614b92e0a33bb95910efed8a523da5472dabcccfc6ecf4831e57048084"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :tahoe
  allow_network_access! :build

  def install
    ENV["SIGNING_IDENTITY"] = "-"
    system "bash", "scripts/build-app.sh", "--disable-sandbox"
    libexec.install "dist/Reminder.app"
    bin.write_exec_script libexec/"Reminder.app/Contents/MacOS/reminder"
  end

  def caveats
    <<~EOS
      Run `reminder setup` yourself to request Reminders full access.
      MCP clients should run `#{opt_bin}/reminder mcp`.
      This source build uses ad-hoc signing; upgrades may require authorization again.
      Private ReminderKit APIs require macOS 26+ and may change between OS releases.
    EOS
  end

  test do
    output = JSON.parse(shell_output("#{bin}/reminder --help --json"))
    assert_equal "ok", output.fetch("status")
    assert_match "reminder", output.fetch("result").fetch("help")
    system "/usr/bin/codesign", "--verify", "--strict", libexec/"Reminder.app"
  end
end
