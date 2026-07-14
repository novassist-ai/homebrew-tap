# Novassist-ai Tap

## How do I install these formulae?

`brew install novassist-ai/tap/<formula>`

Or `brew tap novassist-ai/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "novassist-ai/tap"
brew "<formula>"
```

## Formulae

### `vpn-node-builder`

Docker-hosted MyCS VPN node builder CLI. Installs launchers:

| Command | Image |
|---------|--------|
| `vpnb` | `ghcr.io/novassist-ai/vpn-node-builder:latest` |
| `vpnb-dev` | `ghcr.io/novassist-ai/vpn-node-builder:dev` |

```bash
brew trust novassist-ai/tap   # once, if Homebrew requires tap trust
brew install --HEAD vpn-node-builder
vpnb-dev pull && vpnb-dev --help
vpnb pull && vpnb --help
```

Requires Docker. Override with `VPNB_IMAGE`. See
[mycs-node vpn-node-builder docs](https://github.com/novassist-ai/mycs-node/tree/dev/apps/clients/vpn-node-builder/docs/installation.md).

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
