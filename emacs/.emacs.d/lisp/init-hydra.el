;;; init-hydra.el --- hydra settings
;;; Commentary:
;;; Code:


(use-package hydra
  :config
  (defhydra hydra-resize ()
    "resize"
    ("s" shrink-window "V shrink")
    ("e" enlarge-window "V enlarge")
    ("S" shrink-window-horizontally "H shrink")
    ("E" enlarge-window-horizontally "H enlarge")
    ("q" nil "quit"))

  (defvar whitespace-mode t)
  (defhydra hydra-toggle (:color blue :idle 0.8)
    "
    _l_ display-line-numbers-mode:       %`display-line-numbers-mode
    _m_ evil-mlang-mode:       %`evil-mlang-mode
    _w_ whitespace-mode:   %`whitespace-mode
    _r_ rainbow-delimiters-mode:   %`rainbow-delimiters-mode
    _s_ flyspell-mode:   %`flyspell-mode
    "
    ("l" display-line-numbers-mode nil)
    ("m" evil-mlang-mode nil)
    ("w" whitespace-mode nil)
    ("r" rainbow-delimiters-mode nil)
    ("s" hydra-flyspell/body :exit t)
    ("q" nil "quit"))

  (defhydra hydra-flyspell (:color pink)
    "flyspell"
    ("t" flyspell-mode "toggle")
    ("f" flyspell-correct-word-generic "fix")
    ("q" nil "quit"))

  (my-space-leader
    "t" 'hydra-toggle/body
    "r" 'hydra-resize/body)
  )

(elpaca-wait)

(provide 'init-hydra)
;;; init-hydra.el ends here
