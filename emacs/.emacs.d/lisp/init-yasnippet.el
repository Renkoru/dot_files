; init-yasnippet.el

(use-package yasnippet
  :config
  (yas-global-mode 1)
  (add-hook 'after-save-hook
            (lambda ()
              (when (eql major-mode 'snippet-mode)
                (yas-reload-all))))
  (setq yas/snippet-dirs
        (list (concat user-emacs-directory "snippets")))

  :general
  (yas-minor-mode-map "C-<return>" 'yas-expand))

(use-package auto-yasnippet
  :general
  (:states 'insert "C-p" 'aya-expand))



(provide 'init-yasnippet)
