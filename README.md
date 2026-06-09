# Homebrew Tap

Personal Homebrew tap for [pszypowicz](https://github.com/pszypowicz).

## Install

```bash
brew tap pszypowicz/tap
```

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
