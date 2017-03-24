;;; init-appearance.el --- Appearance settings
;;; Commentary:
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

(use-package leuven-theme
  :config
  (load-theme 'leuven t))

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



(provide 'init-appearance)

;;; init-appearance.el ends here
