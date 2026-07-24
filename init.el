;;; init.el --- Personal Emacs configuration entry point -*- lexical-binding: t; -*-

;;; Commentary:
;; Loaded through a symlink:  ~/.emacs -> ~/.emacs-config/init.el
;;
;; Configuration is split into focused modules under lisp/, each of which
;; ends with `(provide 'init-<name>)' and is required in order below.

;;; Code:

;; Speed up startup by suspending garbage collection, then restore a sane
;; threshold once Emacs has finished loading.
(let ((normal-gc-cons-threshold (* 16 1024 1024)))
  (setq gc-cons-threshold most-positive-fixnum)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;; Resolve this repository's real directory even though we are loaded via a
;; symlink from ~/.emacs.
(defvar my/config-dir
  (file-name-directory (file-truename (or load-file-name buffer-file-name)))
  "Root directory of this Emacs configuration.")

(add-to-list 'load-path (expand-file-name "lisp" my/config-dir))

;; Keep Customize's machine-generated settings out of the hand-written config.
(setq custom-file (expand-file-name "custom.el" my/config-dir))
(when (file-exists-p custom-file)
  (load custom-file nil :nomessage))

;; Configuration modules, loaded in dependency order.
(require 'init-package)   ; package archives + use-package
(require 'init-env)       ; inherit the shell PATH in GUI Emacs
(require 'init-ui)        ; theme, modeline, display
(require 'init-editing)   ; editing defaults, keybindings, completion
(require 'init-lang)      ; C/C++, Rust, Go, Markdown, Magit
(require 'init-lisp)      ; Common Lisp (SLIME + company)

;; Now that every module has declared its packages, tell `package-autoremove'
;; which ones this config actually wants; everything else is a dependency.
(setq package-selected-packages (sort (copy-sequence my/ensured-packages)
                                      #'string-lessp))

;;; init.el ends here
