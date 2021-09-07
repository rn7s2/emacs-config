(add-hook 'window-setup-hook 'toggle-frame-maximized)
(setq backup-directory-alist '(("." . "~/.emacs_backups")))
(setq initial-scratch-message (insert-file-contents "~/note.txt"))

(setq c-basic-offset 4)
(setq default-tab-width 4)
(setq c-default-style "bsd")
(setq-default indent-tabs-mode nil)

(add-hook 'prog-mode-hook 'hs-minor-mode)

(setq-default fill-column 80)
(global-display-fill-column-indicator-mode)

(setq inferior-lisp-program "sbcl")

(add-hook 'd-mode-hook 'company-dcd-mode)

(global-set-key (kbd "C-<f5>") 'quickrun-shell)

(require 'company)
(require 'company-c-headers)
(setq company-clang-arguments '())
(setq company-c-headers-path-system
      (append company-c-headers-path-system
              '("/usr/lib/gcc/x86_64-pc-linux-gnu/10.3.0/include/g++-v10"
                "/usr/lib/gcc/x86_64-pc-linux-gnu/10.3.0/include/g++-v10/x86_64-pc-linux-gnu"
                "/usr/lib/gcc/x86_64-pc-linux-gnu/10.3.0/include/g++-v10/backward"
                "/usr/lib/gcc/x86_64-pc-linux-gnu/10.3.0/include"
                "/usr/lib/gcc/x86_64-pc-linux-gnu/10.3.0/include-fixed")))
(add-to-list 'company-backends 'company-c-headers)

(global-set-key (kbd "M-/") 'company-complete)
(add-hook 'after-init-hook 'global-company-mode)
