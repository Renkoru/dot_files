;; init-flycheck.el
;;
;; You need to install eslint 'npm install -g eslint'

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
