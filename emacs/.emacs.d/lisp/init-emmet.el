;;; package --- init-emmet.el
;;; Commentary:
;;; initialization of emmet mode for Emacs

;;; Code:
(use-package emmet-mode
  :bind
  ("C-j" . emmet-expand-line)

  :init
  ;; Auto-start on any markup modes
  (add-hook 'sgml-mode-hook 'emmet-mode)
  ;; enable Emmet's css abbreviation.
  (add-hook 'css-mode-hook  'emmet-mode)
  (setq emmet-self-closing-tag-style "")
  )

(provide 'init-emmet)
;;; init-emmet.el ends here
