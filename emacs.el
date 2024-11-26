;; -*- lexical-binding: t; -*-
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 `(default ((t (:family "JetBrains Mono"
                :foundry ,(if (eq 'windows-nt system-type) "outline" "nil")
                :slant normal :weight regular :width normal
                :height ,(if (eq 'windows-nt system-type) 132 180)))))
 '(hl-line ((t (:underline t))))
 '(rainbow-delimiters-base-error-face ((t (:inherit rainbow-delimiters-base-face :foreground "#8b0000"))))
 '(rainbow-delimiters-base-face ((t (:inherit nil))))
 '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :foreground "#ff0000"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "#ff8800"))))
 '(rainbow-delimiters-depth-3-face ((t (:inherit rainbow-delimiters-base-face :foreground "#888800"))))
 '(rainbow-delimiters-depth-4-face ((t (:inherit rainbow-delimiters-base-face :foreground "#008800"))))
 '(rainbow-delimiters-depth-5-face ((t (:inherit rainbow-delimiters-base-face :foreground "#3689e6"))))
 '(rainbow-delimiters-depth-6-face ((t (:inherit rainbow-delimiters-base-face :foreground "#a100a1")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(backup-directory-alist '(("." . "~/.emacs-backups")))
 '(c-basic-offset 4)
 '(c-default-style "bsd")
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes '(adwaita))
 '(custom-safe-themes
   '("9b21c848d09ba7df8af217438797336ac99cbbbc87a08dc879e9291673a6a631" default))
 '(fill-column 100)
 '(global-display-line-numbers-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(company rainbow-delimiters smart-mode-line smart-mode-line-powerline-theme slime slime-company))
 '(rainbow-delimiters-max-face-count 6)
 '(tool-bar-mode nil))

(load "~/.emacs-config/autoloads.el")
