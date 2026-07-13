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

### `node-builder`

Docker-hosted MyCS node builder CLI. Installs launchers:

| Command | Image |
|---------|--------|
| `nb` | `ghcr.io/novassist-ai/node-builder:latest` |
| `nb-dev` | `ghcr.io/novassist-ai/node-builder:dev` |

```bash
brew install --HEAD node-builder
nb pull && nb --help
nb-dev pull && nb-dev --help
```

Requires Docker. Override with `NB_IMAGE`. See
[mycs-node node-builder docs](https://github.com/novassist-ai/mycs-node/tree/dev/apps/clients/node-builder/docs/installation.md).

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
