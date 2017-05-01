;;; package --- init-counsel.el
;;; Commentary:
;;; Code:

(require 'all-the-icons-ivy) ;; https://github.com/asok/all-the-icons-ivy

(use-package counsel
  :init
  (setq ivy-switch-buffer-faces-alist
        '((emacs-lisp-mode . swiper-match-face-1)
          (dired-mode . ivy-subdir)
          (org-mode . org-level-4)
          (rjsx-mode . rjsx-tag)))
  (setq counsel-yank-pop-separator (concat "\n" (make-string 70 ?-) "\n"))
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
        ;; allow input not in order
        '((t   . ivy--regex-ignore-order)))

  :config
  (ivy-mode 1)
  (all-the-icons-ivy-setup)

  (evil-leader/set-key
    "y" 'counsel-yank-pop
    )

  (use-package counsel-projectile
    :config
    (counsel-projectile-on)

    (evil-leader/set-key
      "f" 'counsel-projectile-find-file
      "a" 'counsel-projectile-rg
      )
    )


  :bind (
         ("C-q" . ivy-switch-buffer)
         ("M-x" . counsel-M-x)
         ("M-f" . counsel-find-file)
         ("C-c C-r" . ivy-resume)

         :map evil-normal-state-map
         ("gl" . swiper)
         ("go" . counsel-imenu)
         )
  )


(provide 'init-counsel)
;;; init-counsel.el ends here
