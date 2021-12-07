(exec-path-from-shell-initialize)

(setq backup-directory-alist '(("." . "~/.emacs_backups")))

(setq initial-scratch-message (insert-file-contents "~/emacs-config/note.txt"))

(add-hook 'window-setup-hook 'toggle-frame-maximized)

(setq-default fill-column 80)
(global-display-fill-column-indicator-mode)

(global-company-mode)

(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook (lambda () (local-set-key (kbd "<f5>") 'quickrun-shell)))

(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

(setq c-basic-offset 4)
(setq c-default-style "bsd")

(setq inferior-lisp-program "sbcl")
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(setq rust-format-on-save t)
(add-hook 'rust-mode-hook #'lsp)
(add-hook 'rust-mode-hook (lambda () (define-key rust-mode-map (kbd "C-c C-c") 'rust-run)))
