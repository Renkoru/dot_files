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


;; Make smooth scroll {{
;; scrolling to always be a line at a time
(setq scroll-margin 4)
(setq hscroll-margin 0)
(setq linum-delay t) ;; Delay updates to give Emacs a chance for other changes
(setq scroll-conservatively 10000)
(setq scroll-step 1) ;; keyboard scroll one line at a time
;; }}

;; ssh-agent socket settings
(exec-path-from-shell-copy-env "SSH_AUTH_SOCK")

(setq browse-url-browser-function
      '(("." . browse-url-generic)))
(setq shr-external-browser 'browse-url-generic)
(setq browse-url-generic-program (executable-find "qutebrowser"))

(provide 'init-emacs)
