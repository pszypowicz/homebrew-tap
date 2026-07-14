# Homebrew Tap

Personal Homebrew tap for [pszypowicz](https://github.com/pszypowicz).

## Install

```bash
brew tap pszypowicz/tap
```

## Formulae

| Formula         | Description                                                                |
| --------------- | -------------------------------------------------------------------------- |
| `afm-summarize` | Summarize stdin into one sentence with Apple's on-device Foundation Models |

### afm-summarize

```bash
brew install pszypowicz/tap/afm-summarize
```

Requires macOS 26 (Tahoe) or later on Apple Silicon with Apple Intelligence enabled.

## Casks

| Cask            | Description                                                                            |
| --------------- | -------------------------------------------------------------------------------------- |
| `aerospace-bsp` | AeroSpace window manager (BSP fork) with normalization, resize, and stuck-window fixes |
| `cyclist`       | Text-only Cmd+Tab app switcher with instant Space navigation                           |
| `mic-guard`     | Prevents Bluetooth devices from hijacking the default macOS microphone                 |

### aerospace-bsp

```bash
brew install --cask aerospace-bsp
```

Conflicts with the upstream `nikitabobko/tap/aerospace` cask - uninstall that first.

### cyclist

```bash
brew install --cask cyclist
```

### mic-guard

```bash
brew install --cask mic-guard
```

## Development

Local commits and CI run the same checks through [pre-commit](https://pre-commit.com): `scripts/check-tap-syntax.sh` lints the working tree with `brew style`, `brew readall`, and `brew audit` (the `brew test-bot --only-tap-syntax` set). To catch failures before they are committed:

```bash
brew install pre-commit
pre-commit install
```
