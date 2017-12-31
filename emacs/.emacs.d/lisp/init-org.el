;;; init-org.el --- avy settings
;;; Commentary:
;;; Code:


(setq org-src-fontify-natively t)
(setq org-startup-indented t)
(setq org-export-coding-system 'utf-8)
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
(setq org-log-done 'note)

(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("PROG" . "yellow")
        ("CANCELED" . (:foreground "blue" :weight bold))))


(defhydra hydra-org (:color pink)
  "
    _L_ right _H_ left
    _K_ up _J_ down
    _c_ shift right _C_ shift left
    _m_ set tag _a_ archive _t_ todo
    "
  ("H" org-metaleft)
  ("L" org-metaright)
  ("K" org-metaup)
  ("J" org-metadown)
  ("c" org-shiftright)
  ("C" org-shiftleft)
  ("m" org-set-tags-command :exit t)
  ("a" org-archive-subtree)
  ("t" org-todo)
  ("q" nil "quit"))


(general-define-key :prefix my-leader
                    "z" 'org-capture
                    "o" 'hydra-org/body)

(provide 'init-org)
;;; init-org.el ends here