;; -*- lexical-binding: t; -*-

;;;; ---- Default font ----

(set-face-attribute 'default nil
                    :family "Google Sans Code"
                    :foundry (if (eq 'windows-nt system-type) "outline" "nil")
                    :slant 'normal
                    :weight 'regular
                    :width 'normal
                    :height (if (eq 'windows-nt system-type) 132 160))

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

;;;; ---- Environment ----

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "zsh --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(defun set-proxy ()
  (let ((url "http://127.0.0.1:10809"))
    (setenv "http_proxy" url)
    (setenv "https_proxy" url)))

(when (eq 'windows-nt system-type)
  (set-proxy))

(when (eq 'darwin system-type)
  (set-exec-path-from-shell-PATH))

;;;; ---- Window splitting ----

(defun my/split-window-right ()
  "Split window, keeping left pane at 90 columns."
  (interactive)
  (split-window-right 90))

(global-set-key (kbd "C-x 3") #'my/split-window-right)

;;;; ---- Keybindings ----

(defvar *should-back-to-indentation* t)
(defun go-begin-of-line ()
  (cond (*should-back-to-indentation* (setf *should-back-to-indentation* nil)
                                      (back-to-indentation))
        (t (setf *should-back-to-indentation* t)
           (move-beginning-of-line 1))))

(global-bind-key (kbd "C-a") #'go-begin-of-line)

;;;; ---- UI and display ----

(setq-default line-spacing 0.23)
(setq x-underline-at-descent-line t)
(setopt display-line-numbers-width-start t)
(global-display-fill-column-indicator-mode)
(add-hook 'window-setup-hook 'toggle-frame-maximized)
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
  (when (string= (shell-command-to-string "printf %s \"$( osascript -e \'tell application \"System Events\" to tell appearance preferences to return dark mode\' )\"") "true")
    (load-theme 'wombat t)
    (require 'hl-line)
    (set-face-attribute 'hl-line nil :background "#3a3a3a")))

(when (eq 'darwin system-type)
  (set-system-dark-mode))

;; XQuartz on macOS
(when (eq 'darwin system-type)
  (setenv "DISPLAY" ":0"))

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

(setq inferior-lisp-program "sbcl --dynamic-space-size 16384")
(slime-setup '(slime-fancy slime-quicklisp slime-asdf))

;;;; ---- FriCAS ----

(defun efricas ()
  "Start FriCAS using the official fricas elisp integration."
  (interactive)
  (let* ((fricas-bin (file-truename (or (executable-find "fricas")
                                        (error "fricas not found in PATH"))))
         (prefix (file-name-directory
                  (directory-file-name (file-name-directory fricas-bin))))
         (lib-dir (expand-file-name "lib/fricas" prefix))
         (fricascmd (car (file-expand-wildcards
                          (expand-file-name "target/*/bin/fricas" lib-dir)))))
    (unless fricascmd
      (error "Cannot find FriCAS internal binary under %s" lib-dir))
    (server-start)
    (setenv "FRICASCMD" fricascmd)
    (setenv "FRICASEDITOR" "emacsclient +$line $name >/dev/null 2>&1")
    (add-to-list 'load-path (expand-file-name "emacs" lib-dir))
    (add-to-list 'auto-mode-alist '("\\.fri$" . fricas-mode))
    (require 'fricas)
    (fricas)))

;;;; ---- Claude Code ----
(setq claude-code-terminal-backend 'vterm)
(setopt vterm-min-window-width 40)
