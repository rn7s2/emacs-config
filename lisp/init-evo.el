;;; init-evo.el --- evo agent integration -*- lexical-binding: t; -*-

;;; Commentary:
;; `evo-emacs' runs the `evo' agent CLI inside a dedicated Emacs side window
;; using the `ghostel' terminal backend.  It is a minimal, terminal-only
;; integration: launch `evo' with `C-c C-;', and when the process exits its
;; window closes and its buffer is killed.  No MCP, no editor bridge.
;;
;; The launch key is `C-c C-;': `C-c' is a prefix key, so a two-stroke
;; sequence can hang off it (unlike `C-e', which is bound to
;; `move-end-of-line' and cannot start a key sequence).
;;
;; Like `claude-code-ide', it is not on any ELPA archive, so it is installed
;; straight from Git with `:vc'.  Note that `:vc' silently disables `:ensure'
;; for the same form, which is why init-package.el tracks Git-installed
;; packages separately (see `my/vc-packages') to keep them out of
;; `package-autoremove''s sights.

;;; Code:

(use-package ghostel)

(use-package evo-emacs
  :vc (:url "https://github.com/rn7s2/evo-emacs" :rev :newest)
  :bind ("C-c C-;" . evo))

(provide 'init-evo)
;;; init-evo.el ends here
