; init-yasnippet.el

(use-package yasnippet
  :diminish yas-minor-mode

  :config
  (add-hook 'after-save-hook
            (lambda ()
              (when (eql major-mode 'snippet-mode)
                (yas-reload-all))))
  (setq yas/snippet-dirs
        (list (concat user-emacs-directory "snippets")))
  (bind-key "C-<return>" 'yas-expand)
  (yas-global-mode 1)
  )


(provide 'init-yasnippet)
