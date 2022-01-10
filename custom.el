;; PATH
(if (not (string-equal system-type "windows-nt"))
    (exec-path-from-shell-initialize))

;; Lisp
(setq inferior-lisp-program "sbcl")
(dolist (hook '(lisp-mode-hook
                scheme-mode-hook
                emacs-lisp-mode-hook
                lisp-interaction-mode-hook))
  (add-hook hook 'rainbow-delimiters-mode))

;; Rust
(setq rust-format-on-save t)

;; Misc
(setq-default c-basic-offset 4)
(global-company-mode)
(global-display-fill-column-indicator-mode)
(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook (lambda () (local-set-key (kbd "<f5>") 'quickrun-shell)))
(add-hook 'before-save-hook 'delete-trailing-lines)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Appearance
(add-hook 'window-setup-hook 'toggle-frame-maximized)
(cnfonts-mode 1)

;; Initial buffer
(setq initial-scratch-message (insert-file-contents "~/emacs-config/note.txt"))
