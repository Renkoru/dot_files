;;; init-avy.el --- avy settings
;;; Commentary:
;;; Code:

;; How to use avy-dispatch-alist with evil yank word or Word ?

(use-package avy
  :config
  ;; Bind key for isearch C-' to activate avy
  (setq avy-style 'at-full)
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq avy-dispatch-alist '((?c . avy-action-copy)))

  (avy-setup-default)

  (evil-leader/set-key
    "j" 'avy-goto-line-below
    "k" 'avy-goto-line-above
    "l" 'avy-goto-char-in-line
    "s" 'avy-goto-char-timer
    )
  )


(provide 'init-avy)
;;; init-avy.el ends here
