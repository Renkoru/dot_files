;;; init-javascript.el --- javascript

;;; Commentary:

;; Investigate this package and fork and update it to use ripgrep and ivy/counsel to select cantidates
;; https://github.com/nicolaspetton/xref-js2

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
  :mode ("\\.js\\'" . js2-mode)
  :config
  (setq js-switch-indent-offset 4)
  (add-hook 'js2-mode-hook 'js2-imenu-extras-mode) ;; Better imenu
  (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  )

;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(defun js-jsx-indent-line-align-closing-bracket ()
  "Workaround sgml-mode and align closing bracket with opening bracket"
  (save-excursion
    (beginning-of-line)
    (when (looking-at-p "^ +\/?> *$")
      (delete-char sgml-basic-offset))))

(use-package rjsx-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx$" . rjsx-mode))
  (add-to-list 'auto-mode-alist '("\\.react\\.js$" . rjsx-mode))
  (advice-add #'js-jsx-indent-line :after #'js-jsx-indent-line-align-closing-bracket)
  )


;; Not usable for now, investigate package, maybe found some usefull things
(use-package js2-refactor
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode))

;; (add-hook 'js-mode-hook 'js2-minor-mode)

(defun js-custom ()
  "JavaScript-mode-hook."
  (setq js-indent-level 4)
  (setq tab-width 4)

  )

(setq-default js2-global-externs '("describe" "expect" "it" "jest" ))

(add-hook 'js-mode-hook 'js-custom)


(setq js2-highlight-level 3)

;; jshint does not warn about this now for some reason
;; (setq-default js2-strict-trailing-comma-warning nil)
;; '(js2-strict-trailing-comma-warning nil)
(setq js2-strict-trailing-comma-warning nil)

(provide 'init-javascript)
;;; init-javascript.el ends here
