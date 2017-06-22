;;; init-hydra.el --- hydra settings
;;; Commentary:
;;; Code:


(use-package hydra
  :config

  (defhydra hydra-zoom ()
    "zoom"
    ("i" text-scale-increase "increase")
    ("d" text-scale-decrease "decrease"))

  (evil-leader/set-key "cf" 'hydra-zoom/body)
)

(provide 'init-hydra)
;;; init-hydra.el ends here
