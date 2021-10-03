(add-hook 'window-setup-hook 'toggle-frame-maximized)
(setq backup-directory-alist '(("." . "~/.emacs_backups")))
(setq initial-scratch-message (insert-file-contents "~/emacs-config/note.txt"))

(setq c-basic-offset 4)
(setq default-tab-width 4)
(setq c-default-style "bsd")
(setq-default indent-tabs-mode nil)

(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook (lambda () (local-set-key (kbd "<f5>") 'quickrun-shell)))

(setq-default fill-column 80)
(global-display-fill-column-indicator-mode)

(setq inferior-lisp-program "sbcl")

(require 'company)
(require 'company-c-headers)
(setq company-clang-arguments '())
(setq company-c-headers-path-system
      (append company-c-headers-path-system
              '("/usr/lib/clang/11.0.1/include"
                "/usr/local/include"
                "/usr/include")))
(add-to-list 'company-backends 'company-c-headers)

(global-set-key (kbd "M-/") 'company-complete)
(add-hook 'after-init-hook 'global-company-mode)
