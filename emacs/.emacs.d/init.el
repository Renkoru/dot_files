;;; init.el --- Entrypoint of Emacs settings
;;; Commentary:

;;; Code:

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; ---------------------------------------------------------------------------------------------

(require 'init-straight) ; package manager

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; (use-package realgud) ;; debugging, try it sometime. (Hard with docker env)
(use-package smex) ;; ranking and remembering M-x
(use-package vlf) ;; open big files by chunks
(use-package json-mode)
(use-package writeroom-mode)
(use-package fish-mode)
(use-package wgrep)
(use-package restclient)
(use-package rainbow-delimiters
  :config
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

(use-package general
  :demand
  :config
  (general-evil-setup)
  (general-create-definer my-general-g-definer :states 'normal :prefix "g")
  (general-create-definer my-space-leader :states 'normal :prefix "<SPC>"))

(use-package ranger
  :general
  ("<f3>" 'ranger)
  :config
  (setq ranger-preview-file nil)
  (setq ranger-cleanup-on-disable t))


(use-package dumb-jump
  :general
  ("M-d" 'dumb-jump-go)
  ("M-D" 'dumb-jump-back)
  :config
  (setq dumb-jump-selector 'ivy))

(require 'init-emacs)
(require 'init-hydra) ; should be initialized before evil
(require 'init-vcs) ; should be before evil
(require 'init-evil)
(require 'init-evil-mlang) ; should go after evil settigns
(require 'init-appearance)
(require 'init-modeline)
(require 'init-ivy)
(require 'init-yasnippet) ; should be initialized before auto-complete
(require 'init-custom-functions)
(require 'init-flyspell)
(require 'init-docker)
(require 'init-neotree)
(require 'init-lisp)


(use-package ace-window
  :general
  (:keymaps 'global "M-q" 'ace-window))

(use-package projectile
  :init
  (setq projectile-completion-system 'ivy)
  :config
  (projectile-global-mode t))

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
  :demand
  :general
  ("M-<f12>" 'highlight-symbol-mode) ;; highlight symbol under a crusor
  ("C-<f12>" 'highlight-symbol)
  ("<f12>" 'highlight-symbol-next)
  ("S-<f12>" 'highlight-symbol-prev)
  (my-space-leader "h" 'highlight-symbol-at-point))

(require 'init-avy)
(require 'init-flycheck)
(require 'init-emmet)
(require 'init-company)
(require 'init-web) ; should be before javascript init
(require 'init-javascript)
(require 'init-python)
(require 'init-elm)
(require 'init-org)

(use-package expand-region
  :general (my-space-leader "e" 'er/expand-region))

(use-package alchemist)

;; Keep same configs for all team (all editors)
(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package markdown-mode)
(use-package yaml-mode)
(use-package nyan-mode)

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
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:hide-gutter t)
 '(safe-local-variable-values (quote ((sgml-basic-offset . 4) (sgml-basic-offset . 2)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-goggles-delete-face ((t (:inherit (quote smerge-refined-removed)))))
 '(evil-goggles-paste-face ((t (:inherit (quote smerge-refined-added))))))
