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
;; 3. Dank Mono
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
;; set font globaly
;; (set-face-attribute 'default nil :font "mononoki-24")

;;; Code:
;; (require 'fira-code) ;; Replaced by Jira-mono?
;; (add-hook 'prog-mode-hook 'fira-code-mode)

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
;; ?. adwaita
;; ?. whiteboard
;; ?. doom-nord-light
;; ?. doom-opera-light
;; ?. doom-solarized-light
;; ?. kaolin-light

;; Good dark schemes:
;; 3. base16-nord
;; 3. base16-flat
;; 3. base16-paraiso
;; ?. kaolin-valley-dark

;; base16-ocean need some 'magit' changes
;; base16-ashes is too aggressive
;; base16-atelier-dune-light - hmmmmm, maaaay be
;; base16-atelier-estuary-light - hmmmmm, maaaay be
;; base16-atelier-estuary-light - not bad, but need to add more contrast here
;; Check this package maybe it worth it
;; - https://github.com/manuel-uberti/doneburn-theme
;; - https://github.com/bbatsov/zenburn-emacs

;; (use-package base16-theme
;;   :after ivy
;;   :config
;;   (load-theme 'base16-atelier-lakeside-light t)
;;   (set-face-attribute 'region nil :background "gold"))

(use-package doom-themes
  :after ivy
  :config
;; Global settings (defaults)
;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;       doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-nord-light t)
  )
  ;; (load-theme 'base16-atelier-lakeside-light t)
  ;; (set-face-attribute 'region nil :background "gold"))


;; (use-package material-theme
;;   :init (load-theme 'material-light t))

;; (enable-theme 'material-light)
;; (set-face-attribute 'default nil :height 230)


(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))
;; (add-to-list 'default-frame-alist '(font . "JetBrains Mono-14"))
;; (add-to-list 'default-frame-alist '(font . "Fira Code-24"))

(use-package ligature
  ;; :load-path "https://github.com/mickeynp/ligature.el"
  :straight (:host github :repo "mickeynp/ligature.el")
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "://"))
  ;; Next ligatures not working for some reason:
  ;; "\\"

  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

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
;; (global-whitespace-mode 1)


(use-package highlight-symbol
  :defer t
  :hook ((prog-mode . highlight-symbol-mode)
         (prog-mode . highlight-symbol-nav-mode))
  :init
  (setq highlight-symbol-idle-delay 1)
  :general
  ("M-<f12>" 'highlight-symbol-mode) ;; highlight symbol under a crusor
  ("C-<f12>" 'highlight-symbol)
  ("<f12>" 'highlight-symbol-next)
  ("S-<f12>" 'highlight-symbol-prev)
  (my-space-leader "h" 'highlight-symbol-at-point))

(provide 'init-appearance)

;;; init-appearance.el ends here
