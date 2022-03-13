;; Helper functions
(defun add-hook-function-to-mode-hooks (mode-hooks hook-function)
  (dolist (mode-hook mode-hooks)
    (add-hook mode-hook hook-function)))
(defun add-hook-functions-to-mode-hook (mode-hook hook-functions)
  (dolist (hook-function hook-functions)
    (add-hook mode-hook hook-function)))

;; Misc
(setf cnfonts-personal-fontnames '(("Cascadia Code" "Cascadia Mono")))
(cnfonts-mode 1)
(global-display-fill-column-indicator-mode)
(add-hook 'window-setup-hook 'toggle-frame-maximized)
(powerline-default-theme)
(add-hook-functions-to-mode-hook 'before-save-hook
                                 '(delete-trailing-lines
                                   delete-trailing-whitespace))
(add-hook-functions-to-mode-hook 'prog-mode-hook
                                 (list 'hs-minor-mode
                                       (lambda ()
                                         (local-set-key (kbd "<f5>")
                                                        'quickrun-shell))))
(setq initial-scratch-message (insert-file-contents "~/.emacs-config/note.txt"))

;; C/C++
(add-hook-function-to-mode-hooks '(c-mode-hook
                                   c++-mode-hook)
                                 (lambda ()
			           (c-set-style "k&r")
			           (setq c-basic-offset 4)))

;; Lisp
(add-hook-function-to-mode-hooks '(lisp-mode-hook
                                   scheme-mode-hook
                                   emacs-lisp-mode-hook
                                   lisp-interaction-mode-hook)
                                 'rainbow-delimiters-mode)
(add-hook-function-to-mode-hooks '(emacs-lisp-mode-hook
                                   lisp-interaction-mode-hook)
                                 'company-mode)

;; Rust
(setq rust-format-on-save t)
