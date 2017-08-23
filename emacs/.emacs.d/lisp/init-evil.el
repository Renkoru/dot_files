;;; init-evil.el --- Evil mode configuration
;;; Commentary:
;;; Code:


(use-package evil
  ;; :bind ("C-u" . evil-scroll-up)

  ;;        :map evil-insert-state-map
  ;;        ;; Unbind evil key maps to enable using Emacs
  ;;        ("C-e" . nil)
  ;;        ("C-a" . nil)
  ;;        )

  :config
  (evil-mode 1)

  (use-package evil-leader
    :config
    (global-evil-leader-mode 1)

    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "w" 'save-buffer
      "q" 'kill-buffer-and-window
      "=" (kbd "C-w =")
      "g" 'magit-status
      )
    )

  (use-package evil-surround
    :config (global-evil-surround-mode 1))

  (use-package evil-visualstar
    :config (global-evil-visualstar-mode t))

  (use-package evil-mc
    :config (global-evil-mc-mode 1))

  (use-package evil-matchit
    :config (global-evil-matchit-mode 1))

  (use-package vimish-fold
    :bind (:map evil-visual-state-map ("zf" . vimish-fold)

                :map evil-normal-state-map
                ("zd" . vimish-fold-delete)
                ("zD" . vimish-fold-delete-all)
                ("za" . vimish-fold-toggle)
                ("zA" . vimish-fold-toggle-all)
                ("zo" . vimish-fold-unfold)
                ("zO" . vimish-fold-unfold-all)
                ("zc" . vimish-fold-refold)
                ("zC" . vimish-fold-refold-all)))

  (use-package drag-stuff
    :init
    (drag-stuff-global-mode 1)
    :bind (:map evil-normal-state-map
                ("M-k" . drag-stuff-up)
                ("M-j" . drag-stuff-down)
                ("M-l" . drag-stuff-right)
                ("M-h" . drag-stuff-left)))


  (setq evil-emacs-state-cursor '("#8b0000" box))
  (setq evil-normal-state-cursor '("ForestGreen" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-insert-state-cursor '("#8b0000" bar))
  (setq evil-replace-state-cursor '("#8b0000" bar))
  (setq evil-operator-state-cursor '("#8b0000" hollow))

  (use-package evil-nerd-commenter
    ;; :ensure t ;; for some reason cask resolvs this dependency bad

    :bind (:map evil-normal-state-map
                ("gcc" . evilnc-comment-or-uncomment-lines)
                )
    )

  (use-package evil-anzu)

  ;; Evil settings
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

  (define-key evil-normal-state-map (kbd "[ SPC") (kbd "ko <escape> j"))
  (define-key evil-normal-state-map (kbd "] SPC") (kbd "o <escape> k"))

  (define-key evil-normal-state-map (kbd "[ SPC") (kbd "ko <escape> j"))
  (define-key evil-normal-state-map (kbd "] SPC") (kbd "o <escape> k"))

  (define-key evil-normal-state-map (kbd "go") 'helm-semantic-or-imenu)

  (define-key evil-normal-state-map (kbd "tol") 'linum-mode)

  (define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-insert-state-map (kbd "C-a") 'beginning-of-line)

  )


(use-package rainbow-delimiters
  :config
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

  :bind (:map evil-normal-state-map
         ("tor" . rainbow-delimiters-mode)))

(global-set-key [(shift f12)] 'highlight-symbol-prev)
; (global-rainbow-delimiters-mode)

(use-package evil-goggles
  :config
  (setq evil-goggles-duration 0.100)
  (evil-goggles-mode)
  (custom-set-faces
   '(evil-goggles-delete-face ((t (:inherit 'smerge-refined-removed))))
   '(evil-goggles-paste-face ((t (:inherit 'smerge-refined-added)))))

  ;; optionally use diff-mode's faces; as a result, deleted text
  ;; will be highlighed with `diff-removed` face which is typically
  ;; some red color (as defined by the color theme)
  ;; other faces such as `diff-added` will be used for other actions
  ;; (evil-goggles-use-diff-faces)
  )


; (define-key evil-normal-state-map "c" nil)
; (define-key evil-motion-state-map "cu" 'universal-argument)


;; When i visual select some region last mark is resetting.
;; Emacs lost it and i can't jump back to it.  (C-i)
;; This hook add some sacrifice mark to reset it.
;; Temporary disabled be cause of bug: Visual Vim select at the end and at the start of buffer
;; (add-hook 'activate-mark-hook 'push-mark-no-activate)




(provide 'init-evil)

;;; init-evil.el ends here
