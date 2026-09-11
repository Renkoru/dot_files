;;; init-org.el --- avy settings
;;; Commentary:
;;; Code:

(setq org-src-fontify-natively t)
(setq org-startup-indented t)
(setq org-export-coding-system 'utf-8)

;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (define-key evil-normal-state-local-map
;;                         (kbd "TAB")  'org-cycle)))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((shell . t)))


;; (use-package ox-reveal :defer t)
; (use-package ox-reveal
;   :after org
;   :config
;   (setq org-reveal-title-slide nil)
;   )

; (use-package org-superstar
;   :hook (org-mode . org-superstar-mode))

(setq org-capture-templates
      '(("w" "Work Todo list item" plain
         (file+olp "~/org/work.org" "Inbox" "Todos")
         (file "~/.emacs.d/org-templates/work-todo.orgcapture"))
        ("p" "Personal Todo list item" plain
         (file+olp "~/projects/diary/todolist.org" "Inbox" "Todos")
         (file "~/.emacs.d/org-templates/personal-todo.orgcapture"))
        ("n" "Note" plain
         (file+olp "~/org/work.org" "Inbox" "Notes")
         (file "~/.emacs.d/org-templates/work-note.orgcapture"))
        ))

(setq org-log-done 'time)

(setq org-todo-keywords
      '((sequence "TODO(t)" "PROG(p)" "WAIT(w)" "|" "DONE(d)" "CANCELED(c)")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("PROG" . "goldenrod")
        ("CANCELED" . (:foreground "blue" :weight bold))))

;; Removed: large commented-out hydra-org block (org navigation hydra).
;; Kept for reference in git history; uncomment if needed.

(provide 'init-org)
;;; init-org.el ends here
