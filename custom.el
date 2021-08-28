(add-hook 'window-setup-hook 'toggle-frame-maximized)
(setq backup-directory-alist (quote (("." . "~/.emacs_backups"))))

(setq c-basic-offset 4)
(setq c-default-style "bsd")
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

(global-set-key (kbd "C-<f5>") 'quickrun-shell)

(add-hook 'prog-mode-hook 'hs-minor-mode)

(setq-default fill-column 80)
(global-display-fill-column-indicator-mode)

(setq inferior-lisp-program "sbcl")
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'd-mode-hook 'company-dcd-mode)
(setq company-clang-arguments '())

(add-to-list 'exec-path "/usr/bin")
(add-to-list 'exec-path "/usr/local/bin")

(setq initial-scratch-message (insert-file-contents "~/note.txt"))
