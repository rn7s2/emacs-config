;;; init-env.el --- Shell environment for GUI Emacs -*- lexical-binding: t; -*-

;;; Commentary:
;; A GUI Emacs on macOS is started by launchd rather than from a shell, so it
;; inherits only the bare system PATH (/usr/bin:/bin:/usr/sbin:/sbin).  Tools
;; installed by Homebrew, Cargo and Go are then invisible: `M-x slime' cannot
;; find sbcl, and Eglot cannot find rust-analyzer or gopls.
;;
;; Both `-l' and `-i' are needed: a login shell picks up Homebrew (~/.zprofile)
;; and Cargo (~/.zshenv), but $GOPATH/bin is exported from ~/.zshrc, which only
;; an interactive shell reads.  Moving that export into ~/.zshenv would let us
;; drop `-i' and start a little faster.

;;; Code:

(use-package exec-path-from-shell
  :if (or (memq window-system '(mac ns x)) (daemonp))
  :demand t
  :init
  (setq exec-path-from-shell-arguments '("-l" "-i"))
  :config
  (exec-path-from-shell-initialize))

(provide 'init-env)
;;; init-env.el ends here
