class Reminder < Formula
  desc "Native Apple Reminders CLI and MCP server"
  homepage "https://github.com/astrosheep-zero/reminders-cli"
  url "https://github.com/astrosheep-zero/reminders-cli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "40b78789d580b8b67d9444ae9aff779909501f257fc458adaadb06868603b7fa"
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
