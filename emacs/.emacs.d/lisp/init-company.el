;;; init-company.el --- Company mode configuration
;;; Commentary:
;;; Code:


(use-package company
  :general (:states '(insert) "M-/" 'company-complete-common)
  :config
  (global-company-mode)

  (setq company-frontends
        '(company-pseudo-tooltip-unless-just-one-frontend
          company-preview-if-just-one-frontend))

  (setq company-backends
        '(company-elisp
          ;; company-keywords
          company-capf
          (company-dabbrev-code company-gtags company-etags
                                company-keywords)
          company-files
          company-yasnippet
          company-dabbrev))

  ;; (add-to-list 'company-backends 'company-files)
  ;; (add-to-list 'company-backends 'company-keywords)
  ;; (add-to-list 'company-backends 'company-capf)
  ;; (add-to-list 'company-backends 'company-yasnippet)

  ;; (add-to-list 'company-backends 'php-extras-company)
  (setq company-show-numbers t)

  (setq company-dabbrev-downcase nil)
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 1.5)

  ;; source begin >>>: https://github.com/abo-abo/oremacs/blob/github/modes/ora-company.el#L22-L45
  (defun ora-company-number ()
    "Forward to `company-complete-number'.
Unless the number is potentially part of the candidate.
In that case, insert the number."
    (interactive)
    (let* ((k (this-command-keys))
           (re (concat "^" company-prefix k)))
      (if (cl-find-if (lambda (s) (string-match re s))
                      company-candidates)
          (self-insert-command 1)
        (company-complete-number
         (if (equal k "0")
             10
           (string-to-number k))))))

  (let ((map company-active-map))
    (mapc (lambda (x) (define-key map (format "%d" x) 'ora-company-number))
          (number-sequence 0 9))
    (define-key map " " (lambda ()
                          (interactive)
                          (company-abort)
                          (self-insert-command 1)))
    (define-key map (kbd "<return>") nil))
  ;; source end <<<: https://github.com/abo-abo/oremacs/blob/github/modes/ora-company.el#L22-L45

  (use-package company-web
    :init
    (add-to-list 'company-backends 'company-web-html))
  ;; (use-package company-tern
  ;;   :init (add-to-list 'company-backends '(company-tern :with company-capf)))
  ;; (use-package company-anaconda
  ;;   :init (add-to-list 'company-backends '(company-anaconda :with company-capf)))
  (use-package company-quickhelp
    :init (company-quickhelp-mode 1))
  (use-package company-statistics
    :init (company-statistics-mode 1))
  )

;; (add-hook 'after-init-hook 'global-company-mode)

;; Company-mode settings
;; (eval-after-load "company"
;;   ')


(provide 'init-company)
;;; init-company.el ends here
