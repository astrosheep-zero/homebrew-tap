# astrosheep-zero Homebrew tap

## reminder

Native Apple Reminders CLI and local MCP server. Requires Apple silicon, macOS 26+, and a Swift 6.2+ toolchain.

```sh
brew install astrosheep-zero/tap/reminder
reminder --help
reminder setup
```

For an MCP client, use `reminder` as the command and `["mcp"]` as its arguments. Use an absolute executable path if the client does not inherit your shell PATH.

Builds are compiled from the tagged source and ad-hoc signed locally. Installation does not request permission or modify keychains. Upgrades can require granting Reminders access again. Only `setup` requests access.

Source, limitations and documentation: [astrosheep-zero/reminders-cli](https://github.com/astrosheep-zero/reminders-cli).
