;;; init-lang.el --- General language support -*- lexical-binding: t; -*-

;;; Commentary:
;; C/C++, Rust, Go, Markdown, and Magit.  Common Lisp lives in init-lisp.el.

;;; Code:

;;;; C / C++

(setopt c-default-style "bsd"
        c-basic-offset 4)
(add-hook 'c-mode-hook
          (lambda () (setq-local company-clang-arguments '("-std=c17"))))
(add-hook 'c++-mode-hook
          (lambda () (setq-local company-clang-arguments '("-std=c++20"))))

;;;; Rust  (via the built-in Eglot LSP client)

(use-package rust-mode
  :hook (rust-mode . eglot-ensure))

;;;; Go  (via the built-in Eglot LSP client)

(use-package go-mode
  :hook (go-mode . eglot-ensure))

;;;; Markdown

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map ("C-c C-e" . markdown-do)))

;;;; Git

(use-package magit
  :bind ("C-x g" . magit-status))

(provide 'init-lang)
;;; init-lang.el ends here
