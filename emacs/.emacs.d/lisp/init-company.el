(use-package company
  :config
  (global-company-mode)
  (progn
    (add-to-list 'company-backends 'company-files)
    (add-to-list 'company-backends 'company-keywords)
    (add-to-list 'company-backends 'company-capf)
    ;; (add-to-list 'company-backends 'php-extras-company)
    (setq company-show-numbers t)

    (use-package company-web
      :init (add-to-list 'company-backends 'company-web-html))
    (use-package company-tern
      :init (add-to-list 'company-backends 'company-tern))
    (use-package company-anaconda
      :init (add-to-list 'company-backends 'company-anaconda))
    (use-package company-quickhelp
      :init (company-quickhelp-mode 1))
    (use-package company-statistics
      :init (company-statistics-mode 1))
    )
  )

;; (add-hook 'after-init-hook 'global-company-mode)

(setq company-dabbrev-downcase nil)
(setq company-minimum-prefix-length 2)


;; Company-mode settings
;; (eval-after-load "company"
;;   ')



(provide 'init-company)
