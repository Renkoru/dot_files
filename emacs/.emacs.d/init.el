;;; init.el --- Entrypoint of Emacs settings
;;; Commentary:

;;; Code:
(defvar elpaca-installer-version 0.8)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(defvar elpaca-order-defaults (list :protocol 'https :inherit t :depth 1)
  "Default order modifications.")
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
  ;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
  ;; Assume :elpaca t unless otherwise specified.
  (setq elpaca-use-package-by-default t))



;; End of Elpaca setup ---------------------------------------------------------------------------------------------

(use-package general
  :demand
  :config
  (general-evil-setup)
  (general-create-definer my-general-g-definer :states 'normal :prefix "g")
  (general-create-definer my-space-leader :states 'normal :prefix "<SPC>")
  (general-create-definer my-crux-text-definer :states '(normal visual) :prefix "]")
  )
(elpaca-wait)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; ---------------------------------------------------------------------------------------------

;; (setq
;;  package-archives '(("melpa" . "https://melpa.org/packages/")
;;                     ("org" . "http://orgmode.org/elpa/")
;;                     ("gnu" . "https://elpa.gnu.org/packages/"))
;;  )

;; (require 'init-elpaca) ;; package manager

;; (require 'init-straight) ;; package manager

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  ;; :init
  ;; (setq exec-path-from-shell-debug t)
  :config
  (exec-path-from-shell-initialize)

  ;; ssh-agent socket settings
  ;; (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
  )

;; --------------------------------- System packages
;; (use-package realgud) ;; debugging, try it sometime. (Hard with docker env)
(use-package smex) ;; ranking and remembering M-x
(use-package vlf) ;; open big files by chunks
(use-package s) ;; advanced strings manupulations

;; https://github.com/mhayashi1120/Emacs-wgrep
;; Note: you need manually activate evil-normal mode to make it work there
(use-package wgrep)


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

;; Not working properly. Sometimes misses the focus, sometime hides the content...
;; (use-package mini-frame
;;   :config
;;   (mini-frame-mode +1)
;;   (setq mini-frame-resize t)
;;   (setq mini-frame-show-parameters `((left . 0.6)
;;                                      (top . 0.3)
;;                                      (width . 0.55)
;;                                      (height . 1)
;;                                      (internal-border-width . 0)
;;                                      (left-fringe . 10)
;;                                      (right-fringe . 10)
;;                                      ;; (font . ,(font-spec :family "SF Mono" :size 17 :weight 'medium))
;;                                      ))
;;     (add-to-list 'mini-frame-ignore-commands 'consult-ripgrep)
;;     (add-to-list 'mini-frame-ignore-commands 'consult-line)
;;     (add-to-list 'mini-frame-ignore-commands 'consult-imenu)
;;     (add-to-list 'mini-frame-ignore-commands 'consult-yank-pop)
;;   )

;; --------------------------------- Include lisp blocks
(require 'init-javascript)
(require 'init-emacs)
(require 'init-hydra) ; should be initialized before evil
(require 'init-vcs) ; should be before evil
(require 'init-evil)
(require 'init-evil-mlang) ; should go after evil settigns
;; (require 'init-ivy)
;; (require 'init-selectrum-stack)
(require 'init-vertico-stack)
(require 'init-appearance)
(require 'init-modeline)
(require 'init-yasnippet) ; should be initialized before auto-complete
(require 'init-custom-functions)
(require 'init-spellcheck)
;; (require 'init-flyspell)
;; (require 'init-lsp)

(require 'init-internal-apps)

;; --------------------------------- Useful stuff
;; Keep same configs for all team (all editors)
(use-package editorconfig
  :config
  (editorconfig-mode 1))

;; Code foramters runner
;; https://github.com/raxod502/apheleia
;; TODO check if if works
;; (straight-use-package '(apheleia :host github :repo "raxod502/apheleia"))

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
;; (require 'init-company)
(require 'init-corfu)

;; --------------------------------- File type modes
(require 'init-programming)
(require 'init-org)
(require 'init-journal)
(require 'init-docker)
;; (require 'init-lisp)

(use-package string-inflection
  :ensure t) ; conversion of variable name formats
;; Replaced by treesitter?
;; (use-package json-mode
;;   :config
;;   (add-hook 'json-mode-hook
;;             (lambda ()
;;               (make-local-variable 'js-indent-level)
;;               (setq js-indent-level 2)))
;;   )
(use-package fish-mode)
(use-package markdown-mode)
(use-package yaml-mode
  :mode (("\\.yaml?\\'" . yaml-mode)
         ("\\.yml?\\'" . yaml-mode)
         )
  )
(use-package yaml-pro
  :mode (("\\.yaml?\\'" . yaml-pro-ts-mode)
         ("\\.yml?\\'" . yaml-pro-ts-mode))
  :after yaml-mode
  :config
  (eldoc-mode 1)
  )

(use-package nginx-mode)
;; (use-package company-nginx
;;   :after nginx-mode
;;   :config
;;   (add-hook 'nginx-mode-hook #'company-nginx-keywords))

(require 'init-emmet)
(require 'init-web) ; should be before javascript init

;; !! Cause some freezes in some cases: org, tramp?

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
(use-package go-mode
  :after eglot
  :mode (("\\.go?\\'" . go-ts-mode)
         ;; ("\\.ts\\'" . jtsx-typescript-mode)
         )
  :hook
  (go-ts-mode . eglot-format-buffer-on-save)
  (go-ts-mode . eglot-ensure)

  :init
  (setq-default tab-width 2)
  (setq-default go-ts-mode-indent-offset 2)

  ;; :config

  ;; (add-hook 'go-ts-mode-hook 'eglot-ensure)
  ;; (add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))

  )
;; (add-hook 'go-mode-hook #'lsp)
;; (add-hook 'go-mode-hook 'lsp-deferred)
;; Go tools https://github.com/golang/tools/blob/master/gopls/doc/emacs.md
;; to check https://sandyuraz.com/blogs/go-emacs/
;; to check https://geeksocket.in/posts/emacs-lsp-go/

(use-package nushell-ts-mode
  :mode (("\\.nu?\\'" . nushell-ts-mode))
  :ensure (:host github :repo "herbertjones/nushell-ts-mode"))
;; :config
;; (require 'nushell-ts-babel)
;; (defun hfj/nushell/mode-hook ()
;;   (corfu-mode 1)
;;   (highlight-parentheses-mode 1)
;;   (electric-pair-local-mode 1)
;;   (electric-indent-local-mode 1))
;; (add-hook 'nushell-ts-mode-hook 'hfj/nushell/mode-hook))

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
   '("f0eb51d80f73b247eb03ab216f94e9f86177863fb7e48b44aacaddbfe3357cf1" "ab058aa22bdaf17b5d8a9e21632a62c8966728ae10ef8fd07e95637e9cdf7a7b" "c0a0c2f40c110b5b212eb4f2dad6ac9cac07eb70380631151fa75556b0100063" "a44e2d1636a0114c5e407a748841f6723ed442dc3a0ed086542dc71b92a87aee" "8d7b028e7b7843ae00498f68fad28f3c6258eda0650fe7e17bfb017d51d0e2a2" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" default))
 '(git-gutter:hide-gutter t)
 '(mini-frame-show-parameters '((top . 0.3) (width . 0.6) (left . 0.6)))
 '(org-agenda-files
   '("/home/mrurenko/projects/diary/notes/2021/09.org" "/home/mrurenko/projects/diary/notes/2018/05.org"))
 '(safe-local-variable-values
   '((mr/commit-prefix-surrounds "" ": ")
     (mr/commit-should-skip-branch-type)
     (mr/commit-should-skip-branch-type . "no")
     (mr/commit-prefix-separator . "")
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

(put 'narrow-to-region 'disabled nil)
