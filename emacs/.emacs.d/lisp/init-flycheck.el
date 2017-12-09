;;; package --- init-flycheck.el

;;; Commentary:
;; You need to install:
;;   eslint 'npm install -g eslint'

;;; Code:

(use-package flycheck
  :config
  (progn
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
    (setq-default flycheck-checkers
                  (append flycheck-checkers
                          '(jsx-tide)
                          )
                  )
    (setq-default flycheck-disabled-checkers
                  (append flycheck-disabled-checkers
                          '(json-jsonlist)))
    ))


;; (add-hook 'js-mode-hook
;;           (lambda () (flycheck-mode t)))

;; next eslint hook I copy from
;; http://www.cyrusinnovation.com/initial-emacs-setup-for-reactreactnative/
;; (add-hook 'projectile-after-switch-project-hook 'mjs/setup-local-eslint)
;; (add-hook 'projectile-after-switch-project-hook 'lunaryorn-use-js-executables-from-node-modules)
(add-hook 'js-mode-hook 'lunaryorn-use-js-executables-from-node-modules)

(defun mjs/setup-local-eslint ()
    "If ESLint found in node_modules directory - use that for flycheck.
Intended for use in PROJECTILE-AFTER-SWITCH-PROJECT-HOOK."
    (interactive)
    (let ((local-eslint (expand-file-name "./node_modules/.bin/eslint")))
      (setq flycheck-javascript-eslint-executable
            (and (file-exists-p local-eslint) local-eslint))))

;; Do not know what it does, really
;; https://github.com/lunaryorn/.emacs.d/blob/master/lisp/lunaryorn-flycheck.el#L62
(defun lunaryorn-use-js-executables-from-node-modules ()
  "Set executables of JS checkers from local node modules."
  (-when-let* ((file-name (buffer-file-name))
               (root (locate-dominating-file file-name "node_modules"))
               (module-directory (expand-file-name "node_modules" root)))
    (pcase-dolist (`(,checker . ,module) '((javascript-eslint . "eslint")
                                           (javascript-jscs   . "jscs")))
      (let ((package-directory (expand-file-name module module-directory))
            (executable-var (flycheck-checker-executable-variable checker)))
        (when (file-directory-p package-directory)
          (set (make-local-variable executable-var)
               (expand-file-name (concat "bin/" module ".js")
                                 package-directory)))))))


(flycheck-define-checker my-php
  "A PHP syntax checker using the PHP command line interpreter.

See URL `http://php.net/manual/en/features.commandline.php'."
  :command ("php" "-l" "-d" "error_reporting=E_ALL" "-d" "display_errors=1"
            "-d" "log_errors=0" source)
  :error-patterns
  ((error line-start (or "Parse" "Fatal" "syntax") " error" (any ":" ",") " "
          (message) " in " (file-name) " on line " line line-end))
  :modes (php-mode php+-mode web-mode))

;; Copyed from:
;; https://gist.github.com/ustun/73321bfcb01a8657e5b8
(defun eslint-fix-file ()
  (interactive)
  (message "eslint --fixing the file" (buffer-file-name))
  (shell-command (concat "eslint --fix " (buffer-file-name)))
  (revert-buffer t t))


(provide 'init-flycheck)
;;; init-flycheck ends here
