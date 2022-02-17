;; Helper functions
(defun add-hook-function-to-mode-hooks (mode-hooks hook-function)
  (dolist (mode-hook mode-hooks)
    (add-hook mode-hook hook-function)))
(defun add-hook-functions-to-mode-hook (mode-hook hook-functions)
  (dolist (hook-function hook-functions)
    (add-hook mode-hook hook-function)))

;; PATH
(if (not (string-equal system-type "windows-nt"))
    (exec-path-from-shell-initialize))

;; Misc
(cnfonts-mode 1)
(global-display-fill-column-indicator-mode)
(add-hook 'window-setup-hook 'toggle-frame-maximized)
(add-hook-functions-to-mode-hook 'before-save-hook
                                 '(delete-trailing-lines
                                   delete-trailing-whitespace))
(setq initial-scratch-message (insert-file-contents "~/.emacs-config/note.txt"))

;; C/C++
(add-hook-function-to-mode-hooks '(c-mode-hook
                                   c++-mode-hook)
                                 'astyle-on-save-mode)
(add-hook-function-to-mode-hooks '(c-mode-hook
                                   c++-mode-hook)
                                 (lambda ()
			           (c-set-style "k&r")
			           (setq c-basic-offset 4)))

;; Lisp
(setq inferior-lisp-program "sbcl")
(slime-setup '(slime-fancy slime-company))
(add-hook-function-to-mode-hooks '(lisp-mode-hook
                                   scheme-mode-hook
                                   emacs-lisp-mode-hook
                                   lisp-interaction-mode-hook)
                                 'rainbow-delimiters-mode)

;; Rust
(setq rust-format-on-save t)

;; Quickrun
(add-hook-functions-to-mode-hook 'prog-mode-hook
                                 (list 'company-mode
                                       'hs-minor-mode
                                       (lambda ()
                                         (local-set-key (kbd "<f5>")
                                                        'quickrun-shell))))
