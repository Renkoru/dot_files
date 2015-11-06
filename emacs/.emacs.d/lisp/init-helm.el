; init-helm.el

(require 'helm-config)
(require 'helm-swoop)

(helm-mode 1)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t
      helm-M-x-fuzzy-match        t
      helm-semantic-fuzzy-match   t
      helm-imenu-fuzzy-match      t
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-ag-use-agignore t)


;; TODO: Move all mappings to separete dir.
;; TODO: Separate all other packages settings
(global-set-key (kbd "C-q") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)


(setq helm-ag-use-agignore t)

(provide 'init-helm)
