;;; init-avy.el --- avy settings
;;; Commentary:
;;; Code:


(use-package avy
  :config
  ;; Bind key for isearch C-' to activate avy
  (setq avy-style 'at-full)
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

  (defun my-avy-action-copy-and-yank (pt)
    "Copy sexp starting on PT."
    (save-excursion
      (let (str)
        (goto-char pt)
        (evil-forward-word-begin)
        (setq str (buffer-substring pt (point)))
        (kill-new str)
        (message "Copied: %s" str)))
    (let ((dat (ring-ref avy-ring 0)))
      (select-frame-set-input-focus
       (window-frame (cdr dat)))
      (select-window (cdr dat))
      (goto-char (car dat))))

  (setq avy-dispatch-alist '((?c . avy-action-copy)
                             (?w . my-avy-action-copy-and-yank)))

  (avy-setup-default)

  (general-define-key :prefix my-leader
   "j" 'avy-goto-line-below
   "k" 'avy-goto-line-above
   "l" 'avy-goto-char-in-line
   "s" 'avy-goto-char-timer))

(provide 'init-avy)
;;; init-avy.el ends here
