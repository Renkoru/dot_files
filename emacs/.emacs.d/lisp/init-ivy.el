;;; package --- init-counsel.el
;;; Commentary:
;;; Code:

;;; Notes:
;;  C-u [COMMAND](Ex.: M-x counsel-rg / keybinding) RET [rg args](Ex.: -t org) RET [search keyword](Ex.: tes)

;; not working good for current docker-mode setup. Remove it?
;; (require 'all-the-icons-ivy) ;; https://github.com/asok/all-the-icons-ivy

(use-package ivy
  :bind (:map meow-normal-state-keymap
              ("g l" . counsel-grep-or-swiper)
              ("g o" . counsel-imenu)
         ("C-q" . ivy-switch-buffer)
         ("M-x" . counsel-M-x)
         ("M-f" . counsel-find-file)
         ("C-c C-i" . ivy-resume)
         ("C-c p p" . counsel-projectile-switch-project))
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
        "rg -i -M 120 --no-heading --line-number --color never '%s' %s")
  (define-key my-meow-leader-map (kbd "y") 'counsel-yank-pop))

(use-package ivy-hydra)

(use-package counsel-projectile
  :config
  (counsel-projectile-mode)
  (define-key my-meow-leader-map (kbd "f") 'counsel-projectile-find-file)
  (define-key my-meow-leader-map (kbd "a") 'counsel-projectile-rg))

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
  (ivy-posframe-mode 1)
  )

(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :init
  (setq ivy-rich-display-transformers-list
        '(ivy-switch-buffer
          (:columns
           ((ivy-rich-candidate (:width 60))
            (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
            (ivy-rich-switch-buffer-path
             (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3)))))
            )
           :predicate
           (lambda (cand) (get-buffer cand)))

          counsel-find-file
          (:columns
           ((ivy-read-file-transformer)
            (ivy-rich-counsel-find-file-truename (:face font-lock-doc-face))))

          counsel-M-x
          (:columns
           ((counsel-M-x-transformer (:width 40))
            (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))
          ))
  :config
  (ivy-rich-mode 1))

(use-package all-the-icons-ivy
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))


(provide 'init-ivy)
;;; init-counsel.el ends here
