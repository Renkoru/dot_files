;; init-emacs
;; Just emacs settings

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
(setq make-backup-files nil)
(setq auto-save-default nil)

(setq backup-directory-alist `(("." . "~/.saves")))
(set-default 'truncate-lines t)

; Map escape to cancel (like C-g)
(define-key isearch-mode-map [escape] 'isearch-abort)
(global-set-key [escape] 'keyboard-escape-quit)

(provide 'init-emacs)
