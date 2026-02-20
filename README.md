# emacs-config

Minimal Emacs configuration with language support and sensible defaults.

## Features

### Languages

- **Common Lisp** — SLIME with SBCL, Quicklisp integration, slime-company completion (`slime-fancy`, `slime-quicklisp`, `slime-asdf`)
- **C17 / C++20** — company-clang with `-std=c17` / `-std=c++20`
- **Lisp dialects** — rainbow-delimiters (6 depth colors) in Common Lisp, Emacs Lisp, Scheme, and `*scratch*`
- **FriCAS** — `M-x efricas` auto-discovers the FriCAS installation and launches an interactive session via the official elisp integration

### UI

- Font: Google Sans Code (height 170 on macOS, 132 on Windows), line spacing 0.23
- Theme: tsdh-light by default; auto-switches to wombat on macOS when system dark mode is active
- smart-mode-line with respectful powerline theme
- Line numbers, fill-column indicator at 80, hl-line (underline) in prog-mode
- Smooth scrolling via pixel-scroll-precision-mode with scroll margin
- Starts maximized, no toolbar, no startup screen

### Editing

- BSD C style, 4-space indentation, spaces only
- Trailing whitespace and blank lines stripped on save
- Code folding via `hs-minor-mode` in prog-mode
- `C-a` toggles between indentation and beginning of line
- `C-x 3` splits with the left pane fixed at 90 columns
- Backups saved to `~/.emacs-backups`

### Completion & tools

- Global company-mode (disabled in eshell)
- magit for Git

### Packages

`company` · `magit` · `rainbow-delimiters` · `slime` · `slime-company` · `smart-mode-line` · `smart-mode-line-powerline-theme`

All installed from GNU ELPA, NonGNU ELPA, or MELPA. A USTC mirror is available in `mirror.el`.

## File structure

| File | Purpose |
| --- | --- |
| `emacs.el` | Entry point — faces, custom variables; loads `autoloads.el` |
| `autoloads.el` | Boot sequence — loads `mirror.el` then `custom.el` |
| `mirror.el` | Package archive URLs (upstream / USTC mirror) |
| `custom.el` | Main configuration — environment, keybindings, UI, editing, languages |

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

Restart Emacs after installation.
