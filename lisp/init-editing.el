;;; init-editing.el --- Editing defaults, keys, completion -*- lexical-binding: t; -*-

;;; Commentary:
;; General editing behaviour, a couple of movement keybindings, and the
;; global company-mode completion UI.

;;; Code:

;;;; Defaults

(setq-default indent-tabs-mode nil)               ; indent with spaces
(set-language-environment "UTF-8")
(setq backup-directory-alist '(("." . "~/.emacs-backups")))

(global-auto-revert-mode 1)                       ; reload files changed on disk
(add-hook 'before-save-hook #'delete-trailing-whitespace)

;; Highlight the current line and enable code folding in programming buffers.
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'prog-mode-hook #'hs-minor-mode)

;;;; Keybindings

;; C-a moves to the first non-blank character, then toggles to column 0.
(defvar-local my/at-indentation-p t)
(defun my/smart-beginning-of-line ()
  "Toggle point between the first non-blank char and the true line start."
  (interactive)
  (if my/at-indentation-p
      (progn (setq my/at-indentation-p nil) (back-to-indentation))
    (setq my/at-indentation-p t)
    (move-beginning-of-line 1)))
(global-set-key (kbd "C-a") #'my/smart-beginning-of-line)

;; macOS binds s-t (Cmd-T) to `menu-set-font', which opens the system Fonts
;; panel -- easy to hit by accident with browser "new tab" muscle memory, and
;; macOS then restores that panel on subsequent launches.  The font is set in
;; init-ui.el, so this binding has no use here.
(when (eq system-type 'darwin)
  (global-unset-key (kbd "s-t")))

;; `C-x C-c' normally runs `save-buffers-kill-terminal', which kills the
;; whole Emacs instance (all frames, all buffers).  With multiple frames per
;; instance (see init-ui.el) that is almost never what's wanted from a single
;; frame -- rebind it to just close the current frame instead.  On the last
;; remaining frame there is nothing left to "just close", so fall back to
;; the original behaviour there: `save-buffers-kill-terminal' prompts to
;; save any modified buffers before quitting.
(defun my/delete-frame-or-kill-emacs ()
  "Close the current frame, or quit Emacs if this is the only frame left."
  (interactive)
  (if (cdr (frame-list))
      (delete-frame)
    (save-buffers-kill-terminal)))
(global-set-key (kbd "C-x C-c") #'my/delete-frame-or-kill-emacs)

;; On the first line, up-movement lands on beginning-of-line instead of erroring.
(defun my/previous-line-or-bol ()
  "Move to the previous line, or to beginning of line when on line 1."
  (interactive)
  (if (= (line-number-at-pos) 1)
      (beginning-of-line)
    (call-interactively #'previous-line)))
(global-set-key [remap previous-line] #'my/previous-line-or-bol)

;;;; Completion

(use-package company
  :hook (after-init . global-company-mode)
  :config
  ;; Company is noise in the eshell prompt.
  (add-hook 'eshell-mode-hook (lambda () (company-mode -1)))
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "C-d") #'company-show-doc-buffer)
  (define-key company-active-map (kbd "M-.") #'company-show-location))

(provide 'init-editing)
;;; init-editing.el ends here
