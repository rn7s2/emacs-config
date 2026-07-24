;;; init-lisp.el --- Common Lisp development -*- lexical-binding: t; -*-

;;; Commentary:
;; Common Lisp via SLIME talking to SBCL, with company-mode completion
;; provided by slime-company.
;;
;; SLIME is installed from MELPA (not from Quicklisp's slime-helper), which
;; keeps a single, package-managed copy of SLIME and lets slime-company work
;; cleanly.  Quicklisp itself is still available inside the Lisp image because
;; ~/.sbclrc loads it; `slime-quicklisp' and `slime-asdf' add the matching
;; Emacs-side commands (e.g. M-x slime-quickload).

;;; Code:

;; Declared before `slime' so the package is installed and on `load-path'
;; before `slime-setup' tries to load the slime-company contrib.
(use-package slime-company
  :after slime
  :init
  (setq slime-company-completion 'fuzzy
        slime-company-after-completion 'slime-company-just-one-space))

(use-package slime
  :commands (slime slime-mode slime-connect)
  :init
  (setq inferior-lisp-program "sbcl")
  :config
  ;; `slime-fancy' must precede `slime-company' in the contrib list.  Only add
  ;; slime-company when it is actually loadable, so a not-yet-finished install
  ;; can never abort SLIME setup.
  (slime-setup (append '(slime-fancy slime-quicklisp slime-asdf)
                       (when (require 'slime-company nil t)
                         '(slime-company)))))

(provide 'init-lisp)
;;; init-lisp.el ends here
