;;; init-emacs.el --- Emacs settings
;;; Commentary:
;;; Code:

;; Disable splash screen
(setq inhibit-startup-message t)

;; Enable X11 Copy & Paste to/from Emacs. Primary
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)

; 'y' instead of 'yes', 'n' instead of 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

; Show current pointed function arguments
(eldoc-mode 1)

; Hide elements
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; If you want to show the matching parenthesis, brace or bracket automatically, add this option
(show-paren-mode t)

;; Automatically reload files was modified by external program
(global-auto-revert-mode 1)

; Disable backup and autosave files
;; (setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.saves/"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups


(set-default 'truncate-lines t)

; Map escape to cancel (like C-g)
(define-key isearch-mode-map [escape] 'isearch-abort)
(global-set-key [escape] 'keyboard-escape-quit)

;; --------------------------- General mappings
(general-def grep-mode-map
  "C-n" 'next-error-no-select
  "C-p" 'previous-error-no-select
  ;; "C-n" 'next-error
  ;; "C-p" 'previous-error
  )


;; Make smooth scroll {{
;; scrolling to always be a line at a time
(setq scroll-margin 4)
(setq hscroll-margin 0)
(setq linum-delay t) ;; Delay updates to give Emacs a chance for other changes
(setq scroll-conservatively 10000)
(setq scroll-step 1) ;; keyboard scroll one line at a time
(global-linum-mode 0)
;; }}

;; ssh-agent socket settings
(exec-path-from-shell-copy-env "SSH_AUTH_SOCK")

(setq browse-url-browser-function
      '(("." . browse-url-generic)))
(setq browse-url-secondary-browser-function 'browse-url-generic)
(setq browse-url-generic-program (executable-find "qutebrowser"))


;; Customize ediff --------------------- <

;; Don't use the weird setup with the control panel in a separate frame.
;; I can manage windows in Emacs much better than my desktop (Unity or Gnome Shell) can manage the Emacs frames.
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; make return key also do indent, globally
(electric-indent-mode 1)
(electric-pair-mode 1)


(provide 'init-emacs)
