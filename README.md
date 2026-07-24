# emacs-config

A minimal, modular Emacs configuration with language support and sensible
defaults. Targets **Emacs 29+** (developed on Emacs 30).

## Layout

```text
init.el              Entry point — GC tuning, load-path, custom-file, module loading
custom.el            Customize-managed settings (written by M-x customize; leave it alone)
lisp/
  init-package.el    Package archives (USTC mirror) + use-package
  init-env.el        Inherit the shell PATH in GUI Emacs (macOS)
  init-ui.el         Dark theme, frame geometry, modeline, scrolling, rainbow-delimiters
  init-editing.el    Editing defaults, keybindings, company completion
  init-lang.el       C/C++, Rust, Go, Markdown, Magit
  init-lisp.el       Common Lisp (SLIME + slime-company)
```

Each `lisp/init-*.el` module installs the packages it needs via `use-package`
(`use-package-always-ensure` is on), so everything is installed on first launch.

## Features

### Languages

- **Common Lisp** — SLIME + SBCL with company-mode completion via
  `slime-company` (`fuzzy` completion). Run `M-x slime` to start a REPL.
- **C17 / C++20** — company-clang with `-std=c17` / `-std=c++20`
- **Rust** / **Go** — Eglot (built-in LSP client) on file open
- **Markdown** — markdown-mode, GFM mode for `README` files
- **Emacs Lisp / Scheme** — rainbow-delimiters (6 depth colors)

### UI

- Dark by default (`modus-vivendi-tinted`), smart-mode-line (`respectful`)
- GUI frames open maximized in the top-left corner
- Line numbers, fill-column indicator at 100, highlighted current line
- Smooth scrolling via `pixel-scroll-precision-mode`
- No toolbar / scrollbar / startup screen

### macOS GUI

`Emacs.app` is launched by launchd, not from a shell, so it only inherits
`/usr/bin:/bin:/usr/sbin:/sbin` — Homebrew, Cargo and Go binaries are invisible
and `M-x slime` / Eglot fail to find `sbcl`, `rust-analyzer` and `gopls`.
[lisp/init-env.el](lisp/init-env.el) fixes this with `exec-path-from-shell`.

It runs the shell with `-l -i`: a login shell alone finds Homebrew and Cargo,
but `$GOPATH/bin` is exported from `~/.zshrc`, which only interactive shells
read. Move that export to `~/.zshenv` if you'd rather drop `-i`.

### Editing

- BSD C style, 4-space indent, spaces only
- Trailing whitespace stripped on save; files auto-reverted on external change
- Code folding (`hs-minor-mode`) in `prog-mode`
- `C-a` toggles between indentation and beginning of line; up-arrow on line 1
  goes to beginning of line
- Backups saved to `~/.emacs-backups`

### Tools

- Global company-mode (off in eshell); `C-n`/`C-p`/`C-d`/`M-.` in the popup
- Magit on `C-x g`

## Setup

### Requirements

- Emacs 29+
- For Common Lisp: `sbcl` and (optionally) Quicklisp

  ```sh
  brew install sbcl        # macOS
  ```

  SLIME is installed from MELPA automatically — you do **not** need to install
  it through Quicklisp. If you use Quicklisp, make sure `~/.sbclrc` loads it
  (the standard installer does this).

### Install

```sh
git clone https://github.com/rn7s2/emacs-config.git ~/.emacs-config
ln -sf ~/.emacs-config/init.el ~/.emacs
```

Launch Emacs; packages install on first run. Outside mainland China, swap the
USTC mirror for the upstream archives in [lisp/init-package.el](lisp/init-package.el).
