;;; init-org.el --- avy settings
;;; Commentary:
;;; Code:


(setq org-src-fontify-natively t)
(setq org-startup-indented t)
(setq org-export-coding-system 'utf-8)
(setq org-capture-templates
      '(("t" "Todo list item" plain
         (file+olp "~/org/work.org" "Inbox" "Todos")
         (file "~/.emacs.d/org-templates/work-todo.orgcapture"))
        ("n" "Note" plain
         (file+olp "~/org/work.org" "Inbox" "Notes")
         (file "~/.emacs.d/org-templates/work-note.orgcapture"))
        ))



(evil-leader/set-key "c" 'org-capture)


(provide 'init-org)
;;; init-org.el ends here
