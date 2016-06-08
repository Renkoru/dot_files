(use-package company
  :ensure t
  :diminish company-mode
  :config
  (global-company-mode)
  (progn
    (add-to-list 'company-backends 'company-files)
    (add-to-list 'company-backends 'company-keywords)
    (add-to-list 'company-backends 'company-capf)
    (add-to-list 'company-backends 'company-anaconda)
    (add-to-list 'company-backends 'company-tern)
    (add-to-list 'company-backends 'company-web-html)
    ;; (add-to-list 'company-backends 'php-extras-company)
    (setq company-show-numbers t))
  )

(use-package company-anaconda
  :ensure t)

(use-package company-tern
  :ensure t)


;; (add-hook 'after-init-hook 'global-company-mode)

(setq company-dabbrev-downcase nil)
(setq company-minimum-prefix-length 2)


;; Company-mode settings
;; (eval-after-load "company"
;;   ')



(provide 'init-company)
