;; -*- lexical-binding: t; -*-

;;;; ---- Utility macros and functions ----

(defmacro interactive-action (action)
  `(lambda () (interactive) (funcall ,action)))

(defun global-bind-key (key action)
  (global-unset-key key)
  (global-set-key key (interactive-action action)))

(defun add-hook-function-to-mode-hooks (mode-hooks hook-function)
  (dolist (mode-hook mode-hooks)
    (add-hook mode-hook hook-function)))

(defun add-hook-functions-to-mode-hook (mode-hook hook-functions)
  (dolist (hook-function hook-functions)
    (add-hook mode-hook hook-function)))

;;;; ---- Keybindings ----

(defvar *should-back-to-indentation* t)
(defun go-begin-of-line ()
  (cond (*should-back-to-indentation* (setf *should-back-to-indentation* nil)
                                      (back-to-indentation))
        (t (setf *should-back-to-indentation* t)
           (move-beginning-of-line 1))))

(global-bind-key (kbd "C-a") #'go-begin-of-line)

;;;; ---- UI and display ----

;; (setq-default line-spacing 0.23)
(setq x-underline-at-descent-line t)
(setopt display-line-numbers-width-start t)
(global-display-fill-column-indicator-mode)

;; (setq initial-frame-alist '((top . 0) (left . 0)))
;; (add-hook 'window-setup-hook 'toggle-frame-maximized)
;; (add-hook 'window-setup-hook 'toggle-frame-fullscreen)

;; Smooth scrolling
(setq scroll-conservatively 100
      scroll-preserve-screen-position t
      maximum-scroll-margin 0.5)
(pixel-scroll-precision-mode 1)

;; powerline
(setq sml/theme 'respectful)
(sml/setup)

;; Light/Dark Theme
(defun set-system-dark-mode ()
  (interactive)
  (load-theme 'modus-vivendi-tinted t)
  (require 'hl-line)
  (set-face-attribute 'hl-line nil :background "#3a3a3a")
  ;; Bright rainbow-delimiters for dark background
  (set-face-attribute 'rainbow-delimiters-depth-1-face nil :foreground "#c678dd")
  (set-face-attribute 'rainbow-delimiters-depth-2-face nil :foreground "#61afef")
  (set-face-attribute 'rainbow-delimiters-depth-3-face nil :foreground "#56b6c2")
  (set-face-attribute 'rainbow-delimiters-depth-4-face nil :foreground "#98c379")
  (set-face-attribute 'rainbow-delimiters-depth-5-face nil :foreground "#e5c07b")
  (set-face-attribute 'rainbow-delimiters-depth-6-face nil :foreground "#e06c75"))

(set-system-dark-mode)

;;;; ---- Editing defaults ----

(add-hook-functions-to-mode-hook 'before-save-hook
                                 '(delete-trailing-lines
                                   delete-trailing-whitespace))
(add-hook-functions-to-mode-hook 'prog-mode-hook
                                 (list 'hl-line-mode
                                       'hs-minor-mode))

;; Special UP for 1st line
(defun my/previous-line-or-bol ()
  (interactive)
  (if (= (line-number-at-pos) 1)
      (beginning-of-line)
    (previous-line)))
(global-set-key [remap previous-line] #'my/previous-line-or-bol)

;;;; ---- Completion (company) ----

(global-company-mode)
(add-hook 'eshell-mode-hook (lambda () (company-mode -1)))

;;;; ---- C/C++ ----

(add-hook 'c-mode-hook
          (lambda () (setq company-clang-arguments '("-std=c17"))))
(add-hook 'c++-mode-hook
          (lambda () (setq company-clang-arguments '("-std=c++20"))))

;;;; ---- Lisp ----

(add-hook-function-to-mode-hooks '(lisp-mode-hook
                                   lisp-interaction-mode-hook
                                   scheme-mode-hook
                                   emacs-lisp-mode-hook)
                                 'rainbow-delimiters-mode)
