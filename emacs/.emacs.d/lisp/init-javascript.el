;; init-javascript -----------------------------------------------------------------

; You need to install jshint 'npm install -g jshint'
(require 'flycheck)
(add-hook 'js-mode-hook
          (lambda () (flycheck-mode t)))

(add-hook 'js-mode-hook 'js2-minor-mode)

(defun js-custom ()
  "js-mode-hook"
  (setq js-indent-level 2))

(require 'jquery-doc)
(add-hook 'js2-mode-hook 'jquery-doc-setup)

(add-hook 'js-mode-hook 'js-custom)

;; Add this to your .emacs to initialize tern and tern-auto-complete
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(setq js2-highlight-level 3)

(setq tab-width 2 ; set tab-width
      js-indent-level 2) ; indentation level in JS mode

;; jshint does not warn about this now for some reason
;; (setq-default js2-strict-trailing-comma-warning nil)
;; '(js2-strict-trailing-comma-warning nil)
(setq js2-strict-trailing-comma-warning nil)

(provide 'init-javascript)
