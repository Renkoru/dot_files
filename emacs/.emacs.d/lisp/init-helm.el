; init-helm.el

(use-package helm-projectile)
(use-package helm-ag)
(use-package helm-swoop)

(use-package helm
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t
          helm-buffers-fuzzy-matching t
          helm-recentf-fuzzy-match    t
          helm-M-x-fuzzy-match        t
          helm-semantic-fuzzy-match   t
          helm-imenu-fuzzy-match      t
          helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
          helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
          helm-ff-file-name-history-use-recentf t
          helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
          helm-ag-use-agignore t)
    (helm-mode)
    (helm-projectile-on))
  :bind (("C-q" . helm-mini)
         ("M-f" . helm-find-files)
         ("M-x" . helm-M-x))
  )


(provide 'init-helm)
