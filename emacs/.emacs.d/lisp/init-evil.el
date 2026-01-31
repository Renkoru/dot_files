;;; init-evil.el --- Evil mode configuration
;;; Commentary:
;;; Code:


(use-package evil
  :bind (:map evil-normal-state-map
              ("C-h" . evil-window-left)
              ("C-j" . evil-window-down)
              ("C-k" . evil-window-up)
              ("C-l" . evil-window-right)
              ("C-a" . beginning-of-line)
              ; ("[ SPC" . crux-smart-open-line-above)

              ("<leader>w" . save-buffer)
              ("<leader>=" . balance-windows)
              :map evil-insert-state-map
              ("C-e" . end-of-line)
              )
  :config
  (evil-mode 1)

  (evil-set-leader '(normal) (kbd "SPC"))

  ; (my-crux-text-definer
  ;   "SPC" 'crux-smart-open-line
  ;   ;; "[" 'crux-smart-open-line-above
  ;   "p" 'crux-duplicate-current-line-or-region
  ;   "cp" 'crux-duplicate-and-comment-current-line-or-region)

  (defun insert-line-below ()
    "Insert an empty line below the current line."
    (interactive)
    (save-excursion
      (end-of-line)
      (open-line 1)))

  (defun insert-line-above ()
    "Insert an empty line above the current line."
    (interactive)
    (save-excursion
      (end-of-line 0)
      (open-line 1)))

  ;; (general-define-key :prefix "["
  ;;                     "SPC" 'insert-line-above)

  ;; (general-define-key :prefix "]"
  ;;                     "SPC" 'insert-line-below)

  (setq evil-emacs-state-cursor '("#8b0000" box))
  (setq evil-normal-state-cursor '("ForestGreen" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-insert-state-cursor '("#8b0000" bar))
  (setq evil-replace-state-cursor '("#8b0000" bar))
  (setq evil-operator-state-cursor '("#8b0000" hollow))

  (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)

  :init
  (require 'evil)
  )

(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode 1))

(use-package evil-visualstar
  :after evil
  :config (global-evil-visualstar-mode t))

(use-package evil-mc
  :after evil
  :bind (
         :map evil-normal-state-map
         ("<leader>cc" . hydra-mc/body)
         )
  :config
  ;; Do not use global mode, do not know how to disable default bindings

  ;; TODO general replace
  ;; (general-unbind 'normal evil-mc-key-map
  ;;   "C-n"
  ;;   "C-p")

  (defhydra hydra-mc (:color pink
                             :body-pre (progn
                                         (evil-mc-mode 1)
                                         (evil-mc-pause-cursors))
                             :before-exit (evil-mc-resume-cursors))
    "
      multiple cursors
       _m_ evil-mc-mode:       %`evil-mc-mode
      "
    ("H" highlight-symbol-at-point "highlight")
    ("c" evil-mc-make-cursor-here "create cursor")
    ("s" evil-mc-skip-and-goto-next-match "skip and next")
    ("S" evil-mc-skip-and-goto-prev-match "skip and prev")
    ("n" evil-mc-make-and-goto-next-match "make and next")
    ("p" evil-mc-make-and-goto-prev-match "make and prev")
    ("m" evil-mc-mode nil)
    ("q" nil "quit"))

  )

(use-package evil-matchit
  :after evil
  :config (global-evil-matchit-mode 1))

(use-package evil-nerd-commenter
  :after evil
  :bind (
         :map evil-normal-state-map
         ("gcc" . evilnc-comment-or-uncomment-lines)
         )
  )

(use-package evil-anzu
  :after evil
  :config
  ;; Telephone line will handle modeline for anzu
  (setq anzu-cons-mode-line-p nil)
  (global-anzu-mode +1))

(use-package evil-goggles
  :after evil
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

(use-package evil-exchange
  :after evil
  :config
  (evil-exchange-install))

(use-package evil-numbers
  :bind (
         :map evil-normal-state-map
         ("<leader>cn" . hydra-numbers/body)
         )
  :ensure (:host github :repo "cofi/evil-numbers")
  :config

  (defhydra hydra-numbers (:color pink)
    "
      change numbers
       _i_ increase
       _d_ decrease
      "
    ("i" evil-numbers/inc-at-pt "increase")
    ("d" evil-numbers/dec-at-pt "decrease")
    ("q" nil "quit"))
  )



(provide 'init-evil)

;;; init-evil.el ends here
