;;; package --- init-python.el

;;; Commentary:
;; Contains all setting about python
;; System requirements:
;; jedi

;;; Code:


(use-package pyenv-mode
  :init
  (pyenv-mode))

(use-package elpy
  :init
  (elpy-enable)
  (setenv "WORKON_HOME" "~/.pyenv/versions/")
  (setq elpy-rpc-backend "jedi")
  )


;; (use-package anaconda-mode)
(use-package sphinx-doc)
(use-package py-yapf)


(add-hook 'python-mode-hook
          (lambda ()
            (setq tab-width 4)
            (sphinx-doc-mode t)
            (define-key evil-normal-state-map (kbd "gd") 'elpy-goto-definition)
            ))

;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)

;; (pyenv-mode)
(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name.
Version must be already installed."
  (pyenv-mode-set (projectile-project-name)))

(add-hook 'projectile-switch-project-hook 'projectile-pyenv-mode-set)

(provide 'init-python)

;;; init-python.el ends here
