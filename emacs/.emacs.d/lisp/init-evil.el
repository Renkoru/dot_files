; init-evil.el

(require 'elscreen)
(require 'neotree)
(require 'evil-surround)
; (require 'evil-matchit)
(require 'evil-leader)
(require 'evil-tabs)
(require 'evil)

(require 'rainbow-delimiters)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(global-set-key [(shift f12)] 'highlight-symbol-prev)
; (global-rainbow-delimiters-mode)

(global-evil-surround-mode 1)
; (global-evil-matchit-mode 1)
(global-evil-leader-mode 1)
(global-evil-tabs-mode t)


(evil-mode 1)


;; Evil settings
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(define-key evil-normal-state-map (kbd "M-k") 'drag-stuff-up)
(define-key evil-normal-state-map (kbd "M-j") 'drag-stuff-down)

(define-key evil-normal-state-map (kbd "M-l") 'drag-stuff-right)
(define-key evil-normal-state-map (kbd "M-h") 'drag-stuff-left)

(define-key evil-normal-state-map (kbd "[ SPC") (kbd "ko <escape> j"))
(define-key evil-normal-state-map (kbd "] SPC") (kbd "o <escape> k"))

(define-key evil-normal-state-map (kbd "[ SPC") (kbd "ko <escape> j"))
(define-key evil-normal-state-map (kbd "] SPC") (kbd "o <escape> k"))

(define-key evil-normal-state-map (kbd "gcc") 'evilnc-comment-or-uncomment-lines)
(define-key evil-normal-state-map (kbd "go") 'helm-semantic-or-imenu)
(define-key evil-normal-state-map (kbd "gl") 'helm-occur)

(define-key evil-normal-state-map (kbd "tol") 'linum-mode)
(define-key evil-normal-state-map (kbd "tor") 'rainbow-delimiters-mode)

;; (global-set-key (kbd "M-b") 'helm-projectile-recentf)
;; (global-set-key (kbd "M-g") 'helm-projectile-ag)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "w" 'save-buffer
  "q" 'kill-buffer-and-window
  "=" (kbd "C-w =")
  "j" 'avy-goto-line
  "s" 'avy-goto-char-2
  "l" 'avy-goto-char-in-line
  "g" 'magit-status
  "r" 'helm-projectile-recentf
  "a" 'helm-projectile-ag

)

; (define-key evil-normal-state-map "c" nil)
; (define-key evil-motion-state-map "cu" 'universal-argument)

(global-set-key [f3] 'neotree-toggle)
(setq neo-theme 'nerd)
(add-hook 'neotree-mode-hook
        (lambda ()
          (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)
          (define-key evil-normal-state-local-map (kbd "O") 'neotree-change-root)
          (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)
          (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
          (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
          (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
          (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-horizontal-split)
          (define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-vertical-split)))


(provide 'init-evil)
