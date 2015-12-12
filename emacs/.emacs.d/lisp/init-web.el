(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))

(setq web-mode-css-indent-offset 2)
(setq web-mode-markup-indent-offset 2)

;; Highlight tag column and tag itself
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

;; (set-face-attribute 'web-mode-css-rule-face nil :foreground "Pink3")
(set-face-attribute
 'web-mode-current-column-highlight-face nil :background "white smoke")
(set-face-attribute
 'web-mode-current-element-highlight-face nil :background "pale green")

(provide 'init-web)
