 ; init.el

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;; this loads the package manager
(require 'package)
(require 'cl) ; for loop


;;; here there's a variable named package-archives, and we are adding the MELPA repository to it
; (add-to-list
;   'package-archives
;   '("marmalade" . "https://marmalade-repo.org/packages/")
;   )
(add-to-list
  'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/")
  t)

;;; loads packages and activates them
(package-initialize)

(defvar mrurenko/packages '(smartparens ; add settings
                            drag-stuff
                            expand-region ; investigate this package later
                            evil
                            evil-leader
                            evil-surround
                            evil-tabs
                            evil-nerd-commenter
                            ;; evil-easymotion ; replaced with avy
                            avy
                            ace-window
                            neotree
                            projectile
                            helm
                            helm-projectile
                            helm-ag
                            helm-swoop
                            powerline
                            ;; visual ones
                            highlight-symbol
                            multiple-cursors ; dont work with evil
                            rainbow-delimiters
                            rainbow-mode
                            ac-slime
                            auto-complete
                            flycheck
                            magit ; Learn how to use it
                            git-gutter ; Setup plugin
                            git-timemachine ; investigate this plugin later
                            js2-mode
                            js2-refactor
                            tern
                            tern-auto-complete
                            json-mode
                            ;; Python packages
                            ctable
                            deferred
                            epc
                            python-environment
                            jedi
                            org
                            markdown-mode
                            nodejs-repl
                            rvm
                            solarized-theme
                            zenburn-theme
                            web-mode
                            scss-mode
                            jade-mode
                            puppet-mode
                            marmalade
                            restclient
                            yaml-mode)

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

; (require 'evil)
; (evil-mode 1)

(setq backup-directory-alist `(("." . "~/.saves")))
(set-default 'truncate-lines t)


(setq x-select-enable-clipboard t)
(setq magit-last-seen-setup-instructions "1.4.0")

(require 'helm-config)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t
      helm-M-x-fuzzy-match        t
      helm-semantic-fuzzy-match   t
      helm-imenu-fuzzy-match      t)

(global-set-key (kbd "C-q") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)

(helm-mode 1)
(require 'helm-swoop)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'init-evil) ; -------------------------------------------------------------
(global-set-key (kbd "M-w") 'ace-window)
(require 'init-yasnippet) ; should be initializes before auto-complete
(require 'drag-stuff)
(require 'flycheck)
(add-hook 'js-mode-hook
          (lambda () (flycheck-mode t)))


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

;; (defun ora-ediff-hook ()
;;   (ediff-setup-keymap)
;;   (define-key ediff-mode-map "k" 'ediff-previous-difference)
;;   (define-key ediff-mode-map "j" 'ediff-next-difference))

;; (add-hook 'ediff-mode-hook 'ora-ediff-hook)

;;; yasnippet
;;; should be loaded before auto complete so that they can work together

(setq whitespace-style '(face tabs trailing tab-mark))
(global-whitespace-mode 1)

(require 'highlight-symbol)
(global-set-key [(control f12)] 'highlight-symbol)
(global-set-key [f12] 'highlight-symbol-next)
(global-set-key [(shift f12)] 'highlight-symbol-prev)

;; (require 'paredit)
(require 'smartparens-config)
(package-initialize)
(smartparens-global-mode t)
(sp-pair "'" "'")


(require 'avy)
;; Bind key for isearch C-' to activate avy
(avy-setup-default)

(autoload 'avy-isearch "avy" "\
Jump to one of the current isearch candidates.
\(fn)" t nil)

(setq avy-style 'at-full)
;; (setq avy-background t)

; (require 'projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
; (setq projectile-completion-system 'helm)
; (require 'helm-projectile)
; (helm-projectile-on)

(require 'powerline)
; (require 'powerline-evil)
; (powerline-evil-theme)
; (powerline-default-theme)
(powerline-center-evil-theme)

; Hide elements
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

; Disable backup and autosave files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; If you want to show the matching parenthesis, brace or bracket automatically, add this option
(show-paren-mode t)


(require 'auto-complete-config)
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

; Enable modes
(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.gitconfig$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))

;; JS -----------------------------------------------------------------
(add-hook 'js-mode-hook 'js2-minor-mode)
(defun js-custom ()
  "js-mode-hook"
  (setq js-indent-level 2))

(add-hook 'js-mode-hook 'js-custom)
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(custom-set-variables
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
)


;; Add this to your .emacs to initialize tern and tern-auto-complete
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

(setq js2-highlight-level 3)



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
;; (load-theme 'solarized t)
(load-theme 'zenburn t)
; (require 'color-theme-solarized)
; (color-theme-solarized)
; (setq-default custom-enabled-themes '(github))


(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(setq web-mode-css-indent-offset 2)

(setq web-mode-ac-sources-alist
      '(("css" . (ac-source-css-property))
        ("html" . (ac-source-words-in-buffer ac-source-abbrev))))



; package
; (when (>= emacs-major-version 24)
;   (require 'package)
;   (package-initialize)
;   (push '("marmalade" . "http://marmalade-repo.org/packages/")
;         package-archives )
;   (push '("melpa" . "http://melpa.milkbox.net/packages/")
;         package-archives)
;   ; (package-initialize)

;   )

; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")

; (unless (require 'el-get nil t)
;   (url-retrieve
;    "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
;    (lambda (s)
;      (end-of-buffer)
;      (eval-print-last-sexp))))

; (setq my:el-get-packages
;       '(yasnippet
;         evil
;         ; org-mode
;         ; anything
;         ; emms
;         ; dired-sort
;         ; auto-dictionnary
;         ; color-theme
;         ; dired+
;         ; google-maps
;         ; org2blog
;         ; rainbow-mode
;         ; switch-window
;         ; sr-speedbar
;         ; typopunct
;         ))

; (el-get 'sync my:el-get-packages)

;;--------------------
;; Indentation setup
;;-------------------

(setq-default indent-tabs-mode nil) ; never use tab characters for indentation
(setq tab-width 2 ; set tab-width
      c-default-style "stroustrup" ; indent style in CC mode
      js-indent-level 2 ; indentation level in JS mode
      css-indent-offset 2) ; indentation level in CSS mode
(add-hook 'python-mode-hook
          (lambda ()
            (setq tab-width 4)
            ))

;; make return key also do indent, globally
(electric-indent-mode 1)


;; Python
(add-hook 'python-mode-hook 'jedi:setup)
;; (add-hook 'python-mode-hook 'jedi:ac-setup)
(setq jedi:complete-on-dot t)                 ; optional

; ;;; Web-mode
; (require-package 'web-mode)

; ; с какими файлами ассоциировать web-mode
; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
; (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
; (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

; ; настройка отступов
; (setq web-mode-markup-indent-offset 2)
; (setq web-mode-css-indent-offset 2)
; (setq web-mode-code-indent-offset 2)

; ; сниппеты и автозакрытие парных скобок
; (setq web-mode-extra-snippets '(("erb" . (("name" . ("beg" . "end"))))
;                                 ))
; (setq web-mode-extra-auto-pairs '(("erb" . (("open" "close")))
;                                   ))

; ; подсвечивать текущий элемент
; (setq web-mode-enable-current-element-highlight t)

; ;;; JS

; (require-package 'json-mode)
; (require-package 'js2-mode)
; (require-package 'ac-js2)
; (require-package 'coffee-mode)

; (require-package 'tern)
; (require-package 'tern-auto-complete)

; (add-hook 'js-mode-hook (lambda () (tern-mode t)))
; (eval-after-load 'tern
;    '(progn
;       (require 'tern-auto-complete)
;       (tern-ac-setup)))

; ; Themes load
; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
; (setq-default custom-enabled-themes '(github))


(set-face-attribute 'default nil :font "Source Code Pro")
(set-frame-font "Source Code Pro" nil t)

(provide 'init)
