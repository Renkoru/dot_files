;;; package --- init-elm.el
;;; Commentary:
;; install "elm-oracle" for company autocomplete https://github.com/ElmCast/elm-oracle
;;; Code:



(straight-use-package 'elm-mode)

(with-eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-elm))

(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)


(straight-use-package 'flycheck-elm)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))

(provide 'init-elm)
;;; init-elm.el ends here
