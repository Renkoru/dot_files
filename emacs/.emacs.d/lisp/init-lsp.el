;;; init-lsp.el --- lsp settings
;;; Commentary:
;;; Code:
(use-package lsp-mode
  :commands lsp
  :init
  (setq lsp-highlight-symbol-at-point nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-enable-eldoc nil)
  (setq lsp-prefer-flymake nil) ;; Prefer using lsp-ui (flycheck) over flymake.
  (setq lsp-ui-sideline-diagnostics-max-lines 10)

  :config
  (add-hook 'python-mode-hook 'lsp)
  (add-hook 'js-mode-hook 'lsp)
  (add-hook 'typescript-mode-hook 'lsp)
  (my-space-leader "cr" 'lsp-rename))

(use-package lsp-ui
  :requires lsp-mode flycheck
  :after lsp-mode
  :commands lsp-ui-mode
  :init
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'top
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-enable nil
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'right
        lsp-ui-flycheck-live-reporting t
        lsp-ui-peek-enable t
        lsp-ui-peek-list-width 60
        lsp-ui-peek-peek-height 25)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-treemacs
  :requires lsp-mode)

;; (use-package company
;;   :config
;;   (setq lsp-completion-provider :capf)
;;   (setq company-idle-delay 0.3)

;;   (global-company-mode 1)

;;   (global-set-key (kbd "C-<tab>") 'company-complete))

;; (use-package lsp-mode
;;   :config
;;   ;; make sure we have lsp-imenu everywhere we have LSP
;;   (require 'lsp-imenu)
;;   (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
;;   ;; get lsp-python-enable defined
;;   ;; NB: use either projectile-project-root or ffip-get-project-root-directory
;;   ;;     or any other function that can be used to find the root directory of a project

;;   ;; NB: only required if you prefer flake8 instead of the default
;;   ;; send pyls config via lsp-after-initialize-hook -- harmless for
;;   ;; other servers due to pyls key, but would prefer only sending this
;;   ;; when pyls gets initialised (:initialize function in
;;   ;; lsp-define-stdio-client is invoked too early (before server
;;   ;; start)) -- cpbotha
;;   (defun lsp-set-cfg ()
;;     (let ((lsp-cfg `(:pyls (:configurationSources ("flake8")))))
;;       ;; TODO: check lsp--cur-workspace here to decide per server / project
;;       (lsp--set-configuration lsp-cfg)))

;;   (add-hook 'lsp-after-initialize-hook 'lsp-set-cfg))

;; lsp extras


;; (defhydra hydra-code (:color pink :idle 0.8)
;;   "
;;     _r_ lsp-rename:       %`lsp-rename
;;     _l_ turbo-log-print-immediately:       %`turbo-log-print-immediately
;;     "
;;   ("r" lsp-rename nil)
;;   ("l" turbo-log-print-immediately nil)
;;   ("q" nil "quit"))

(provide 'init-lsp)
;;; init-lsp.el ends here
