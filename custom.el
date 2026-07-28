;;; custom.el --- Customize-managed settings -*- lexical-binding: t; -*-

;;; Commentary:
;; This file is written by Emacs' Customize interface (M-x customize).
;; Hand-written configuration lives in init.el and lisp/*.el; leave this file
;; for Emacs to manage.

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes '(default))
 '(package-vc-selected-packages
   '((evo-emacs :url "https://github.com/rn7s2/evo-emacs")
     (claude-code-ide :url "https://github.com/manzaltu/claude-code-ide.el"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; custom.el ends here
