;;; init-neotree.el --- neotree settings
;;; Commentary:
;;; Code:


(defun my-scroll-to-word (&optional arg)
  "Testing for neotree feature ARG."
  (interactive "P")
  (let ((char (following-char)))
    ;; (message "char=%s" char)
    ;; (evil-forward-word-begin)
    (evil-next-line-1-first-non-blank)
    (let* ((column (current-column))
           (hscroll (window-hscroll))
           (offset (- column hscroll 1)))
      ;; (message "current-column=%d window-hscroll=%d offset=%d char=%s"
      ;;          column hscroll offset char)
      (scroll-left offset)
      )
    ))

(defun my-neotree-next-line (&optional arg)
  (interactive "P")
  (evil-next-line)
  (my-scroll-to-word))

(defun my-neotree-previous-line (&optional arg)
  (interactive "P")
  (evil-previous-line)
  (my-scroll-to-word))

(defun my-neotree-enter (&optional arg)
  (interactive "P")
  (neotree-enter)
  (my-scroll-to-word))

(use-package neotree
  :config
  ;; (setq neo-theme 'nerd)
  (setq neo-window-fixed-size nil)
  (setq neo-theme 'icons)
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "j") 'my-neotree-next-line)
              (define-key evil-normal-state-local-map (kbd "k") 'my-neotree-previous-line)
              (define-key evil-normal-state-local-map (kbd "o") 'my-neotree-enter)
              (define-key evil-normal-state-local-map (kbd "O") 'neotree-change-root)
              (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)
              (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-horizontal-split)
              (define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-vertical-split)))

  :bind (("<f3>" . neotree-toggle))
  )


(provide 'init-neotree)
;;; init-neotree.el ends here
