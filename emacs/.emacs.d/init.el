;;; init.el --- Entrypoint of Emacs settings
;;; Commentary:

;;; Code:

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; ---------------------------------------------------------------------------------------------

(require 'init-straight) ; package manager

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; --------------------------------- System packages
;; (use-package realgud) ;; debugging, try it sometime. (Hard with docker env)
(use-package smex) ;; ranking and remembering M-x
(use-package vlf) ;; open big files by chunks
(use-package s) ;; advanced strings manupulations

;; https://github.com/mhayashi1120/Emacs-wgrep
(use-package wgrep)

(use-package general
  :demand
  :config
  (general-evil-setup)
  (general-create-definer my-general-g-definer :states 'normal :prefix "g")
  (general-create-definer my-space-leader :states 'normal :prefix "<SPC>")
  )

;; TODO: verify it is woking
(use-package dumb-jump
  :general
  ("M-d" 'dumb-jump-go)
  ("M-D" 'dumb-jump-back)
  ;; :config
  ;; (setq dumb-jump-selector 'ivy)
  )

(use-package undo-fu
  :after evil
  :config
  (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo))

(use-package mini-frame
  :config
  (mini-frame-mode +1)
  (setq mini-frame-resize t)
  (setq mini-frame-show-parameters `((left . 0.6)
                                     (top . 0.3)
                                     (width . 0.55)
                                     (height . 1)
                                     (internal-border-width . 0)
                                     (left-fringe . 10)
                                     (right-fringe . 10)
                                     ;; (font . ,(font-spec :family "SF Mono" :size 17 :weight 'medium))
                                     ))
  )

;; --------------------------------- Include lisp blocks
(require 'init-emacs)
(require 'init-hydra) ; should be initialized before evil
(require 'init-vcs) ; should be before evil
(require 'init-evil)
(require 'init-evil-mlang) ; should go after evil settigns
;; (require 'init-ivy)
(require 'init-selectrum-stack)
(require 'init-appearance)
(require 'init-modeline)
(require 'init-yasnippet) ; should be initialized before auto-complete
(require 'init-custom-functions)
(require 'init-flyspell)
(require 'init-lsp)

(require 'init-internal-apps)

;; --------------------------------- Useful stuff
;; Keep same configs for all team (all editors)
(use-package editorconfig
  :config
  (editorconfig-mode 1))

;; Code foramters runner
;; https://github.com/raxod502/apheleia
;; TODO check if if works
(straight-use-package '(apheleia :host github :repo "raxod502/apheleia"))

(use-package crux)

(use-package ace-window
  :general
  (:keymaps 'global "M-q" 'ace-window))

;; !! Cause some freezes in some cases: org, tramp?
(use-package projectile
  ;; :init
  ;; (setq projectile-completion-system 'ivy)
  :config
  (projectile-global-mode t)
  ;; :custom
  ;; (projectile-switch-project-action
  ;;  (lambda ()
  ;;    (if-let* ((last-buffer (second (projectile-project-buffers))))
  ;;        (switch-to-buffer last-buffer)
  ;;      (projectile-find-file))))
  )

(use-package beacon
  :init
  (beacon-mode 1)
  :config
  (setq beacon-size 30
        beacon-push-mark 35
        beacon-color "#ADFFB2"
        beacon-blink-when-buffer-changes t
        beacon-blink-when-point-moves t
        beacon-blink-when-window-scrolls t))

(use-package expand-region
  :general (my-space-leader "e" 'er/expand-region))

(require 'init-avy)
(require 'init-flycheck)
(require 'init-company)

;; --------------------------------- File type modes
(require 'init-org)
(require 'init-journal)
(require 'init-docker)
(require 'init-lisp)

(use-package string-inflection) ; conversion of variable name formats
(use-package json-mode)
(use-package fish-mode)
(use-package markdown-mode)
(use-package yaml-mode)
(use-package nginx-mode)
(use-package company-nginx
  :after nginx-mode
  :config
  (add-hook 'nginx-mode-hook #'company-nginx-keywords))

(require 'init-emmet)
(require 'init-web) ; should be before javascript init

;; !! Cause some freezes in some cases: org, tramp?
(require 'init-javascript)

(require 'init-python)
;; (require 'init-elm) ; Not using it

;; Elixir Tooling Integration Into Emacs
;; (use-package alchemist)

;; (use-package nyan-mode) ; Not using it?

;; (add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))
;; (add-to-list 'auto-mode-alist '("\\.gitconfig$" . conf-mode))

; (setq markdown-css-path (expand-file-name "markdown.css" abedra/vendor-dir))
;; (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
;; (add-hook 'markdown-mode-hook
;;           (lambda ()
;;             (visual-line-mode t)
;;             (flyspell-mode t)))

;; (setq markdown-command "pandoc --smart -f markdown -t html")

;; (use-package htmlize)
(use-package helpful)
;; (use-package graphql-mode)
;; (use-package )
(use-package jenkinsfile-mode)
;; (straight-use-package
;;  '(jenkinsfile-mode :type git :host github :repo "john2x/jenkinsfile-mode"))

;;--------------------
;; Indentation setup
;;-------------------

(setq-default indent-tabs-mode nil) ; never use tab characters for indentation
(setq tab-width 2 ; set tab-width
      c-default-style "stroustrup" ; indent style in CC mode
      css-indent-offset 2) ; indentation level in CSS mode

;; UTF-8 as default encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(provide 'init)
;;; init.el ends here
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    '("93268bf5365f22c685550a3cbb8c687a1211e827edc76ce7be3c4bd764054bad" "527df6ab42b54d2e5f4eec8b091bd79b2fa9a1da38f5addd297d1c91aa19b616" default))
;;  ;; '(flycheck-pylintrc "pyproject.toml")
;;  '(git-gutter:hide-gutter t)
;;  '(safe-local-variable-values
;;    '((typescript-indent-level . 2)
;;      (sgml-basic-offset . 4)
;;      (sgml-basic-offset . 2))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(evil-goggles-delete-face ((t (:inherit 'smerge-refined-removed))))
;;  '(evil-goggles-paste-face ((t (:inherit 'smerge-refined-added)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8d7b028e7b7843ae00498f68fad28f3c6258eda0650fe7e17bfb017d51d0e2a2" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" default))
 '(git-gutter:hide-gutter t)
 '(mini-frame-show-parameters '((top . 0.3) (width . 0.6) (left . 0.6)))
 '(org-agenda-files
   '("/home/mrurenko/projects/diary/notes/2021/09.org" "/home/mrurenko/projects/diary/notes/2018/05.org"))
 '(safe-local-variable-values
   '((mr/commit-prefix-separator . "")
     (mr/commit-prefix-surrounds "" " ")
     (mr/commit-pre-prefix . "")
     (mr/commit-prefix-surrounds quote
                                 ("" " ")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-goggles-delete-face ((t (:inherit 'smerge-refined-removed))))
 '(evil-goggles-paste-face ((t (:inherit 'smerge-refined-added)))))
