;;; init-evil.el --- Evil mode configuration
;;; Commentary:
;;; Code:

(use-package evil
  :config
  (evil-mode 1)
  (general-nmap
    "C-h" 'evil-window-left
    "C-j" 'evil-window-down
    "C-k" 'evil-window-up
    "C-l" 'evil-window-right
    "C-a" 'beginning-of-line
    "[ SPC" 'crux-smart-open-line-above)
  (general-imap
    "C-e" 'end-of-line)

  (my-space-leader
    "w" 'save-buffer
    "q" 'delete-window
    "=" 'balance-windows)

  (my-crux-text-definer
    "SPC" 'crux-smart-open-line
    ;; "[" 'crux-smart-open-line-above
    "p" 'crux-duplicate-current-line-or-region
    "cp" 'crux-duplicate-and-comment-current-line-or-region)

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
  )

(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode 1))

(use-package evil-visualstar
  :after evil
  :config (global-evil-visualstar-mode t))

(use-package evil-mc
  :after evil
  :config
  ;; Do not use global mode, do not know how to disable default bindings

  (general-unbind 'normal evil-mc-key-map
    "C-n"
    "C-p")

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

  (my-space-leader "cc" 'hydra-mc/body))

(use-package evil-matchit
  :after evil
  :config (global-evil-matchit-mode 1))

(use-package vimish-fold
  :after evil
  :general
  (general-nvmap "zf" 'vimish-fold)

  (:states '(normal visual) :prefix "z"
           "d" 'vimish-fold-delete
           "D" 'vimish-fold-delete-all
           "a" 'vimish-fold-toggle
           "A" 'vimish-fold-toggle-all
           "o" 'vimish-fold-unfold
           "O" 'vimish-fold-unfold-all
           "c" 'vimish-fold-refold
           "C" 'vimish-fold-refold-all))

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

;; (use-package evil-textobj-tree-sitter
;;   :config
;; ;; The first arguemnt to `evil-textobj-tree-sitter-get-textobj' will be the capture group to use
;; ;; and the second arg will be an alist mapping major-mode to the corresponding query to use.
;; (define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function"
;;                                               '((typescript-ts-mode . [(function_declaration) @func])
;;                                                 ;; (rust-mode . [(use_declaration) @import])
;;                                                 )))
;;   bind `function.outer`(entire function block) to `f` for use in things like `vaf`, `yaf`
;;   (define-key evil-outer-text-objects-map
;;               "f" (evil-textobj-tree-sitter-get-textobj "function.outer"))
;;   bind `function.inner`(function block without name and args) to `f` for use in things
;;   like `vif`, `yif`
;;   (define-key evil-inner-text-objects-map
;;               "f" (evil-textobj-tree-sitter-get-textobj "function.inner"))

;;   You can also bind multiple items and we will match the first one we can find
;;   (define-key evil-outer-text-objects-map
;;               "a" (evil-textobj-tree-sitter-get-textobj ("conditional.outer" "loop.outer")))
;;   (define-key evil-inner-text-objects-map
;;               "c" (evil-textobj-tree-sitter-get-textobj ("conditional.inner" "loop.inner")))
;;   )


(provide 'init-evil)

;;; init-evil.el ends here
