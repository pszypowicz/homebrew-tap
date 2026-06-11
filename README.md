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

| Cask            | Description                                                             |
| --------------- | ----------------------------------------------------------------------- |
| `aerospace-bsp` | AeroSpace window manager (BSP fork) with normalization and resize fixes |
| `mic-guard`     | Prevents Bluetooth devices from hijacking the default macOS microphone  |

### aerospace-bsp

```bash
brew install --cask aerospace-bsp
```

Conflicts with the upstream `nikitabobko/tap/aerospace` cask - uninstall that first.

### mic-guard

```bash
brew install --cask mic-guard
```
