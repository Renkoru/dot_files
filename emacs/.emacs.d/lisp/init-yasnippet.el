; init-yasnippet.el
(require 'yasnippet)
(yas-global-mode 1)

; snippets dir
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ))

(define-key yas-minor-mode-map (kbd "C-<return>") 'yas-expand)
;; (global-set-key (kbd "C-<return>") 'yas-expand)
;; (global-set-key (kbd "C-y") 'yas-expand)

(provide 'init-yasnippet)
