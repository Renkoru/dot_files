 ; init.el

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;; this loads the package manager
(require 'package)
(require 'cl) ; for loop

;;; loads packages and activates them
(package-initialize)

;;; here there's a variable named package-archives, and we are adding the MELPA repository to it
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(defvar mrurenko/packages '(smartparens ; add settings
                            drag-stuff
                            ;; expand-region ; investigate this package later
                            evil
                            evil-leader
                            evil-surround
                            evil-tabs
                            evil-nerd-commenter
                            ;; evil-easymotion ; replaced with avy
                            avy
                            neotree
                            helm
                            projectile
                            powerline
                            ;; visual ones
                            highlight-symbol
                            ;; multiple-cursors ; dont work with evil
                            rainbow-delimiters
                            rainbow-mode
                            ;; js2-mode
                            ac-slime
                            auto-complete
                            flycheck
                            magit ; Learn how to use it
                            git-gutter ; Setup plugin
                            ;; git-timemachine ; investigate this plugin later
                            markdown-mode
                            nodejs-repl
                            rvm
                            solarized-theme
                            zenburn-theme
                            web-mode
                            tern
                            tern-auto-complete
                            org
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

(require 'init-evil) ; -------------------------------------------------------------
(require 'drag-stuff)

(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)

(setq whitespace-style '(face tabs trailing tab-mark))
(global-whitespace-mode 1)

(autoload 'avy-isearch "avy" "\
Jump to one of the current isearch candidates.
\(fn)" t nil)

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

(require 'helm-config)
(helm-mode 1)

; (require 'projectile)
(projectile-global-mode)
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

; Disable backup files
(setq make-backup-files nil)

;; If you want to show the matching parenthesis, brace or bracket automatically, add this option
(show-paren-mode t)

; Key bindings
;; (global-set-key (kbd "RET") 'newline-and-indent)
;; (global-set-key (kbd "C-;") 'comment-or-uncomment-region)
;; (global-set-key (kbd "M-/") 'hippie-expand)
;; (global-set-key (kbd "C-+") 'text-scale-increase)
;; (global-set-key (kbd "C--") 'text-scale-decrease)
;; (global-set-key (kbd "C-c C-k") 'compile)
;; (global-set-key (kbd "C-x g") 'magit-status)


(require 'autopair)

;; (ido-mode t)
;; (setq ido-enable-flex-matching t
;;       ido-use-virtual-buffers t)

(require 'auto-complete-config)
(ac-config-default)

; Enable modes
(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.gitconfig$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))

(defun js-custom ()
  "js-mode-hook"
  (setq js-indent-level 2))

(add-hook 'js-mode-hook 'js-custom)


(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
(add-hook 'markdown-mode-hook
          (lambda ()
            (visual-line-mode t)
            (flyspell-mode t)))
(setq markdown-command "pandoc --smart -f markdown -t html")
; (setq markdown-css-path (expand-file-name "markdown.css" abedra/vendor-dir))

(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

; Themes load
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized/")
;; (load-theme 'solarized t)
(load-theme 'zenburn t)
; (require 'color-theme-solarized)
; (color-theme-solarized)
; (setq-default custom-enabled-themes '(github))

 ;
; (require 'ido)
; (ido-mode t)
; (require 'init-yasnippet)
; (require-package 'autopair)
; (autopair-global-mode)

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
;         ; autopair
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

(provide 'init)
