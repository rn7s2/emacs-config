;; 开启hs-minor-mode，允许代码折叠
(add-hook 'prog-mode-hook #'hs-minor-mode)

;; 全局开启company自动补全
(add-hook 'after-init-hook #'global-company-mode)
