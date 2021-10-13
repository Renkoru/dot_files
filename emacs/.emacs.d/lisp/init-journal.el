;;; init-journal.el --- journal setup
;;; Commentary:
;;; Code:

(use-package org-journal
  :defer t

  :init
  ;; Change default prefix key; needs to be set before loading org-journal
  (setq org-journal-prefix-key "C-c j ")

  :config
  (setq org-journal-dir "~/projects/diary/journal"
        org-journal-date-format "%A, %d %B %Y"
        org-journal-file-type 'monthly)
  (add-hook 'org-journal-after-header-create-hook
            (lambda ()
              ;; Add real created date, instead of org-journal 'CREATED' wrong property value
              (org-set-property "MR_CREATED" (format-time-string "[%Y-%m-%d %a %H:%M]"))))
  )


(provide 'init-journal)
;;; init-journal.el ends here
