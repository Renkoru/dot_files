;;; init-hydra.el --- hydra settings
;;; Commentary:
;;; Code:


(use-package hydra
  :config

  (defhydra hydra-zoom ()
    "zoom"
    ("i" text-scale-increase "increase")
    ("d" text-scale-decrease "decrease"))

  (defhydra hydra-mc (:pre (evil-mc-pause-cursors)
                      :post (evil-mc-resume-cursors))
    "multiple cursors"
    ("l" forward-char)
    ("h" backward-char)
    ("j" next-line)
    ("k" previous-line)
    ("c" evil-mc-make-cursor-here "create cursor")
    ("q" nil "quit"))

  (evil-leader/set-key "cf" 'hydra-zoom/body)
  (evil-leader/set-key "mc" 'hydra-mc/body)
)

(provide 'init-hydra)
;;; init-hydra.el ends here
