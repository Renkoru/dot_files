;;; package --- init-flycheck.el

;;; Commentary:
;; You need to install:
;;   eslint 'npm install -g eslint'

;;; Code:

(use-package flycheck
  :diminish flycheck-mode
  :config
  (global-flycheck-mode)

  (setq-default flycheck-disabled-checkers
                ;; disable jshint since we prefer eslint checking
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))

  (setq-default flycheck-disabled-checkers
                ;; disable jscs since we prefer eslint checking
                (append flycheck-disabled-checkers
                        '(javascript-jscs)))

  ;; (setq flycheck-checkers '(javascript-eslint))
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist))))

;; (add-hook 'js-mode-hook
;;           (lambda () (flycheck-mode t)))

;; next eslint hook I copy from
;; http://www.cyrusinnovation.com/initial-emacs-setup-for-reactreactnative/
(add-hook 'projectile-after-switch-project-hook 'mjs/setup-local-eslint)

(defun mjs/setup-local-eslint ()
    "If ESLint found in node_modules directory - use that for flycheck.
Intended for use in PROJECTILE-AFTER-SWITCH-PROJECT-HOOK."
    (interactive)
    (let ((local-eslint (expand-file-name "./node_modules/.bin/eslint")))
      (setq flycheck-javascript-eslint-executable
            (and (file-exists-p local-eslint) local-eslint))))

(flycheck-define-checker my-php
  "A PHP syntax checker using the PHP command line interpreter.

See URL `http://php.net/manual/en/features.commandline.php'."
  :command ("php" "-l" "-d" "error_reporting=E_ALL" "-d" "display_errors=1"
            "-d" "log_errors=0" source)
  :error-patterns
  ((error line-start (or "Parse" "Fatal" "syntax") " error" (any ":" ",") " "
          (message) " in " (file-name) " on line " line line-end))
  :modes (php-mode php+-mode web-mode))


(provide 'init-flycheck)
;;; init-flycheck ends here
