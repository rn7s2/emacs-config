;; 个性化设置
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes '(misterioso))
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages '(slime geiser-mit company-web company))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

;; 100列提示
(setq-default fill-column 100)
(global-display-fill-column-indicator-mode)

;; 使用空格代替制表符
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

;; 启动时全屏
(add-hook 'window-setup-hook #'toggle-frame-maximized)

;; 备份文件统一放置并隐藏(*nix)
(setq backup-directory-alist (quote (("." . "~/.emacs_backups"))))
