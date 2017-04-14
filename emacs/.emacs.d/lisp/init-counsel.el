;;; package --- init-counsel.el
;;; Commentary:
;;; Code:

(use-package counsel
  ;; :init
  ;; (progn
  ;;   (require 'helm-config)
  ;;   (setq helm-candidate-number-limit 100)
  ;;   ;; From https://gist.github.com/antifuchs/9238468
  ;;   (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
  ;;         helm-input-idle-delay 0.01  ; this actually updates things
  ;;                                       ; reeeelatively quickly.
  ;;         helm-yas-display-key-on-candidate t
  ;;         helm-quick-update t
  ;;         helm-M-x-requires-pattern nil
  ;;         helm-ff-skip-boring-files t
  ;;         helm-buffers-fuzzy-matching t
  ;;         helm-buffer-max-length 40
  ;;         helm-recentf-fuzzy-match    t
  ;;         helm-M-x-fuzzy-match        t
  ;;         helm-semantic-fuzzy-match   t
  ;;         helm-imenu-fuzzy-match      t
  ;;         helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
  ;;         helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
  ;;         helm-ff-file-name-history-use-recentf t
  ;;         helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
  ;;         helm-ag-use-agignore t)
  ;;   (helm-mode)
  ;;   (helm-projectile-on))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
;; C-c p f counsel-projectile-find-file: find a project file,
;; C-c p d counsel-projectile-find-dir: find a project directory,
;; C-c p b counsel-projectile-switch-to-buffer: switch to a project buffer,
;; C-c p s s counsel-projectile-ag: search project files with ag,
;; C-c p p counsel-projectile-switch-project: switch to another project (see above).
    (evil-leader/set-key
      "f" 'counsel-projectile-find-file
      "a" 'counsel-projectile-ag
      )
    )
  :bind (
         ("C-q" . ivy-switch-buffer)
         ("M-x" . counsel-M-x)
         ("M-f" . counsel-find-file)
         ("C-c C-r" . ivy-resume)

         :map evil-normal-state-map
         ("gl" . swiper)
         )
  )


(provide 'init-counsel)
;;; init-counsel.el ends here
