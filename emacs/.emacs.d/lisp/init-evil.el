;;; init-evil.el --- Evil mode configuration
;;; Commentary:
;;; Code:


(use-package evil
  :demand
  :config
  (evil-mode 1)

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

  (general-define-key
   "C-h" 'evil-window-left
   "C-j" 'evil-window-down
   "C-k" 'evil-window-up
   "C-l" 'evil-window-right
   "C-e" 'end-of-line
   "C-a" 'beginning-of-line)

  (general-define-key :prefix my-leader
   "w" 'save-buffer
   "q" 'delete-window
   "=" 'balance-windows)

  (general-define-key :prefix "["
                      "SPC" 'insert-line-above)

  (general-define-key :prefix "]"
                      "SPC" 'insert-line-below)

  (setq evil-emacs-state-cursor '("#8b0000" box))
  (setq evil-normal-state-cursor '("ForestGreen" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-insert-state-cursor '("#8b0000" bar))
  (setq evil-replace-state-cursor '("#8b0000" bar))
  (setq evil-operator-state-cursor '("#8b0000" hollow))

  (use-package evil-surround
    :config (global-evil-surround-mode 1))

  (use-package evil-visualstar
    :config (global-evil-visualstar-mode t))

  (use-package evil-mc
    :config
    ;; Do not use global mode, do not know how to disable default bindings

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

    (general-define-key :prefix my-leader "cc" 'hydra-mc/body))

  (use-package evil-matchit
    :config (global-evil-matchit-mode 1))

  (use-package vimish-fold
    :general
    (evil-visual-state-map "zf" 'vimish-fold)
    ("zd" 'vimish-fold-delete)
    ("zD" 'vimish-fold-delete-all)
    ("za" 'vimish-fold-toggle)
    ("zA" 'vimish-fold-toggle-all)
    ("zo" 'vimish-fold-unfold)
    ("zO" 'vimish-fold-unfold-all)
    ("zc" 'vimish-fold-refold)
    ("zC" 'vimish-fold-refold-all))

  (use-package drag-stuff
    :init
    (drag-stuff-global-mode 1)
    :general
    ("M-k" 'drag-stuff-up)
    ("M-j" 'drag-stuff-down)
    ("M-l" 'drag-stuff-right)
    ("M-h" 'drag-stuff-left))


  (use-package evil-nerd-commenter
    :config
    (general-define-key "gcc" 'evilnc-comment-or-uncomment-lines))

  (use-package evil-anzu))

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

;; When i visual select some region last mark is resetting.
;; Emacs lost it and i can't jump back to it.  (C-i)
;; This hook add some sacrifice mark to reset it.
;; Temporary disabled be cause of bug: Visual Vim select at the end and at the start of buffer
;; (add-hook 'activate-mark-hook 'push-mark-no-activate)


(provide 'init-evil)

;;; init-evil.el ends here
