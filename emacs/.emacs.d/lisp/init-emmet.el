(require 'emmet-mode)

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.


(global-set-key (kbd "C-j") 'emmet-expand-line)

(provide 'init-emmet)