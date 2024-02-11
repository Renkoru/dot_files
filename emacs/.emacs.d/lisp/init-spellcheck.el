;;; init-spellcheck.el --- Flyspell settings
;;; Commentary:
;;
;; Required system package:
;; * aspell, aspell-en
;;
;;; Code:

(use-package jinx
  :after vertico
  :hook (emacs-startup . global-jinx-mode)
  :custom
  (jinx-languages "en_US ru")
  (jinx-camel-modes '(prog-mode org-mode))
  :config
  (add-to-list 'vertico-multiform-categories
               '(jinx grid (vertico-grid-annotate . 20)))
  ;; :hook (emacs-startup . global-jinx-mode)
  ;; :bind (("M-$" . jinx-correct)
  ;;        ("C-M-$" . jinx-languages))
  )

(provide 'init-spellcheck)

;; Local Variables:
;; jinx-languages: "ru_RU"
;; End:
