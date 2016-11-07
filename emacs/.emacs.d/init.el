;;; init.el --- Main file of Emacs settings
;;; Commentary:

;; To test:
;; 1. writeroom-mode

;; To look at:
;; ecukes (https://github.com/ecukes/ecukes)

;; You need to install Cask (http://cask.readthedocs.io/) on your system
;; And do: cask install

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 )

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; package manager
(require 'package)
(require 'cl) ; for loop

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))

;;; loads packages and activates them
(package-initialize)

;; *** use-package settings

;; use-package.el is no longer needed at runtime
;; This means you should put the following at the top of your Emacs, to further reduce load time:
(eval-when-compile
  (require 'use-package))

;; Use ensure for all packages
;; Now we have cask!
;; (setq use-package-always-ensure t)


;; Plugin: exec-path-from-shell. Setting
;; Wrap to hide pyenv-mode warning. Don't know why it happends
(setq warning-minimum-level :emergency)
(exec-path-from-shell-initialize)
(setq warning-minimum-level :warning)

;; ---------------------------------------------------------------------------------------------
(setq whitespace-style '(face tabs trailing tab-mark))
(global-whitespace-mode 1)

(use-package json-mode)
(use-package writeroom-mode)


(require 'init-emacs)
(require 'init-helm) ; -------------------------------------------------------------
(require 'init-evil) ; -------------------------------------------------------------
(require 'init-yasnippet) ; should be initializes before auto-complete
(require 'init-custom-functions)
(require 'init-appearance)
(require 'init-flyspell)


(use-package ace-window
  :bind
  ("M-q" . ace-window))



(use-package magit)

(use-package dumb-jump
  :bind (("M-d" . dumb-jump-go)
         ("M-D" . dumb-jump-back))
  )

(use-package nyan-mode)



(use-package projectile
  :ensure helm
  :init (progn (setq projectile-completion-system 'helm))
  :config (projectile-global-mode t)
  )

;; ; Add this after helm init
;; (projectile-global-mode)
;; (setq projectile-completion-system 'helm)
;; (helm-projectile-on)

(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(setq scss-mode-scss-indent-offset 2)

;; Customize ediff --------------------- <

;; Don't use the weird setup with the control panel in a separate frame.
;; I can manage windows in Emacs much better than my desktop (Unity or Gnome Shell) can manage the Emacs frames.
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

(use-package beacon
  :init
  (beacon-mode 1)
  :config
  (setq beacon-size 100
        beacon-push-mark 35
        beacon-color "#ADFFB2"
        beacon-blink-when-buffer-changes t
        beacon-blink-when-point-moves t
        beacon-blink-when-window-scrolls t))


(use-package highlight-symbol
  :bind
  ("M-<f12>" . highlight-symbol-mode)
  ("C-<f12>" . highlight-symbol)
  ("<f12>" . highlight-symbol-next)
  ("S-<f12>" . highlight-symbol-prev)
  )

;; make return key also do indent, globally
(electric-indent-mode 1)
(electric-pair-mode 1)


(require 'avy)
;; Bind key for isearch C-' to activate avy
(avy-setup-default)

(autoload 'avy-isearch "avy" "\
Jump to one of the current isearch candidates.
\(fn)" t nil)

(setq avy-style 'at-full)


(require 'init-flycheck) ; -------
(require 'init-emmet) ; ---------
(require 'init-company) ; ------
;; (require 'init-php) ; ------
(require 'init-javascript) ; -----
(require 'init-python) ; -----
(require 'init-web) ; -----------


; Enable modes
(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.gitconfig$" . conf-mode))

; (setq markdown-css-path (expand-file-name "markdown.css" abedra/vendor-dir))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
(add-hook 'markdown-mode-hook
          (lambda ()
            (visual-line-mode t)
            (flyspell-mode t)))

(setq markdown-command "pandoc --smart -f markdown -t html")

;;--------------------
;; Indentation setup
;;-------------------

(setq-default indent-tabs-mode nil) ; never use tab characters for indentation
(setq tab-width 2 ; set tab-width
      c-default-style "stroustrup" ; indent style in CC mode
      css-indent-offset 2) ; indentation level in CSS mode


(provide 'init)

;; Packages that can be usefull
;; https://github.com/abo-abo/hydra  ; for key mappings
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
