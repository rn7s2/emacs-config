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

(provide 'init-package)
;;; init-package.el ends here
