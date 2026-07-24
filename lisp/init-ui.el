;;; init-ui.el --- Theme, modeline, and display -*- lexical-binding: t; -*-

;;; Commentary:
;; A dark theme, the smart modeline, line numbers, smooth scrolling, and
;; rainbow-delimiters coloured for a dark background.

;;; Code:

;; Drop pure GUI chrome (no-ops in a terminal frame).
(dolist (mode '(tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))
(setopt inhibit-startup-screen t)

;; Frame geometry (GUI only): open maximized in the top-left corner.  Setting
;; the frame parameter directly avoids the visible resize that the old
;; `toggle-frame-maximized' on `window-setup-hook' produced.
(when (display-graphic-p)
  (setq initial-frame-alist '((top . 0) (left . 0) (fullscreen . maximized))))

;; Default font (GUI only).  `:height' is in 1/10 pt, so 180 = 18pt.
;; Customize also records :slant/:weight/:width and a :foundry, but those are
;; simply Emacs' defaults (`regular' is a synonym for `normal'), and a foundry
;; of "nil" only narrows font matching -- so family and height are all we need.
(when (display-graphic-p)
  (set-face-attribute 'default nil :family "Iosevka" :height 180))

;; Line and column indicators.
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(global-display-fill-column-indicator-mode 1)
(setopt display-line-numbers-width-start t
        fill-column 100)

;; Draw underlines just below the text so hl-line stays readable.
(setq x-underline-at-descent-line t)

;; Smooth, precise scrolling.
(setopt scroll-conservatively 100
        scroll-preserve-screen-position t
        maximum-scroll-margin 0.5)
(pixel-scroll-precision-mode 1)

;; Modeline.  `respectful' reuses the active theme's colors; load it without the
;; interactive "this theme may run code" confirmation on every startup.
(use-package smart-mode-line
  :init (setq sml/theme 'respectful
              sml/no-confirm-load-theme t)
  :config (sml/setup))

;; Dark theme + a highlighted current line.
(load-theme 'modus-vivendi-tinted :no-confirm)
(require 'hl-line)
(set-face-attribute 'hl-line nil :background "#3a3a3a" :underline t)

;; Bracket coloring in Lisp buffers, tuned bright for the dark background.
(use-package rainbow-delimiters
  :demand t
  :init (setopt rainbow-delimiters-max-face-count 6)
  :hook ((emacs-lisp-mode
          lisp-mode
          lisp-interaction-mode
          scheme-mode) . rainbow-delimiters-mode)
  :config
  (set-face-attribute 'rainbow-delimiters-depth-1-face nil :foreground "#c678dd")
  (set-face-attribute 'rainbow-delimiters-depth-2-face nil :foreground "#61afef")
  (set-face-attribute 'rainbow-delimiters-depth-3-face nil :foreground "#56b6c2")
  (set-face-attribute 'rainbow-delimiters-depth-4-face nil :foreground "#98c379")
  (set-face-attribute 'rainbow-delimiters-depth-5-face nil :foreground "#e5c07b")
  (set-face-attribute 'rainbow-delimiters-depth-6-face nil :foreground "#e06c75"))

(provide 'init-ui)
;;; init-ui.el ends here
