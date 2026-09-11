;;; init-neotree.el --- neotree settings
;;; Commentary:
;;; Code:


(defun my-scroll-to-word (&optional arg)
  "Testing for neotree feature ARG."
  (interactive "P")
  (let ((char (following-char)))
    ;; (message "char=%s" char)
    ;; (evil-forward-word-begin)
    ;; [meow-migration] evil-next-line-1-first-non-blank → next-line + back-to-indentation
    (next-line 1)
    (back-to-indentation)
    ;; (evil-next-line-1-first-non-blank)  -- original
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
  ;; [meow-migration] evil-next-line → next-line
  (next-line)
  ;; (evil-next-line)  -- original
  (my-scroll-to-word))

(defun my-neotree-previous-line (&optional arg)
  (interactive "P")
  ;; [meow-migration] evil-previous-line → previous-line
  (previous-line)
  ;; (evil-previous-line)  -- original
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
  (setq neo-theme 'icons)
  (setq neo-smart-open nil)
  ;; [meow-migration] evil-normal-state-local-map → neotree-mode-map
  (add-hook 'neotree-mode-hook
            (lambda ()
              ;; Original evil bindings (commented out):
              ;; (define-key evil-normal-state-local-map (kbd "j") ...)
              (define-key neotree-mode-map (kbd "j") 'my-neotree-next-line)
              (define-key neotree-mode-map (kbd "k") 'my-neotree-previous-line)
              (define-key neotree-mode-map (kbd "o") 'my-neotree-enter)
              (define-key neotree-mode-map (kbd "O") 'neotree-change-root)
              (define-key neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
              (define-key neotree-mode-map (kbd "SPC") 'neotree-enter)
              (define-key neotree-mode-map (kbd "q") 'neotree-hide)
              (define-key neotree-mode-map (kbd "RET") 'neotree-enter)
              (define-key neotree-mode-map (kbd "s") 'neotree-enter-horizontal-split)
              (define-key neotree-mode-map (kbd "S") 'neotree-enter-vertical-split)))

  ;; :bind (("<f3>" . neotree-toggle))
  )


(provide 'init-neotree)
;;; init-neotree.el ends here
