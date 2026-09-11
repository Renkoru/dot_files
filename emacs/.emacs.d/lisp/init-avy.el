;;; init-avy.el --- avy settings
;;; Commentary:
;;; Code:


(use-package avy
  ;; [meow-migration] Leader bindings moved to init-meow.el
  ;; Original :bind (:map evil-normal-state-map ...) commented out:
  :config
  ;; Bind key for isearch C-' to activate avy
  (setq avy-style 'at-full)
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

  (defun my-avy-action-copy-and-yank (pt)
    "Copy sexp starting on PT."
    (save-excursion
      (let (str)
        (goto-char pt)
        ;; [meow-migration] evil-forward-word-begin → forward-word
        (forward-word 1)
        ;; (evil-forward-word-begin) -- original
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

  (avy-setup-default))

(provide 'init-avy)
;;; init-avy.el ends here
