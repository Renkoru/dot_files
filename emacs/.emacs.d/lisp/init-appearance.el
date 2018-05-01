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

;; Good light schemes:
;; 1. base16-atelier-sulphurpool-light
;; 1. base16-atelier-lakeside-light
;; 2. base16-atelier-forest-light
;; 2. base16-google-light
;; 3. base16-atelier-heath-light
;; 3. base16-atelier-plateau-light
;; 3. base16-atelier-savanna-light

;; Good dark schemes:
;; 3. base16-flat
;; 3. base16-nord
;; 3. base16-paraiso

;; base16-ocean need some 'magit' changes
;; base16-ashes is too aggressive
;; base16-atelier-dune-light - hmmmmm, maaaay be
;; base16-atelier-estuary-light - hmmmmm, maaaay be
;; base16-atelier-estuary-light - not bad, but need to add more contrast here
;; Check this package maybe it worth it
;; - https://github.com/manuel-uberti/doneburn-theme
;; - https://github.com/bbatsov/zenburn-emacs

(use-package base16-theme
  :config
  (load-theme 'base16-nord t))

;; (use-package material-theme
;;   :init (load-theme 'material-light t))

;; (enable-theme 'material-light)
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

(my-space-leader "cf" 'hydra-zoom/body)


(use-package rainbow-mode)

(setq whitespace-style '(face tabs trailing tab-mark))
(global-whitespace-mode 1)

(provide 'init-appearance)

;;; init-appearance.el ends here
