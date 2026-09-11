;;; init-my-hydra.el --- hydra settings
;;; Commentary:
;;; Code:


(use-package hydra
  ;; [meow-migration] Leader bindings moved to init-meow.el
  ;; Original :bind (:map evil-normal-state-map ...) commented out:
  :config
  (require 'display-line-numbers)
  ;; (require 'whitespace)
  ;; (require 'flyspell)
  ;; (require 'rainbow-delimiters)

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
    _m_ meow-mlang-mode:       %`meow-mlang-mode
    _w_ whitespace-mode:   %`whitespace-mode
    _r_ rainbow-delimiters-mode:   %`rainbow-delimiters-mode
    _s_ flyspell-mode:   %`flyspell-mode
    "
    ("l" display-line-numbers-mode nil)
    ("m" meow-mlang-mode nil)
    ("w" whitespace-mode nil)
    ("r" rainbow-delimiters-mode nil)
    ("s" hydra-flyspell/body :exit t)
    ("q" nil "quit"))

  (defhydra hydra-flyspell (:color pink)
    "flyspell"
    ("t" flyspell-mode "toggle")
    ("f" flyspell-correct-word-generic "fix")
    ("q" nil "quit"))

  (defhydra hydra-zoom ()
    "zoom"
    ("i" text-scale-increase "increase")
    ("r" set-default-font-height "reset")
    ("d" text-scale-decrease "decrease"))


  (with-eval-after-load 'meow
    ;; Toggles
    (define-key my-meow-leader-map (kbd "p t") 'hydra-toggle/body)
    (define-key my-meow-leader-map (kbd "p r") 'hydra-resize/body)
    ;; [disabled] hydra-numbers and hydra-fold are not yet defined
    ;; (define-key my-meow-leader-map (kbd "p c n") 'hydra-numbers/body)
    ;; (define-key my-meow-leader-map (kbd "p c z") 'hydra-fold/body)
    (define-key my-meow-leader-map (kbd "p c f") 'hydra-zoom/body)
    )
  )


(provide 'init-my-hydra)
;;; init-hydra.el ends here
