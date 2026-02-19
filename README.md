# emacs-config

Minimal Emacs config with language support and sensible defaults.

## Features

### Languages

- **Common Lisp** — SLIME with SBCL, Quicklisp, slime-company completion
- **C17 / C++20** — company-clang with `-std=c17` / `-std=c++20`
- **Emacs Lisp / Scheme** — rainbow-delimiters (6 depth colors)
- **FriCAS** — `M-x efricas` for the interactive session

### UI

- Font: IBM Plex Mono (height 170 on macOS, 132 on Windows)
- Theme: tsdh-light
- smart-mode-line with respectful powerline theme
- Line numbers, fill-column indicator at 80, hl-line (underline) in prog-mode
- Starts maximized, no toolbar, no startup screen

### Editing

- BSD C style, 4-space indentation, spaces only
- Trailing whitespace and blank lines stripped on save
- Code folding via `hs-minor-mode` in prog-mode
- `C-a` toggles between indentation and beginning of line
- `C-x 3` splits with the left pane fixed at 90 columns
- Backups saved to `~/.emacs-backups`

### Completion

- Global company-mode (disabled in eshell)

### Packages

`company` `rainbow-delimiters` `smart-mode-line` `smart-mode-line-powerline-theme` `slime` `slime-company`

### Package archives

GNU ELPA, NonGNU ELPA, MELPA — USTC mirror available in `mirror.el`.

## File structure

| File | Purpose |
| --- | --- |
| `emacs.el` | Entry point — faces, custom variables, loads `autoloads.el` |
| `autoloads.el` | Boot sequence — loads `mirror.el` then `custom.el` |
| `mirror.el` | Package archive URLs (upstream / USTC mirror) |
| `custom.el` | Main config — environment, keybindings, UI, editing, languages |

## Setup

### macOS / Linux

```sh
git clone https://github.com/rn7s2/emacs-config.git ~/.emacs-config
ln -s ~/.emacs-config/emacs.el ~/.emacs
```

Then in Emacs: `M-x package-refresh-contents`, `M-x package-install-selected`.

PATH is inherited from your zsh login shell automatically on macOS.

### Windows

Symlink `.emacs` into `%APPDATA%` with `mklink`. A local HTTP proxy (`127.0.0.1:10809`) is configured automatically.

Restart Emacs after setup.
