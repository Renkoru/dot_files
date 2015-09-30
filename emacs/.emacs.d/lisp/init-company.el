(add-hook 'after-init-hook 'global-company-mode)

;; Company-mode settings
(eval-after-load "company"
  '(progn
     (add-to-list 'company-backends 'company-capf)
     (add-to-list 'company-backends 'company-anaconda)
     (add-to-list 'company-backends 'company-tern)
     (add-to-list 'company-backends 'company-web-html)
     ))

(provide 'init-company)
