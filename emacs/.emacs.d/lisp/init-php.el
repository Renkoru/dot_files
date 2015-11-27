;; init-php.el

(require 'init-flycheck)

(flycheck-define-checker my-php
  "A PHP syntax checker using the PHP command line interpreter.

See URL `http://php.net/manual/en/features.commandline.php'."
  :command ("php" "-l" "-d" "error_reporting=E_ALL" "-d" "display_errors=1"
            "-d" "log_errors=0" source)
  :error-patterns
  ((error line-start (or "Parse" "Fatal" "syntax") " error" (any ":" ",") " "
          (message) " in " (file-name) " on line " line line-end))
  :modes (php-mode php+-mode web-mode))



(add-hook 'php-mode-hook 'php-enable-drupal-coding-style)

(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))


(provide 'init-php)
