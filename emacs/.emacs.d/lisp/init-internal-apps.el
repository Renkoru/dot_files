;;; init-internal-apps.el --- internal applications set
;;; Commentary:
;;; Code:

(use-package writeroom-mode)
;; (use-package restclient)
;; (use-package ranger
;;   ;; :general
;;   ;; ("<f3>" 'ranger)
;;   :config
;;   (setq ranger-preview-file nil)
;;   (setq ranger-cleanup-on-disable t)
;;   (setq ranger-show-hidden t)
;;   )

(use-package dirvish
  :after (dired evil)
  :init
  (dirvish-override-dired-mode)
  ;; :custom
  ;; (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
  ;;  '(("h" "~/"                          "Home")
  ;;    ("d" "~/Downloads/"                "Downloads")
  ;;    ("m" "/mnt/"                       "Drives")
  ;;    ("t" "~/.local/share/Trash/files/" "TrashCan")))
  :config
  ;; (dirvish-peek-mode) ; Preview files in minibuffer
  ;; (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index)))
  (setq dirvish-attributes
        ;; '(all-the-icons file-time file-size collapse subtree-state vc-state git-msg))
        '(file-time file-size collapse subtree-state))
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")

  ;; https://github.com/emacs-evil/evil-collection/blob/master/modes/dired/evil-collection-dired.el#L41
  (evil-define-key '(normal) dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file

    ;; "j" 'dired-next-line
    ;; "k" 'dired-previous-line
    ;; (kbd "RET") 'dired-find-file
    ;; (kbd "S-<return>") 'dired-find-file-other-window
    ;; (kbd "M-RET") 'dired-display-file
    ;; "gO" 'dired-find-file-other-window
    ;; "go" 'dired-view-file
    )

  (evil-define-key '(normal) dirvish-mode-map
    (kbd "TAB")  'dirvish-subtree-toggle
    )

  ;; (add-hook '
  ;;           (lambda ()
  ;;             (evil-local-set-key 'normal
  ;;                                 "h" 'dired-up-directory
  ;;                         "l" 'dired-find-file
  ;;                         ;; "j" 'dired-next-line
  ;;                         ;; "k" 'dired-previous-line
  ;;                         ;; (kbd "RET") 'dired-find-file
  ;;                         ;; (kbd "S-<return>") 'dired-find-file-other-window
  ;;                         ;; (kbd "M-RET") 'dired-display-file
  ;;                         ;; "gO" 'dired-find-file-other-window
  ;;                         ;; "go" 'dired-view-file
  ;;                         ))
  ;;           )
  :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
  (("C-c f" . dirvish-fd)
   ("<f3>" . dirvish)
   :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
   ("a"   . dirvish-quick-access)
   ("f"   . dirvish-file-info-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ;; ("h"   . dirvish-history-jump) ; remapped `describe-mode'
   ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
   ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
   ("M-f" . dirvish-history-go-forward)
   ("M-b" . dirvish-history-go-backward)
   ("M-l" . dirvish-ls-switches-menu)
   ("M-m" . dirvish-mark-menu)
   ("M-t" . dirvish-layout-toggle)
   ("M-s" . dirvish-setup-menu)
   ("M-e" . dirvish-emerge-menu)
   ("M-j" . dirvish-fd-jump)
   )
  )


;; (require 'init-neotree) ? need to remove it (not using)


(provide 'init-internal-apps)
;;; init-internal-apps.el ends here
