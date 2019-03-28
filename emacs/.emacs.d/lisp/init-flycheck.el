;;; package --- init-flycheck.el

;;; Commentary:
;; You need to install:
;;   eslint 'npm install -g eslint'

;;; Code:

(use-package flycheck
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
  (setq-default flycheck-checkers
                (append flycheck-checkers
                        '(jsx-tide)))


  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist))))


;; (add-hook 'js-mode-hook
;;           (lambda () (flycheck-mode t)))

;; next eslint hook I copy from
;; http://www.cyrusinnovation.com/initial-emacs-setup-for-reactreactnative/
;; (add-hook 'projectile-after-switch-project-hook 'mjs/setup-local-eslint)
;; (add-hook 'projectile-after-switch-project-hook 'lunaryorn-use-js-executables-from-node-modules)
;; (add-hook 'js-mode-hook 'lunaryorn-use-js-executables-from-node-modules)
;; Typescript integration doesn't work now
;; (add-hook 'typescript-mode-hook 'lunaryorn-use-js-executables-from-node-modules)

;; Do not know what it does, really
;; https://github.com/lunaryorn/.emacs.d/blob/master/lisp/lunaryorn-flycheck.el#L62
(defun lunaryorn-use-js-executables-from-node-modules ()
  "Set executables of JS checkers from local node modules."
  (-when-let* ((file-name (buffer-file-name))
               (root (locate-dominating-file file-name "node_modules"))
               (module-directory (expand-file-name "node_modules" root)))
    (pcase-dolist (`(,checker . ,module) '((javascript-eslint . "eslint")
                                           (javascript-jscs . "jscs")
                                           (prettier-js-command  . "prettier")
                                           ;; Typescript integration doesn't work now
                                           (typescript-tslint . "tslint")))
      (let ((package-directory (expand-file-name module module-directory))
            (executable-var (flycheck-checker-executable-variable checker)))
        (when (file-directory-p package-directory)
          (set (make-local-variable executable-var)
               (expand-file-name (concat "bin/" module ".js")
                                 package-directory)))))))

;; Copyed from:
;; https://gist.github.com/ustun/73321bfcb01a8657e5b8
(defun eslint-fix-file ()
  (interactive)
  (message "eslint --fixing the file" (buffer-file-name))
  (shell-command (concat flycheck-javascript-eslint-executable " --fix " (buffer-file-name)))
  (revert-buffer t t))


(provide 'init-flycheck)
;;; init-flycheck ends here
