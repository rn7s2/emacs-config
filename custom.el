;; -*- lexical-binding: t; -*-

(defmacro interactive-action (action)
  `(lambda () (interactive) (funcall ,action)))

(defun global-bind-key (key action)
  (global-unset-key key)
  (global-set-key key (interactive-action action)))

(global-bind-key (kbd "C-a") 'back-to-indentation)

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "zsh --login -c 'echo $PATH'"))))
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

;; helper functions
(defun add-hook-function-to-mode-hooks (mode-hooks hook-function)
  (dolist (mode-hook mode-hooks)
    (add-hook mode-hook hook-function)))
(defun add-hook-functions-to-mode-hook (mode-hook hook-functions)
  (dolist (hook-function hook-functions)
    (add-hook mode-hook hook-function)))

;; company
(global-company-mode)
(add-hook 'eshell-mode-hook (lambda () (company-mode -1)))

;; misc
;; (setq-default line-spacing 0.23)
(global-display-fill-column-indicator-mode)
(add-hook 'window-setup-hook 'toggle-frame-maximized)
;; (add-hook 'window-setup-hook 'toggle-frame-fullscreen)
(add-hook-functions-to-mode-hook 'before-save-hook
                                 '(delete-trailing-lines
                                   delete-trailing-whitespace))
(add-hook-functions-to-mode-hook 'prog-mode-hook
                                 (list 'hl-line-mode
                                       'hs-minor-mode))

;; powerline
(setq sml/theme 'respectful)
(sml/setup)

;; lisp
(add-hook-function-to-mode-hooks '(lisp-mode-hook
                                   lisp-interaction-mode-hook
                                   scheme-mode-hook
                                   emacs-lisp-mode-hook)
                                 'rainbow-delimiters-mode)
(setq inferior-lisp-program "wx86cl64")
;; (setq inferior-lisp-program "sbcl")
(slime-setup '(slime-fancy slime-company slime-quicklisp slime-asdf))

;; This assumes you've installed the package via MELPA.
(use-package ligature
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))
