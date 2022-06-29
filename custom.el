;; -*- lexical-binding: t; -*-
;; Helper functions  
(defun add-hook-function-to-mode-hooks (mode-hooks hook-function)
  (dolist (mode-hook mode-hooks)
    (add-hook mode-hook hook-function)))
(defun add-hook-functions-to-mode-hook (mode-hook hook-functions)
  (dolist (hook-function hook-functions)
    (add-hook mode-hook hook-function)))

;; Misc
(global-company-mode)
(global-display-fill-column-indicator-mode)
(if (not (string-equal system-type "windows-nt"))
    (setq-default line-spacing 0.2))
(add-hook 'window-setup-hook 'toggle-frame-maximized)
(add-hook-functions-to-mode-hook 'before-save-hook
                                 '(delete-trailing-lines
                                   delete-trailing-whitespace))
(add-hook-functions-to-mode-hook 'prog-mode-hook
                                 (list 'hl-line-mode
                                       'hs-minor-mode))
(setq cnfonts-personal-fontnames '(("Cascadia Code SemiLight")))
(cnfonts-mode 1)

;; C/C++
(setq c-basic-offset 4)

;; Lisp
(add-hook-function-to-mode-hooks '(lisp-mode-hook
                                   scheme-mode-hook
                                   emacs-lisp-mode-hook
                                   lisp-interaction-mode-hook)
                                 'rainbow-delimiters-mode)
(setq inferior-lisp-program "sbcl")
(slime-setup '(slime-fancy slime-company))
