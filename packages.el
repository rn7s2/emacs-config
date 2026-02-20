;; -*- lexical-binding: t; -*-

;;;; ---- Standard packages (MELPA / ELPA) ----

(use-package company :ensure t)
(use-package magit :ensure t)
(use-package rainbow-delimiters :ensure t)
(use-package slime :ensure t)
(use-package smart-mode-line :ensure t)
(use-package smart-mode-line-powerline-theme :ensure t)
(use-package eat :ensure t)
(use-package vterm :ensure t)

;;;; ---- VC packages (GitHub) ----

(use-package inheritenv
  :ensure t
  :vc (:url "https://github.com/purcell/inheritenv" :rev :newest))

(use-package monet
  :ensure t
  :vc (:url "https://github.com/stevemolitor/monet" :rev :newest))

(use-package claude-code
  :ensure t
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :config
  (add-hook 'claude-code-process-environment-functions #'monet-start-server-function)
  (monet-mode 1)
  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map)
  :bind
  (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode)))
