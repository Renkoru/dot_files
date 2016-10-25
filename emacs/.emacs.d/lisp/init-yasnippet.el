; init-yasnippet.el

(use-package yasnippet
  :config
  (add-hook 'after-save-hook
            (lambda ()
              (when (eql major-mode 'snippet-mode)
                (yas-reload-all))))
  (setq yas/snippet-dirs
        (list (concat user-emacs-directory "snippets")))
  (bind-keys :map yas-minor-mode-map
             ("C-<return>" . yas-expand))
  (yas-global-mode 1)
  )


(provide 'init-yasnippet)
