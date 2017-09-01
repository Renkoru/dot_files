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

  (evil-leader/set-key "cf" 'hydra-zoom/body)
  (evil-leader/set-key "mc" 'hydra-mc/body)
  (evil-leader/set-key "t" 'hydra-toggle/body)
)

(provide 'init-hydra)
;;; init-hydra.el ends here
