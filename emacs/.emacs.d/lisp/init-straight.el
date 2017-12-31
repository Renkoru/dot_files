;;; init-straight.el --- straight settings
;;; Commentary:
;;; Code:

;; >>> straight.el configuration from straight docs
(let ((bootstrap-file (concat user-emacs-directory "straight/bootstrap.el"))
      (bootstrap-version 2))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;; <<<

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; (straight-use-package 'smex) ;; ranking and remembering M-x
;; (straight-use-package 'markdown-mode)
;; (straight-use-package 'scss-mode)
;; (straight-use-package 'yaml-mode)
;; (straight-use-package 'rainbow-mode)
;; (straight-use-package 'python-mode)
;; (straight-use-package 'tide)
;; (straight-use-package 'js-doc)
;; (straight-use-package 'htmlize)
;; (straight-use-package 'idle-highlight-mode)

;; (straight-use-package 'pallet)
;; (straight-use-package 'popwin)
;; (straight-use-package 'prodigy)

(provide 'init-straight)
;;; init-straight.el ends here
