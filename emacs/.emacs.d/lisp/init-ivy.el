;;; package --- init-counsel.el
;;; Commentary:
;;; Code:

;;; Notes:
;;  C-u [COMMAND](Ex.: M-x counsel-rg / keybinding) RET [rg args](Ex.: -t org) RET [search keyword](Ex.: tes)

;; not working good for current docker-mode setup
;; (require 'all-the-icons-ivy) ;; https://github.com/asok/all-the-icons-ivy

(use-package ivy
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
  ;; (all-the-icons-ivy-setup)
  (setq counsel-grep-base-command
        "rg -i -M 120 --no-heading --line-number --color never '%s' %s")

  (general-define-key :prefix my-leader "y" 'counsel-yank-pop)

  :general
  ("C-q" 'ivy-switch-buffer)
  ("M-x" 'counsel-M-x)
  ("M-f" 'counsel-find-file)
  ("C-c C-i" 'ivy-resume)
  ("gl" 'counsel-grep-or-swiper)
  ("go" 'counsel-imenu))

(use-package ivy-hydra)

(use-package counsel-projectile
  :config
  (counsel-projectile-mode)

  (general-define-key :prefix my-leader
                      "f" 'counsel-projectile-find-file
                      "a" 'counsel-projectile-rg))


(provide 'init-ivy)
;;; init-counsel.el ends here
