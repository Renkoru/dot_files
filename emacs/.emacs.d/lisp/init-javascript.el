;;; init-javascript.el --- javascript
;;; Commentary:
;;; Code:


;; JS packages
;; use-package nodejs-repl ?

(use-package tern
  :mode ("\\.js\\'" . js-mode)
  :interpreter ("javascript" . js-mode))

(use-package company-tern
  :ensure tern
  :mode ("\\.js\\'" . js-mode)
  :interpreter ("javascript" . js-mode)
  :config
  ;; Add this to your .emacs to initialize tern and tern-auto-complete
  (add-hook 'js-mode-hook (lambda () (tern-mode t))))


(use-package js2-mode
  :mode "\\.js\\'")

(use-package js2-refactor
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode))

;; (add-hook 'js-mode-hook 'js2-minor-mode)

(defun js-custom ()
  "JavaScript-mode-hook."
  (setq js-indent-level 2)
  (setq tab-width 2)
  )

(add-hook 'js-mode-hook 'js-custom)

(setq js2-highlight-level 3)

;; jshint does not warn about this now for some reason
;; (setq-default js2-strict-trailing-comma-warning nil)
;; '(js2-strict-trailing-comma-warning nil)
(setq js2-strict-trailing-comma-warning nil)

(provide 'init-javascript)
;;; init-javascript.el ends here
