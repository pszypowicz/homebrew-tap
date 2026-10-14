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
| `optiprime`     | Terminal UI for keeping a directory of Azure DevOps repositories in sync   |
| `tmux-gestures` | tmux fork with trackpad gesture reporting (DEC 2035)                       |

### afm-summarize

```bash
brew install pszypowicz/tap/afm-summarize
```

Requires macOS 26 (Tahoe) or later on Apple Silicon with Apple Intelligence enabled.

### optiprime

```bash
brew install pszypowicz/tap/optiprime
```

Prebuilt for macOS and Linux on both arm64 and amd64.

### tmux-gestures

```bash
brew install pszypowicz/tap/tmux-gestures
```

Decodes the gesture escape sequences sent by `ghostty-personal` into keys you can bind, such as `Swipe2Left` and `PinchIn`. Conflicts with the `tmux` formula - uninstall that first.

## Casks

| Cask               | Description                                                                              |
| ------------------ | ---------------------------------------------------------------------------------------- |
| `aerospace-bsp`    | AeroSpace window manager (BSP fork) with normalization, resize, and stuck-window fixes   |
| `bright-sync`      | Mirrors built-in display brightness to external displays over DDC/CI                     |
| `cyclist`          | Text-only Cmd+Tab app switcher with instant Space navigation                             |
| `ghostty-gestures` | Ghostty terminal fork with configurable trackpad gestures (pinch, two-finger double-tap) |
| `ghostty-personal` | Ghostty terminal fork with trackpad gestures and gesture reporting (DEC 2035)            |
| `mic-guard`        | Prevents Bluetooth devices from hijacking the default macOS microphone                   |
| `pager`            | Click-to-focus, self-clearing notifications for tmux                                     |
| `sequester`        | Secure Enclave SSH agent                                                                 |

### aerospace-bsp

```bash
brew install --cask aerospace-bsp
```

Conflicts with the upstream `nikitabobko/tap/aerospace` cask - uninstall that first.

### bright-sync

```bash
brew install --cask bright-sync
```

Requires macOS 26 (Tahoe) or later on Apple Silicon. Also installs the `brightsync` command-line tool.

### cyclist

```bash
brew install --cask cyclist
```

### ghostty-gestures

```bash
brew install --cask ghostty-gestures
```

Ghostty fork with config-driven trackpad gestures. Conflicts with the official `ghostty` and `ghostty@tip` casks - uninstall those first. Ad-hoc signed, so it ships with auto-update disabled.

### ghostty-personal

```bash
brew install --cask ghostty-personal
```

Ghostty fork with config-driven trackpad gestures (pinch, two-finger double-tap, swipes) and gesture reporting, which `tmux-gestures` turns into bindable keys. Conflicts with the official `ghostty` and `ghostty@tip` casks and with `ghostty-gestures`, because they all install `Ghostty.app` - uninstall those first. The in-app updater is compiled out, so updates come through `brew upgrade`.

### mic-guard

```bash
brew install --cask mic-guard
```

### pager

```bash
brew install --cask pager
```

Also installs the `pager` command-line tool.

### sequester

```bash
brew install --cask sequester
```

Requires macOS 26 (Tahoe) or later. Also installs the `sequester` command-line tool.

## Development

Local commits and CI run the same checks through [pre-commit](https://pre-commit.com): `scripts/check-tap-syntax.sh` lints the working tree with `brew style`, `brew readall`, and `brew audit` (the `brew test-bot --only-tap-syntax` set). To catch failures before they are committed:

```bash
brew install pre-commit
pre-commit install
```
