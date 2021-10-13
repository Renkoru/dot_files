;;; package --- init-python.el

;;; Commentary:
;; Contains all setting about python

;; !!!! Python pipenv requirements for 'lsp-python' to work:
;; pipenv install 'python-language-server[all]'
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
(use-package pyvenv
  :config
  (setenv "WORKON_HOME" "/home/mrurenko/.cache/pypoetry/virtualenvs"))

;; (lsp-define-stdio-client lsp-python "python"
;;                          #'projectile-project-root
;;                          '("pyls"))

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
            #'lsp
            (setq tab-width 4)
            (setq flycheck-pylintrc ".pylintrc")
            (sphinx-doc-mode t)))

(use-package evil-python-movement
  :after evil
  :general
  (:states 'normal :keymaps 'python-mode-map
           "[[" 'evil-python-movement-lsb-lsb
           "]]" 'evil-python-movement-rsb-rsb
           "[m" 'evil-python-movement-lsb-m
           "]m" 'evil-python-movement-rsb-m
           "[M" 'evil-python-movement-lsb-M
           "]M" 'evil-python-movement-rsb-M
           "[]" 'evil-python-movement-lsb-rsb
           "][" 'evil-python-movement-lsb-rsb))


(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(provide 'init-python)

;;; init-python.el ends here
