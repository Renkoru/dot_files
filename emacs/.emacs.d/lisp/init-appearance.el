;;; init-appearance.el --- Appearance settings
;;; Commentary:

;; Themes with good github repositories:
;; - https://github.com/n3mo/cyberpunk-theme.el
;; - https://github.com/greduan/emacs-theme-gruvbox

;;
;; Good themes:
;; - ayu-theme
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

;;; Coding fonts:
;; Fira code

;; be sure that you have '~/.local/share/fonts' folder before install
;; after install setup fonts: M-x all-the-icons-install-fonts
;; (use-package all-the-icons)
;; (use-package all-the-icons-completion
;;   :init
;;   (all-the-icons-completion-mode)
;;   (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)
;;   )



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

;; Ayu original looks better (support more formats) then in doom package
(use-package ayu-theme
  :config (load-theme 'ayu-light t))

;; (use-package nano-theme
;;   :straight (nano-theme :host github :type git
;;                     :repo "rougier/nano-theme")
;;   :config (load-theme 'nano-light t))


;; If you search for something new - check this https://beebom.com/best-visual-studio-code-themes/
;; https://levelup.gitconnected.com/10-pretty-light-themes-for-vs-code-80dbf6405f39
;; Doom-themes have a lot integrated themes check it's content first
(use-package doom-themes
  :after ivy
  :config
;; Global settings (defaults)
;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;       doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; (load-theme 'doom-ayu-light t)
  )
  ;; (load-theme 'base16-atelier-lakeside-light t)
  ;; (set-face-attribute 'region nil :background "gold"))


;; (use-package material-theme
;;   :init (load-theme 'material-light t))

;; (enable-theme 'material-light)
;; (set-face-attribute 'default nil :height 230)


;; You need to install font "sudo pacman -S ttf-jetbrains-mono-nerd"
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font Mono-11"))
;; (add-to-list 'default-frame-alist '(font . "JetBrains Mono-14"))

(use-package ligature
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<*>" "<||" "<|>" "<$>" "||=" "||>" "----"
                                       ">:" ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>"  "<==" "<=>" "<=<" "<->" "<==>" "<!--" "~~>"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>"  "..<"
                                       "***" "**" "**/" "*>" "*/" "/**"
                                       "||" "|}" "|]" "|=" "|>" "|-" "{|" "{-" "-}"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" "!!."
                                       "###" "#_(" "####" "#{" "#[" "#:" "#=" "#!" "##" "#(" "#?" "#_"
                                       "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-"
                                       "://" "\\\\" "\\\\\\"))
  ;; Next ligatures not working for some reason:
  ;; (empty)

  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(use-package nerd-icons
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )


(use-package nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package nerd-icons-dired
  :ensure (nerd-icons-dired :type git :host github :repo "rainstormstudio/nerd-icons-dired")
  :hook
  (dired-mode . nerd-icons-dired-mode)
  :custom
  (nerd-icons-scale-factor 1.5)
  )

;; Show icons in completion region
(use-package kind-icon
  :after (corfu nerd-icons)
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
  (setq kind-icon-use-icons nil)
  (setq kind-icon-mapping
        `(
          (array ,(nerd-icons-codicon "nf-cod-symbol_array") :face font-lock-type-face)
          (boolean ,(nerd-icons-codicon "nf-cod-symbol_boolean") :face font-lock-builtin-face)
          (class ,(nerd-icons-codicon "nf-cod-symbol_class") :face font-lock-type-face)
          (color ,(nerd-icons-codicon "nf-cod-symbol_color") :face success)
          (command ,(nerd-icons-codicon "nf-cod-terminal") :face default)
          (constant ,(nerd-icons-codicon "nf-cod-symbol_constant") :face font-lock-constant-face)
          (constructor ,(nerd-icons-codicon "nf-cod-triangle_right") :face font-lock-function-name-face)
          (enummember ,(nerd-icons-codicon "nf-cod-symbol_enum_member") :face font-lock-builtin-face)
          (enum-member ,(nerd-icons-codicon "nf-cod-symbol_enum_member") :face font-lock-builtin-face)
          (enum ,(nerd-icons-codicon "nf-cod-symbol_enum") :face font-lock-builtin-face)
          (event ,(nerd-icons-codicon "nf-cod-symbol_event") :face font-lock-warning-face)
          (field ,(nerd-icons-codicon "nf-cod-symbol_field") :face font-lock-variable-name-face)
          (file ,(nerd-icons-codicon "nf-cod-symbol_file") :face font-lock-string-face)
          (folder ,(nerd-icons-codicon "nf-cod-folder") :face font-lock-doc-face)
          (interface ,(nerd-icons-codicon "nf-cod-symbol_interface") :face font-lock-type-face)
          (keyword ,(nerd-icons-codicon "nf-cod-symbol_keyword") :face font-lock-keyword-face)
          (macro ,(nerd-icons-codicon "nf-cod-symbol_misc") :face font-lock-keyword-face)
          (magic ,(nerd-icons-codicon "nf-cod-wand") :face font-lock-builtin-face)
          (method ,(nerd-icons-codicon "nf-cod-symbol_method") :face font-lock-function-name-face)
          (function ,(nerd-icons-codicon "nf-cod-symbol_method") :face font-lock-function-name-face)
          (module ,(nerd-icons-codicon "nf-cod-file_submodule") :face font-lock-preprocessor-face)
          (numeric ,(nerd-icons-codicon "nf-cod-symbol_numeric") :face font-lock-builtin-face)
          (operator ,(nerd-icons-codicon "nf-cod-symbol_operator") :face font-lock-comment-delimiter-face)
          (param ,(nerd-icons-codicon "nf-cod-symbol_parameter") :face default)
          (property ,(nerd-icons-codicon "nf-cod-symbol_property") :face font-lock-variable-name-face)
          (reference ,(nerd-icons-codicon "nf-cod-references") :face font-lock-variable-name-face)
          (snippet ,(nerd-icons-codicon "nf-cod-symbol_snippet") :face font-lock-string-face)
          (string ,(nerd-icons-codicon "nf-cod-symbol_string") :face font-lock-string-face)
          (struct ,(nerd-icons-codicon "nf-cod-symbol_structure") :face font-lock-variable-name-face)
          (text ,(nerd-icons-codicon "nf-cod-text_size") :face font-lock-doc-face)
          (typeparameter ,(nerd-icons-codicon "nf-cod-list_unordered") :face font-lock-type-face)
          (type-parameter ,(nerd-icons-codicon "nf-cod-list_unordered") :face font-lock-type-face)
          (unit ,(nerd-icons-codicon "nf-cod-symbol_ruler") :face font-lock-constant-face)
          (value ,(nerd-icons-codicon "nf-cod-symbol_field") :face font-lock-builtin-face)
          (variable ,(nerd-icons-codicon "nf-cod-symbol_variable") :face font-lock-variable-name-face)
          (t ,(nerd-icons-codicon "nf-cod-code") :face font-lock-warning-face)))
  )

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


;; save position for evil-jump before jump
(defun mr/highlight-symbol-next ()
  (interactive)
  (evil--jumps-push)
  (highlight-symbol-jump 1))

;; save position for evil-jump before jump
(defun mr/highlight-symbol-prev ()
  (interactive)
  (evil--jumps-push)
  (highlight-symbol-jump -1))


(use-package highlight-symbol
  :defer t
  :hook ((prog-mode . highlight-symbol-mode)
         (prog-mode . highlight-symbol-nav-mode))
  :init
  (setq highlight-symbol-idle-delay 1)

  :general
  (general-nmap
    "C-n" 'mr/highlight-symbol-next
    "C-p" 'mr/highlight-symbol-prev)
  (my-space-leader "h" 'highlight-symbol))

(use-package rainbow-delimiters
  :config
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

;; highlight parentheses that wraps the current position
(use-package highlight-parentheses
  :config
  (add-hook 'prog-mode-hook #'highlight-parentheses-mode))

(provide 'init-appearance)

;;; init-appearance.el ends here
