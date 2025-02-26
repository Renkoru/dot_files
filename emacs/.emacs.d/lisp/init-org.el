;;; init-org.el --- avy settings
;;; Commentary:
;;; Code:

(use-package verb)

(use-package org
  :ensure nil
  :after verb
  :config
  (evil-define-key '(normal) org-mode-map
    (kbd "TAB") 'org-cycle)
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map)
  ;; active Babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)))
  )

(setq initial-major-mode 'org-mode)
(setq org-src-fontify-natively t)
(setq org-startup-indented t)
(setq org-export-coding-system 'utf-8)

;; (use-package ox-reveal :defer t)
(use-package ox-reveal
  :after org
  :config
  (setq org-reveal-title-slide nil)
  )

(use-package org-superstar
  :hook (org-mode . org-superstar-mode))

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

(setq org-todo-keywords
      '((sequence "TODO(t)" "PROG(p)" "WAIT(w)" "|" "DONE(d)" "CANCELED(c)")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("PROG" . "goldenrod")
        ("CANCELED" . (:foreground "blue" :weight bold))))



(defhydra hydra-org (:color pink)
  "
    _L_ right _H_ left
    _K_ up _J_ down
    _i_ insert heading
    _c_ shift right _C_ shift left
    _n_ next heading _p_ previous heading
    _l_ toggle link display
    _m_ set tag _a_ archive _t_ todo
    _f_ focus (narrow) _F_  unfocus (wider)
    "
  ("H" org-metaleft)
  ("L" org-metaright)
  ("K" org-metaup)
  ("J" org-metadown)
  ("i" org-insert-heading :exit nil)
  ("c" org-shiftright)
  ("C" org-shiftleft)
  ("l" org-toggle-link-display)
  ("m" org-set-tags-command :exit t)
  ("a" org-archive-subtree)
  ("t" org-todo)
  ("n" org-next-visible-heading)
  ("p" org-previous-visible-heading)
  ("f" org-narrow-to-subtree)
  ("F" org-toggle-narrow-to-subtree)
  ("q" nil "quit"))


(my-space-leader
  "z" 'org-capture
  "o" 'hydra-org/body)

(provide 'init-org)
;;; init-org.el ends here
