;;; init-appearance.el --- Appearance settings
;;; Commentary:

;; Themes with good github repositories:
;; - https://github.com/n3mo/cyberpunk-theme.el
;; - https://github.com/greduan/emacs-theme-gruvbox

;;
;;  Good themes:
;;  - leuven-theme
;;  - color-theme-sanityinc-tomorrow
;;  - moe-theme
;;  - material-theme
;;  - zenburn-theme
;;  - solarized
;;
;; Good fonts:
;; - Source Code Pro
;; - Inconsolata
;; - DejaVu Sans Mono
;; - Liberation Mono
;; - Anonymous pro
;;
;;
;;; Code:

;; (use-package leuven-theme
;;   :init (load-theme 'leuven t t)
;;   :defer t)

;; (use-package ample-theme
;;   :init (progn (load-theme 'ample t t)
;;                (load-theme 'ample-flat t t)
;;                (load-theme 'ample-light t t))
;;   :defer t)

;; (use-package color-theme-sanityinc-tomorrow
;;   :defer t)

;; (use-package solarized-theme
;;   :defer t)

;; be sure that you have '~/.local/share/fonts' folder before install
;; after install setup fonts: M-x all-the-icons-install-fonts
(use-package all-the-icons :after ivy)

(use-package material-theme
  :init (progn
          (load-theme 'material-light t))
  :config
  :defer t)

;; (enable-theme 'leuven t)
;; (enable-theme 'ample-light)
(progn
  (enable-theme 'material-light)
  (set-face-attribute 'region nil :background "gold"))

(add-to-list 'default-frame-alist
             '(font . "Source Code Pro-10"))


;; smart-mode-line uses rich-minority-mode
(use-package rich-minority)
(use-package smart-mode-line
  :config
  (progn
    (setq sml/theme 'light)
    (setq rm-whitelist '(" Helm"))
    (sml/setup)))


;; set font height
(set-face-attribute 'default nil :height 100)

(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(90 . 0) '(100 . 100)))))

(global-set-key (kbd "C-c t") 'toggle-transparency)

(setq whitespace-style '(face tabs trailing tab-mark))
(global-whitespace-mode 1)


(provide 'init-appearance)

;;; init-appearance.el ends here
