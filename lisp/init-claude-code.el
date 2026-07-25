;;; init-claude-code.el --- Claude Code integration -*- lexical-binding: t; -*-

;;; Commentary:
;; `claude-code-ide' runs the Claude Code CLI inside Emacs and exposes the
;; editor to it over MCP (xref, tree-sitter, imenu, project and diagnostics),
;; so the CLI can query the same code intelligence Emacs already has.
;;
;; It is not on any ELPA archive, so it is installed straight from Git with
;; `:vc'.  Note that `:vc' silently disables `:ensure' for the same form, which
;; is why init-package.el tracks Git-installed packages separately (see
;; `my/vc-packages') to keep them out of `package-autoremove''s sights.
;;
;; The terminal backend is `ghostel' rather than the default; it must be set
;; before the package loads, since `claude-code-ide' reads it when setting up.

;;; Code:

(use-package ghostel)

(use-package claude-code-ide
  :vc (:url "https://github.com/manzaltu/claude-code-ide.el" :rev :newest)
  :bind ("C-c C-'" . claude-code-ide-menu)
  :init
  (setq claude-code-ide-terminal-backend 'ghostel)
  :config
  ;; Serve xref/tree-sitter/imenu/project/diagnostics to the CLI over MCP.
  (claude-code-ide-emacs-tools-setup))

(provide 'init-claude-code)
;;; init-claude-code.el ends here
