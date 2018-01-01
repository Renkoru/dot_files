;;; init-appearance.el --- Appearance settings
;;; Commentary:

;; Themes with good github repositories:
;; - https://github.com/n3mo/cyberpunk-theme.el
;; - https://github.com/greduan/emacs-theme-gruvbox

;;
;; Good themes:
;; - leuven-theme
;; - color-theme-sanityinc-tomorrow
;; - moe-theme
;; - material-theme
;; - zenburn-theme
;; - solarized
;;
;; Good fonts:
;; 1. mononoki
;; 2. Fira Code
;; 3. Inconsolata
;; 4. Source Code Pro
;; 5. Liberation Mono
;; 6. DejaVu Sans Mono
;; 7. Anonymous Pro
;; 8. Input Mono
;; 9. Droid Sans Mono
;; 10. Iosevka

;; to set font for a singe buffer you need to:
;; (setq buffer-face-mode-face '(:family "Input Mono" :height 130 :weight light))
;; (buffer-face-mode)

;;; Code:

;; be sure that you have '~/.local/share/fonts' folder before install
;; after install setup fonts: M-x all-the-icons-install-fonts
(use-package all-the-icons :after ivy)

(use-package material-theme
  :init (load-theme 'material-light t))

(enable-theme 'material-light)
(set-face-attribute 'region nil :background "gold")

(add-to-list 'default-frame-alist '(font . "mononoki-11"))

(defun set-default-font-height ()
  (interactive)
  (text-scale-adjust 0))

(defhydra hydra-zoom ()
  "zoom"
  ("i" text-scale-increase "increase")
  ("r" set-default-font-height "reset")
  ("d" text-scale-decrease "decrease"))

(general-define-key :prefix my-leader
                    "cf" 'hydra-zoom/body)


(use-package rainbow-mode)

;; Transparency settings
;;
;; (defun toggle-transparency ()
;;   (interactive)
;;   (let ((alpha (frame-parameter nil 'alpha)))
;;     (set-frame-parameter
;;      nil 'alpha
;;      (if (eql (cond ((numberp alpha) alpha)
;;                     ((numberp (cdr alpha)) (cdr alpha))
;;                     ;; Also handle undocumented (<active> <inactive>) form.
;;                     ((numberp (cadr alpha)) (cadr alpha)))
;;               100)
;;          '(90 . 0) '(100 . 100)))))

;; (global-set-key (kbd "C-c t") 'toggle-transparency)

(setq whitespace-style '(face tabs trailing tab-mark))
(global-whitespace-mode 1)

(provide 'init-appearance)

;;; init-appearance.el ends here
