# emacs-config

Minimal Emacs configuration with language support and sensible defaults.

## Features

### Languages

- **C17 / C++20** — company-clang with `-std=c17` / `-std=c++20`
- **Lisp dialects** — rainbow-delimiters (6 depth colors) in Common Lisp, Emacs Lisp, Scheme, and `*scratch*`
- **Markdown** — markdown-mode with GFM mode for README files

### UI

- dark mode by default, `modus-vivendi-tinted` theme
- smart-mode-line with respectful powerline theme
- line numbers, fill-column indicator at 100, hl-line (underline) in prog-mode
- smooth scrolling via pixel-scroll-precision-mode with scroll margin
- starts maximized, no toolbar, no startup screen

### Editing

- BSD C style, 4-space indentation, spaces only
- trailing whitespace and blank lines stripped on save
- code folding via `hs-minor-mode` in prog-mode
- `C-a` toggles between indentation and beginning of line
- backups saved to `~/.emacs-backups`

### Completion & tools

- global company-mode (disabled in eshell)
- magit for Git

### Packages

ELPA / MELPA (via use-package):

`company` · `magit` · `markdown-mode` · `rainbow-delimiters` · `smart-mode-line` · `smart-mode-line-powerline-theme`

A USTC mirror is available in `mirror.el`.

## File structure

| File           | Purpose                                                               |
|----------------|-----------------------------------------------------------------------|
| `emacs.el`     | Entry point — faces, custom variables; loads `autoloads.el`           |
| `autoloads.el` | Boot sequence — loads `mirror.el`, `packages.el`, then `custom.el`    |
| `mirror.el`    | Package archive URLs (upstream / USTC mirror)                         |
| `packages.el`  | Package declarations via use-package                                  |
| `custom.el`    | Main configuration — environment, keybindings, UI, editing, languages |

## Setup

### macOS / Linux

```sh
git clone https://github.com/rn7s2/emacs-config.git ~/.emacs-config
ln -s ~/.emacs-config/emacs.el ~/.emacs
```

Packages install automatically on first launch via use-package.
