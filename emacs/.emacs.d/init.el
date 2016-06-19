;; init.el

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; package manager
(require 'package)
(require 'cl) ; for loop

;;; here there's a variable named package-archives, and we are adding the MELPA repository to it
(add-to-list
  'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/")
  t)
(add-to-list
   'package-archives
   '("marmalade" . "https://marmalade-repo.org/packages/")
   )

;;; loads packages and activates them
(package-initialize)

;; Packages to check:
;; https://github.com/jacktasia/dumb-jump      Go to definition package

(defvar mrurenko/packages '(;; Base emacs tools
                            diminish
                            use-package
                            ;; Editor sugar
                            smartparens ; add settings
                            expand-region ; investigate this package later
                            ;; "evil-easymotion" replaced by avy
                            avy
                            ace-window
                            highlight-symbol
                            ;; ----------------------
                            ;; Evil plugins
                            evil
                            evil-leader
                            evil-surround
                            evil-nerd-commenter
                            evil-visualstar ; improve of * for v, V
                            ;; ----------------------
                            ;; Project navigation
                            neotree
                            projectile
                            ;; ----------------------
                            ;; Check Complition "Auto complete"
                            ;; ac-slime
                            ;; auto-complete
                            ;; tern-auto-complete
                            ;; Check Complition "Company"
                            company
                            company-anaconda
                            ;; ----------------------
                            ;; Syntax analyser
                            ;; ----------------------
                            ;; Git plugins
                            git-gutter ; Setup plugin
                            git-timemachine ; investigate this plugin later
                            ;; ----------------------
                            ;; JS packages
                            jquery-doc
                            js2-refactor
                            nodejs-repl
                            ;; ----------------------
                            ;; Python packages
                            anaconda-mode
                            pyenv-mode
                            ;; ctable
                            ;; python-environment
                            ;; deferred
                            ;; epc
                            ;; jedi
                            ;; ----------------------
                            ;; PHP packages
                            php-mode
                            ;;
                            ;; ----------------------
                            ;; Syntax modes
                            web-mode
                            markdown-mode
                            json-mode
                            scss-mode
                            jade-mode
                            puppet-mode
                            yaml-mode
                            ;; ----------------------
                            ;; Color modes
                            rainbow-delimiters
                            rainbow-mode
                            solarized-theme
                            zenburn-theme
                            leuven-theme
                            ;; ----------------------
                            ;; Plugins to test
                            emmet-mode
                            marmalade
                            restclient
                            fuzzy ; Do not work, remove?
                            org
                            rvm
                            ;; -----------------------
                            ;; CHECK THIS plugin and add it to cre of my emacs setting
                            exec-path-from-shell
                            )
  "Default packages")


(defun mrurenko/packages-installed-p ()
  (loop for pkg in mrurenko/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (mrurenko/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg mrurenko/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))


;; *** use-package settings

;; use-package.el is no longer needed at runtime
;; This means you should put the following at the top of your Emacs, to further reduce load time:
(eval-when-compile
  (require 'use-package))

;; Use ensure for all packages
(setq use-package-always-ensure t)


;; other good themes:
;; solarized
;; zenburn
;; leuven
(use-package color-theme-sanityinc-tomorrow)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-enabled-themes (quote (sanityinc-tomorrow-day)))
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "11636897679ca534f0dec6f5e3cb12f28bf217a527755f6b9e744bd240ed47e1" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" default)))
 '(fci-rule-color "#383838")
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
 '(safe-local-variable-values
   (quote
    ((checkdoc-minor-mode . t)
     (mangle-whitespace . t)
     (require-final-newline))))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))

;; Plugin: exec-path-from-shell. Setting
;; Wrap to hide pyenv-mode warning. Don't know why it happends
(setq warning-minimum-level :emergency)
(exec-path-from-shell-initialize)
(setq warning-minimum-level :warning)


;; ---------------------------------------------------------------------------------------------

(setq whitespace-style '(face tabs trailing tab-mark))
(global-whitespace-mode 1)
;; (require 'bind-key)

(eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
(eval-after-load "whitespace" '(diminish 'global-whitespace-mode))


(use-package evil-mc
  :diminish evil-mc-mode
  :config (global-evil-mc-mode 1))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


(require 'init-emacs)
(require 'init-helm) ; -------------------------------------------------------------
(require 'init-evil) ; -------------------------------------------------------------
(require 'init-yasnippet) ; should be initializes before auto-complete
(require 'init-custom-functions)


(global-set-key (kbd "M-q") 'ace-window)

(use-package vimish-fold
  :bind (:map evil-visual-state-map ("zf" . vimish-fold)

              :map evil-normal-state-map
              ("zd" . vimish-fold-delete)
              ("zD" . vimish-fold-delete-all)
              ("za" . vimish-fold-toggle)
              ("zA" . vimish-fold-toggle-all)
              ("zo" . vimish-fold-unfold)
              ("zO" . vimish-fold-unfold-all)
              ("zc" . vimish-fold-refold)
              ("zC" . vimish-fold-refold-all)))


(use-package magit)

(use-package smart-mode-line
  :config
  (progn
    (setq sml/theme 'light)
    (sml/setup)))

(use-package nyan-mode)

(use-package drag-stuff
  :diminish drag-stuff-mode
  :init
  (drag-stuff-global-mode 1)
  :bind (:map evil-normal-state-map
              ("M-k" . drag-stuff-up)
              ("M-j" . drag-stuff-down)
              ("M-l" . drag-stuff-right)
              ("M-h" . drag-stuff-left)))


(use-package projectile
  :diminish projectile-mode
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

(require 'jade-mode)

;; Customize ediff --------------------- <

;; Don't use the weird setup with the control panel in a separate frame.
;; I can manage windows in Emacs much better than my desktop (Unity or Gnome Shell) can manage the Emacs frames.
;; (custom-set-variables ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)


(require 'highlight-symbol)
(global-set-key [M-f12] 'highlight-symbol-mode)
(global-set-key [(control f12)] 'highlight-symbol)
(global-set-key [f12] 'highlight-symbol-next)
(global-set-key [(shift f12)] 'highlight-symbol-prev)

(add-hook 'highlight-symbol-mode-hook
          (lambda () (highlight-symbol-nav-mode t)))


(use-package smartparens
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (sp-pair "'" "'")))


(package-initialize)


(require 'avy)
;; Bind key for isearch C-' to activate avy
(avy-setup-default)

(autoload 'avy-isearch "avy" "\
Jump to one of the current isearch candidates.
\(fn)" t nil)

(setq avy-style 'at-full)


;; Make smooth scroll {{
;; scrolling to always be a line at a time
(setq scroll-margin 4)
(setq linum-delay t) ;; Delay updates to give Emacs a chance for other changes
(setq scroll-conservatively 10000)
(setq scroll-step 1) ;; keyboard scroll one line at a time
;; }}



(require 'init-flycheck) ; -------------------------------------------------------------
(require 'init-emmet) ; -------------------------------------------------------------
(require 'init-company) ; -------------------------------------------------------------
(require 'init-php) ; -------------------------------------------------------------
(require 'init-javascript) ; -------------------------------------------------------------
(require 'init-web) ; -------------------------------------------------------------


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
; Themes load
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized/")

;;--------------------
;; Indentation setup
;;-------------------

(setq-default indent-tabs-mode nil) ; never use tab characters for indentation
(setq tab-width 2 ; set tab-width
      c-default-style "stroustrup" ; indent style in CC mode
      css-indent-offset 2) ; indentation level in CSS mode
(add-hook 'python-mode-hook
          (lambda ()
            (setq tab-width 4)
            ))

;; make return key also do indent, globally
(electric-indent-mode 1)


;; Python
(pyenv-mode)
(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name.
Version must be already installed."
  (pyenv-mode-set (projectile-project-name)))

(add-hook 'projectile-switch-project-hook 'projectile-pyenv-mode-set)

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)

(provide 'init)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-selection-line ((t (:inherit highlight :distant-foreground "khaki"))))
 '(highlight ((t (:background "khaki" :inverse-video nil))))
 '(region ((t (:background "light goldenrod yellow" :inverse-video nil)))))
