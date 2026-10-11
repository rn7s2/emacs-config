;;; init.el --- Personal Emacs configuration entry point -*- lexical-binding: t; -*-

;;; Commentary:
;; Loaded through a symlink:  ~/.emacs -> ~/.emacs-config/init.el
;;
;; Configuration is split into focused modules under lisp/, each of which
;; ends with `(provide 'init-<name>)' and is required in order below.

;;; Code:

;; Avoid the bundled GCC deriving an invalid macOS target on newer Darwin releases.
(when (eq system-type 'darwin)
  (require 'comp)
  (add-to-list 'native-comp-driver-options "-mmacosx-version-min=11.0"))

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
(require 'init-package)     ; package archives + use-package
(require 'init-env)         ; inherit the shell PATH in GUI Emacs
(require 'init-ui)          ; theme, modeline, display
(require 'init-editing)     ; editing defaults, keybindings, completion
(require 'init-lang)        ; C/C++, Rust, Go, Markdown, Magit
(require 'init-lisp)        ; Common Lisp (SLIME + company)
(require 'init-claude-code) ; Claude Code
(require 'init-evo)         ; evo agent

;; Now that every module has declared its packages, tell `package-autoremove'
;; which ones this config actually wants; everything else is a dependency.
;;
;; Git-installed packages are tracked separately (see `my/vc-packages') and
;; have to be folded in here: `package--removable-packages' does not consult
;; `package-vc-selected-packages', so without this they -- and their
;; dependencies -- look unused and `package-autoremove' offers to delete them.
(setq package-selected-packages
      (sort (delete-dups (append (copy-sequence my/ensured-packages)
                                 (copy-sequence my/vc-packages)))
            #'string-lessp))

;; Installing a package during init leaves package.el unable to save the
;; selection (`after-init-time' is still nil), so it defers
;; `package--save-selected-packages' onto `after-init-hook'.  That deferred call
;; receives no argument, which resets `package-selected-packages' to nil and
;; writes the nil into custom.el -- clobbering the list derived just above on
;; every startup that installs something.  This config derives the list rather
;; than storing it, so the deferred save has nothing useful to do.
(remove-hook 'after-init-hook #'package--save-selected-packages)

;;; init.el ends here
