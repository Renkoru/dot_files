;;; init-straight.el --- straight settings
;;; Commentary:
;;; Code:

;; >>> straight.el configuration from straight docs

(setq straight-use-package-by-default t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; (straight-use-package 'scss-mode)
;; (straight-use-package 'htmlize)
;; (straight-use-package 'idle-highlight-mode)

(provide 'init-straight)
;;; init-straight.el ends here
