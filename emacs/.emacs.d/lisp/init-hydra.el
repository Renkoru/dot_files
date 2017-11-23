;;; init-hydra.el --- hydra settings
;;; Commentary:
;;; Code:


(use-package hydra
  :config

  (defhydra hydra-zoom ()
    "zoom"
    ("i" text-scale-increase "increase")
    ("d" text-scale-decrease "decrease"))

  (defhydra hydra-mc (:color pink
                      :pre (evil-mc-pause-cursors)
                      :post (evil-mc-resume-cursors))
    "multiple cursors"
    ("H" highlight-symbol-at-point "highlight")
    ("c" evil-mc-make-cursor-here "create cursor")
    ("s" evil-mc-skip-and-goto-next-match "skip and next")
    ("S" evil-mc-skip-and-goto-prev-match "skip and prev")
    ("n" evil-mc-make-and-goto-next-match "make and next")
    ("p" evil-mc-make-and-goto-prev-match "make and prev")
    ("q" nil "quit"))

  (defvar whitespace-mode t)
  (defhydra hydra-toggle (:color pink :idle 0.8)
    "
    _l_ linum-mode:       %`linum-mode
    _w_ whitespace-mode:   %`whitespace-mode
    _s_ flyspell-mode:   %`flyspell-mode
    "
    ("l" linum-mode nil)
    ("w" whitespace-mode nil)
    ("s" hydra-flyspell/body :exit t)
    ("q" nil "quit"))

  (defhydra hydra-flyspell (:color pink)
    "flyspell"
    ("t" flyspell-mode "toggle")
    ("f" flyspell-correct-word-generic "fix")
    ("q" nil "quit"))

  (defhydra hydra-git-toggle (:color pink)
    "
    _g_ git-gutter:       %`git-gutter-mode
    "
    ("g" git-gutter-mode nil)
    ("q" nil "quit"))

  (defhydra hydra-org (:color pink)
    "
    _L_ right _H_ left
    _K_ up _J_ down
    _c_ shift right _C_ shift left
    _t_ set tag
    "
    ("H" org-metaleft)
    ("L" org-metaright)
    ("K" org-metaup)
    ("J" org-metadown)
    ("c" org-shiftright)
    ("C" org-shiftleft)
    ("t" org-set-tags-command :exit t)
    ("q" nil "quit"))

  (evil-leader/set-key "cf" 'hydra-zoom/body)
  (evil-leader/set-key "cc" 'hydra-mc/body)
  (evil-leader/set-key "t" 'hydra-toggle/body)
  (evil-leader/set-key "g" 'hydra-git-toggle/body)
  (evil-leader/set-key "o" 'hydra-org/body)
)

(provide 'init-hydra)
;;; init-hydra.el ends here
