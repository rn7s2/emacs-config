;; -*- lexical-binding: t; -*-

;;;; ---- Standard packages (MELPA / ELPA) ----

(use-package company :ensure t)
(use-package magit :ensure t)
(use-package rainbow-delimiters :ensure t)
(use-package smart-mode-line :ensure t)
(use-package smart-mode-line-powerline-theme :ensure t)

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map ("C-c C-e" . markdown-do)))
