;; -*- lexical-binding: t; -*-
;; helper functions
(defun add-hook-function-to-mode-hooks (mode-hooks hook-function)
  (dolist (mode-hook mode-hooks)
    (add-hook mode-hook hook-function)))
(defun add-hook-functions-to-mode-hook (mode-hook hook-functions)
  (dolist (hook-function hook-functions)
    (add-hook mode-hook hook-function)))

;; company
(global-company-mode)
(add-hook 'eshell-mode-hook (lambda () (company-mode -1)))

;; misc
(global-display-fill-column-indicator-mode)
(add-hook 'window-setup-hook 'toggle-frame-maximized)
(add-hook-functions-to-mode-hook 'before-save-hook
                                 '(delete-trailing-lines
                                   delete-trailing-whitespace))
(add-hook-functions-to-mode-hook 'prog-mode-hook
                                 (list 'hl-line-mode
                                       'hs-minor-mode))

;; font
(cnfonts-mode 1)

;; powerline
(setq sml/theme 'light-powerline)
(sml/setup)

;; lisp
(add-hook-function-to-mode-hooks '(lisp-mode-hook
                                   lisp-interaction-mode-hook
                                   scheme-mode-hook
                                   emacs-lisp-mode-hook
                                   racket-mode-hook)
                                 'rainbow-delimiters-mode)
(setq inferior-lisp-program "sbcl")
(slime-setup '(slime-fancy slime-company slime-quicklisp slime-asdf))
