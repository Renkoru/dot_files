;;; init-neotree.el --- neotree settings
;;; Commentary:
;;; Code:

(use-package neotree
  :config
  ;; (setq neo-theme 'nerd)
  (setq neo-theme 'icons)
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)
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
