;; emacs相关
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(setq backup-directory-alist (quote (("." . "~/.emacs_backups"))))
(add-to-list 'exec-path "/usr/bin")
(add-to-list 'exec-path "/usr/local/bin")

;; 代码风格
(setq c-basic-offset 4)
(setq c-default-style "linux")
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(setq-default fill-column 80)
(global-display-fill-column-indicator-mode)

;; 自动补全
(add-hook 'after-init-hook #'global-company-mode)
(add-hook 'd-mode-hook 'company-dcd-mode)
(setq company-clang-arguments '())
