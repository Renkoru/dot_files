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
  (defhydra hydra-toggle (:color pink :idle 0.8)
    "
    _l_ linum-mode:       %`linum-mode
    _m_ evil-mlang-mode:       %`evil-mlang-mode
    _w_ whitespace-mode:   %`whitespace-mode
    _r_ rainbow-delimiters-mode:   %`rainbow-delimiters-mode
    _s_ flyspell-mode:   %`flyspell-mode
    "
    ("l" linum-mode nil)
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


  (general-define-key :prefix my-leader
                      "t" 'hydra-toggle/body
                      "r" 'hydra-resize/body
                      "cf" 'hydra-zoom/body)
)

(provide 'init-hydra)
;;; init-hydra.el ends here
