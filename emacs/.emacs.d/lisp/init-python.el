;;; package --- init-python.el

;;; Commentary:
;; Contains all setting about python

;; !!!! Python virtualenv requirements for 'elpy' to work:
;; jedi
;; flake8
;; autopep8
;; yapf

;;; Code:
;; (use-package pipenv
;;   :hook (python-mode . pipenv-mode)
;;   :init
;;   (setq
;;    pipenv-projectile-after-switch-function
;;    #'pipenv-projectile-after-switch-extended))
(use-package pyvenv)

(lsp-define-stdio-client lsp-python "python"
                         #'projectile-project-root
                         '("pyls"))

;; (use-package elpy
;;   :init
;;   (elpy-enable)
;;   (setq elpy-rpc-backend "jedi")
;;   :general
;;   (:keymaps 'python-mode-map :states 'normal "gd" 'elpy-goto-definition)
;;   :config
;;   (setq elpy-modules (delete 'elpy-module-highlight-indentation elpy-modules))
;;   (setq elpy-modules (delete 'elpy-module-flymake elpy-modules)))

;; (use-package anaconda-mode)
(use-package sphinx-doc)
;; (use-package py-yapf)

(add-hook 'python-mode-hook
          (lambda ()
            'flycheck-mode
            (lsp-python-enable)
            (setq tab-width 4)
            (sphinx-doc-mode t)))

(provide 'init-python)

;;; init-python.el ends here
