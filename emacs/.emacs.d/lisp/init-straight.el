;;; init-straight.el --- straight settings
;;; Commentary:
;;; Code:

;; >>> straight.el configuration from straight docs
(setq
 package-archives '(("melpa" . "https://melpa.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("gnu" . "https://elpa.gnu.org/packages/"))
 )

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

;; (straight-use-package 'scss-mode)
;; (straight-use-package 'htmlize)
;; (straight-use-package 'idle-highlight-mode)

(provide 'init-straight)
;;; init-straight.el ends here
