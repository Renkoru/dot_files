;;; package --- init-counsel.el
;;; Commentary:
;;; Code:

;;; Notes:
;;  C-u [COMMAND](Ex.: M-x counsel-rg / keybinding) RET [rg args](Ex.: -t org) RET [search keyword](Ex.: tes)

;; not working good for current docker-mode setup
;; (require 'all-the-icons-ivy) ;; https://github.com/asok/all-the-icons-ivy

(use-package ivy
  :general
  (:states 'normal
           "gl" 'counsel-grep-or-swiper
           "go" 'counsel-imenu)
  (my-space-leader "y" 'counsel-yank-pop)
  (:keymaps 'global "C-q" 'ivy-switch-buffer)
  (:keymaps 'global "M-x" 'counsel-M-x)
  (:keymaps 'global "M-f" 'counsel-find-file)
  (:keymaps 'global "C-c C-i" 'ivy-resume)
  (:keymaps 'global "C-c p p" 'counsel-projectile-switch-project)

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
  (setq ivy-use-selectable-prompt t)

  :config
  (ivy-mode 1)
  ;; (all-the-icons-ivy-setup)
  (setq counsel-grep-base-command
        "rg -i -M 120 --no-heading --line-number --color never '%s' %s"))

(use-package ivy-hydra)

(use-package counsel-projectile
  :general
  (my-space-leader
    "f" 'counsel-projectile-find-file
    "a" 'counsel-projectile-rg)
  :config
  (counsel-projectile-mode))

(use-package ivy-posframe
  :config
  (setq ivy-posframe-parameters
        '((left-fringe . 5)
          (right-fringe . 5)
          ;; (foreground-color . "DarkSlateGrey")
          ;; (background-color . "LightSteelBlue1")
          ))
  (setq ivy-posframe-width 115)
  ;; (defun ivy-posframe-display-at-frame-bottom-left (str)
  ;;   (ivy-posframe--display str #'posframe-poshandler-frame-bottom-right-corner))

  (setq ivy-display-function #'ivy-posframe-display)
  ;; (setq ivy-display-function #'ivy-posframe-display-at-frame-center)
  ;; (setq ivy-display-function #'ivy-posframe-display-at-window-center)
  ;; (setq ivy-display-function #'ivy-posframe-display-at-frame-bottom-left)
  ;; (setq ivy-display-function #'ivy-posframe-display-at-window-bottom-left)
  ;; (setq ivy-display-function #'ivy-posframe-display-at-point)
  (ivy-posframe-enable))


(provide 'init-ivy)
;;; init-counsel.el ends here
