# emacs-config

Simple emacs config.

## Supported

- Common Lisp
- C17/C++20 (clangd)
- Emacs Lisp

## Usage

### \*nix

In your shell:

- `cd ~`
- `git clone https://github.com/rn7s2/emacs-config.git`
- `mv emacs-config .emacs-config`
- `ln -s ~/.emacs-config/emacs.el ~/.emacs`

Then open emacs,

- `M-x package-refresh-contents`
- `M-x package-install-selected`

### Windows

`.emacs` should be in `C:\Users\<YOUR USER NAME>\AppData\Roaming\`
You can still create a symbollink to emacs.el using `mklink`.

All done. Don't forget to restart emacs.
