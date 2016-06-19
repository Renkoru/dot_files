(use-package emmet-mode
  :bind
  ("C-j" . emmet-expand-line)

  :init
  ;; Auto-start on any markup modes
  (add-hook 'sgml-mode-hook 'emmet-mode)
  ;; enable Emmet's css abbreviation.
  (add-hook 'css-mode-hook  'emmet-mode)
  )

(provide 'init-emmet)
