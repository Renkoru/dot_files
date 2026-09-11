;;; init.el --- Entrypoint of Emacs settings
;;; Commentary:

;;; Code:

;; ── Package.el + package-vc setup ──────────────────────────────
(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

;; Ensure compat ≥ 31 is available BEFORE package-initialize.
;; Emacs 30 ships compat 30 as built-in, but modern packages (corfu,
;; etc.) require ≥ 31.  Installing from git avoids an autoloads-generation
;; bug in the GNU ELPA tar.  Must happen before package-initialize so the
;; built-in compat doesn't shadow the new one during installation.
(require 'package-vc nil t)
(require 'cl-lib)
(cl-letf (((symbol-function 'yes-or-no-p) (lambda (&rest _) t))
          ((symbol-function 'y-or-n-p) (lambda (&rest _) t)))
  (unless (package-installed-p 'compat '(31))
    (package-vc-install "https://github.com/emacs-compat/compat")))

(package-initialize)

;; Refresh package archives on first run (idempotent)
(unless package-archive-contents
  (package-refresh-contents))

;; ── VC (Git-sourced) packages ──────────────────────────────────
;; Pre-install key transitive dependencies (compat ≥ 31 already installed above).
(dolist (pkg '(s transient markdown-mode magit))
  (unless (package-installed-p pkg)
    (condition-case nil (package-install pkg) (error nil))))

(setq package-vc-selected-packages
      '((nushell-ts-mode :url "https://github.com/herbertjones/nushell-ts-mode")
        (turbo-log :url "https://github.com/artawower/turbo-log.el")
        (combobulate :url "https://github.com/mickeynp/combobulate")
        (aider :url "https://github.com/tninja/aider.el")
        (outline-indent :url "https://github.com/jamescherti/outline-indent.el")
        (svelte-ts-mode :url "https://github.com/leafOfTree/svelte-ts-mode")
        (jsdoc :url "https://github.com/isamert/jsdoc.el")
        (nerd-icons-dired :url "https://github.com/rainstormstudio/nerd-icons-dired")))

;; Install any missing VC packages (idempotent — fast on subsequent starts).
(cl-letf (((symbol-function 'yes-or-no-p) (lambda (&rest _) t))
          ((symbol-function 'y-or-n-p) (lambda (&rest _) t)))
  (package-vc-install-selected-packages))

;; Ensure use-package auto-installs MELPA/ELPA packages.
;; Must require use-package explicitly, otherwise use-package-always-ensure
;; has no effect until the first explicit :ensure triggers the autoload.
(require 'use-package)
(setq use-package-always-ensure t)

;; Add local lisp directory to load-path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; ── Repair function: reinstall any packages that failed ──────
;; If a package install fails (network glitch, etc.), use-package
;; logs "Cannot load X" and continues.  Run this to batch-repair:
;;   M-x mr/reinstall-missing-packages
(defun mr/reinstall-missing-packages ()
  "Reinstall any declared packages that are missing (use after errors)."
  (interactive)
  (let ((missing nil))
    (dolist (pkg package-selected-packages)
      (unless (package-installed-p pkg)
        (push pkg missing)))
    (if missing
        (progn
          (message "Installing %d missing packages: %s"
                   (length missing) missing)
          (dolist (pkg (nreverse missing))
            (condition-case err
                (package-install pkg)
              (error (message "Failed: %s — %s" pkg (error-message-string err))))))
      (message "All %d declared packages are installed."
               (length package-selected-packages)))))
;; ── End of Package setup ──────────────────────────────────────

(use-package projectile
  :init
  (setq projectile-project-search-path '("~/projects/"))
  :config
  ;; I typically use this keymap prefix on macOS
  ;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  ;; On Linux, however, I usually go with another one
  ;; (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  ;; (global-set-key (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

;; --------------------------------- Include lisp blocks
(use-package crux)
(require 'init-emacs)
;; [meow-migration] init-meow must load before packages that bind to meow keymaps
(require 'init-meow)
(require 'init-meow-mlang)
(require 'init-internal-apps)
;; (require 'init-evil)  -- commented out, migrated to meow
(require 'init-corfu)
(require 'init-vertico-stack)
(require 'init-appearance)
(require 'init-my-hydra)
(require 'init-vcs)

(add-hook 'after-change-major-mode-hook
          (lambda ()
            (when (derived-mode-p 'magit-mode)
              (meow-mode -1)))
          100)

(require 'init-org)
(require 'init-avy)

;; (setenv "PATH" (concat "/home/mrurenko/.asdf/shims" path-separator (getenv "PATH")))
;; (setq exec-path (append exec-path '("/home/mrurenko/.asdf/shims")))
(setenv "PATH" (concat "/home/mrurenko/.local/share/mise/shims" path-separator (getenv "PATH")))
(setq exec-path (append exec-path '("/home/mrurenko/.local/share/mise/shims")))
(setq exec-path (append exec-path '("/home/mrurenko/.local/bin")))
(setq-default eshell-path-env (getenv "PATH"))
;; Removed: exec-path-from-shell (replaced by mise path setup below).

;; --------------------------------- System packages
;; Removed: realgud (debugging, hard with docker env).
(use-package smex) ;; ranking and remembering M-x
(use-package vlf) ;; open big files by chunks
(use-package s) ;; advanced strings manupulations

;; https://github.com/mhayashi1120/Emacs-wgrep
;; Note: you need manually activate evil-normal mode to make it work there
(use-package wgrep)

;; Removed: dumb-jump config (was unstable with meow, kept for future investigation).

(use-package undo-fu
  ;; [meow-migration] :after evil → :after meow, keymap changed
  :after meow
  :config
  ;; (define-key meow-normal-state-keymap "u" 'undo-fu-only-undo)
  (define-key meow-normal-state-keymap "\C-r" 'undo-fu-only-redo)
  ;; Original evil bindings (commented out):
  ;; (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  ;; (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo)
  )

;; Removed: mini-frame config (was unstable — missed focus, hid content).

(use-package doom-modeline
  :init
  (setq nerd-icons-scale-factor 1.0)
  (doom-modeline-mode 1)
  )

;; --------------------------------- Include lisp blocks
(require 'init-javascript)
;; [meow-migration] init-evil-mlang.el replaced by init-meow-mlang.el
;; (require 'init-evil-mlang)  -- commented out, migrated to meow
;; (require 'init-ivy)
;; (require 'init-selectrum-stack)
                                        ; (require 'init-modeline)
(require 'init-yasnippet) ; should be initialized before auto-complete
                                        ; (require 'init-custom-functions)
(require 'init-spellcheck)
;; (require 'init-flyspell)
;; Removed: lsp-mode config (migrated to eglot).

;; --------------------------------- Useful stuff
;; Keep same configs for all team (all editors)
(use-package editorconfig
  :config
  (editorconfig-mode 1))

;; Code foramters runner
;; https://github.com/raxod502/apheleia
;; TODO check if if works
;; (straight-use-package '(apheleia :host github :repo "raxod502/apheleia"))


(use-package ace-window
  :bind (("M-q" . ace-window)
         :map prog-mode-map
         ("M-q" . ace-window)))

;; !! Cause some freezes in some cases: org, tramp?

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

(use-package expand-region)

(require 'init-flycheck)
;; (require 'init-company)

;; --------------------------------- File type modes
(require 'init-programming)
(require 'init-journal)
(require 'init-docker)
;; (require 'init-lisp)

(use-package string-inflection
  :ensure t) ; conversion of variable name formats
;; Replaced by treesitter?
;; Removed: json-mode (replaced by treesitter).
(use-package fish-mode)
(use-package markdown-mode)

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-ts-mode))
(use-package yaml-pro
  :mode (
         ("\\.yaml?\\'" . yaml-pro-ts-mode)
         ("\\.yml?\\'" . yaml-pro-ts-mode))
  :after yaml-mode)

(use-package nginx-mode)
;; Removed: company-nginx (company replaced by corfu).

(require 'init-emmet)
;; (require 'init-web) ; should be before javascript init

;; !! Cause some freezes in some cases: org, tramp?

(require 'init-python)
;; Removed: init-elm (not using Elm).
;; Removed: alchemist (Elixir — not using).
;; Removed: nyan-mode (novelty).
;; Removed: auto-mode-alist entries for zsh, gitconfig, markdown (unnecessary).
;; Removed: htmlize, graphql-mode (unused).
(use-package jenkinsfile-mode)
;; Removed: old straight-use-package for jenkinsfile-mode (now on MELPA).
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
  )
;; Removed: go-mode lsp hooks (migrated to eglot).

(use-package nushell-ts-mode
  :mode (("\\.nu?\\'" . nushell-ts-mode))
  :ensure nil)
;; :config
;; (require 'nushell-ts-babel)
;; (defun hfj/nushell/mode-hook ()
;;   (corfu-mode 1)
;;   (highlight-parentheses-mode 1)
;;   (electric-pair-local-mode 1)
;;   (electric-indent-local-mode 1))
;; (add-hook 'nushell-ts-mode-hook 'hfj/nushell/mode-hook))

(use-package tintin-mode)


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
   '("aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
     "7c3d62a64bafb2cc95cd2de70f7e4446de85e40098ad314ba2291fc07501b70c"
     "b99ff6bfa13f0273ff8d0d0fd17cc44fab71dfdc293c7a8528280e690f084ef0"
     "e184d8607cc9933f2ba8e180699365bdf8b6f311834a9e15c71947b38be0caa3"
     "f0eb51d80f73b247eb03ab216f94e9f86177863fb7e48b44aacaddbfe3357cf1"
     "ab058aa22bdaf17b5d8a9e21632a62c8966728ae10ef8fd07e95637e9cdf7a7b"
     "c0a0c2f40c110b5b212eb4f2dad6ac9cac07eb70380631151fa75556b0100063"
     "a44e2d1636a0114c5e407a748841f6723ed442dc3a0ed086542dc71b92a87aee"
     "8d7b028e7b7843ae00498f68fad28f3c6258eda0650fe7e17bfb017d51d0e2a2"
     "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4"
     default))
 '(git-gutter:hide-gutter t)
 '(lambda-line-position 'top nil nil "Customized with use-package lambda-line")
 '(mini-frame-show-parameters '((top . 0.3) (width . 0.6) (left . 0.6)))
 '(org-agenda-files
   '("/home/mrurenko/projects/diary/notes/2021/09.org"
     "/home/mrurenko/projects/diary/notes/2018/05.org"))
 '(package-selected-packages
   '(ace-window aider apheleia auto-yasnippet beacon better-jumper cape
                catppuccin-theme combobulate corfu crux dirvish
                dockerfile-mode doom-modeline embark-consult embrace
                emmet-mode evil-nerd-commenter fish-mode flycheck
                flymake-eslint git-gutter git-timemachine go-mode gt
                highlight-parentheses hydra jenkinsfile-mode jinx
                jsdoc jtsx kind-icon ligature marginalia meow
                nerd-icons-dired nerd-icons-ibuffer nginx-mode
                nushell-ts-mode orderless org-journal outline-indent
                plantuml-mode projectile rainbow-delimiters
                rainbow-mode repeat-fu rjsx-mode smex sphinx-doc
                string-inflection svelte-ts-mode symbol-overlay
                tintin-mode turbo-log undo-fu uv-mode vertico vlf
                vue-mode wgrep writeroom-mode yaml-pro))
 '(package-vc-selected-packages
   '((svelte-ts-mode :url "https://github.com/leafOfTree/svelte-ts-mode")
     (combobulate :url "https://github.com/mickeynp/combobulate")
     (turbo-log :url "https://github.com/artawower/turbo-log.el")
     (nushell-ts-mode :url
                      "https://github.com/herbertjones/nushell-ts-mode")
     (aider :url "https://github.com/tninja/aider.el")
     (outline-indent :url
                     "https://github.com/jamescherti/outline-indent.el")
     (jsdoc :url "https://github.com/isamert/jsdoc.el")
     (nerd-icons-dired :url
                       "https://github.com/rainstormstudio/nerd-icons-dired")))
 '(safe-local-variable-values
   '((mr/commit-prefix-surrounds "" ": ")
     (mr/commit-should-skip-branch-type)
     (mr/commit-should-skip-branch-type . "no")
     (mr/commit-prefix-separator . "")
     (mr/commit-prefix-surrounds "" " ") (mr/commit-pre-prefix . "")
     (mr/commit-prefix-surrounds quote ("" " ")))))
;; [meow-migration] evil-goggles faces commented out (meow has no equivalent)
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(evil-goggles-delete-face ((t (:inherit 'smerge-refined-removed))))
;;  '(evil-goggles-paste-face ((t (:inherit 'smerge-refined-added)))))

(put 'narrow-to-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
