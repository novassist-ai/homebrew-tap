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
brew tap novassist-ai/tap
brew install vpn-node-builder

vpnb --help                   # prod :latest
vpnb-dev --help               # dig tip :dev
vpnb update                   # re-pull :latest
vpnb-dev update               # re-pull :dev
```

Optional tip install of the launcher script from the `dev` branch:

```bash
brew install --HEAD vpn-node-builder
```

Requires Docker. Override with `VPNB_IMAGE`. See
[mycs-node vpn-node-builder docs](https://github.com/novassist-ai/mycs-node/tree/main/apps/clients/vpn-node-builder/docs/installation.md).

The stable formula is bumped automatically from `mycs-node` after each successful
prod vpn-node-builder release (`vpnb_X.Y.Z`). Dig image tips stay on `:dev` and
do not change this formula.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
