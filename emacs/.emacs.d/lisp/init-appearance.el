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

(use-package zenburn-theme
  :config
  (load-theme 'zenburn t))

(add-to-list 'default-frame-alist
             '(font . "Source Code Pro-10"))


;; smart-mode-line uses rich-minority-mode
(use-package rich-minority)
(use-package smart-mode-line
  :config
  (progn
    (setq sml/theme 'dark)
    (setq rm-whitelist '(" Helm"))
    (sml/setup)))



(provide 'init-appearance)

;;; init-appearance.el ends here
