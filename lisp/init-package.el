;;; init-package.el --- Package archives and use-package -*- lexical-binding: t; -*-

;;; Commentary:
;; Sets the package archives and makes `use-package' available.  Every module
;; installs its own packages via `use-package' (see `use-package-always-ensure').

;;; Code:

(require 'package)

;; Official upstream archives (uncomment when outside mainland China):
;; (setq package-archives
;;       '(("gnu"    . "https://elpa.gnu.org/packages/")
;;         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
;;         ("melpa"  . "https://melpa.org/packages/")))

;; USTC mirror (faster in mainland China):
(setq package-archives
      '(("gnu"    . "https://mirrors.ustc.edu.cn/elpa/gnu/")
        ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")
        ("melpa"  . "https://mirrors.ustc.edu.cn/elpa/melpa/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; MELPA rotates package tarballs daily, so a cached archive index can point at
;; a tarball the mirror has already removed (install fails with "Not found").
;; Refresh the archives and retry once when an install hits that.
(defun my/package-install-with-refresh (orig-fn &rest args)
  "Retry ORIG-FN once after refreshing archives if it fails."
  (condition-case _err
      (apply orig-fn args)
    (error (package-refresh-contents)
           (apply orig-fn args))))
(advice-add 'package-install :around #'my/package-install-with-refresh)

;; `use-package' is bundled with Emacs since version 29.
(require 'use-package)
(setq use-package-always-ensure t)   ; every :package installs if missing

;; `package-autoremove' deletes anything absent from `package-selected-packages'.
;; Only `package-install' populates that list, so once every package is already
;; installed nothing refreshes it and autoremove would offer to delete the lot.
;; Record what each `:ensure' asks for; init.el installs the result as the
;; selected set, which keeps it derived from the config instead of hand-listed.
(defvar my/ensured-packages nil
  "Packages requested by `use-package' via `:ensure'.")

(setq use-package-ensure-function
      (lambda (name args state &optional no-refresh)
        (dolist (ensure args)
          (let ((pkg (if (eq ensure t) (use-package-as-symbol name) ensure)))
            (when (and pkg (symbolp pkg))
              (add-to-list 'my/ensured-packages pkg))))
        (use-package-ensure-elpa name args state no-refresh)))

;; Packages installed from Git need the same bookkeeping, and cannot ride along
;; with the above: `use-package-handler/:ensure' blanks its own argument
;; whenever the same form also carries `:vc', so a `:vc' package never reaches
;; the ensure function.  `use-package-vc-install' is still called on every
;; startup -- its "already installed?" test is inside the function, not at the
;; call site -- so advising it sees every `:vc' declaration.
(defvar my/vc-packages nil
  "Packages requested by `use-package' via `:vc'.")

(defun my/record-vc-package (arg &optional _local-path)
  "Record the package named by ARG, a normalized (NAME OPTS REV) `:vc' spec."
  (let ((pkg (car-safe arg)))
    (when (and pkg (symbolp pkg))
      (add-to-list 'my/vc-packages pkg))))
(advice-add 'use-package-vc-install :before #'my/record-vc-package)

(provide 'init-package)
;;; init-package.el ends here
