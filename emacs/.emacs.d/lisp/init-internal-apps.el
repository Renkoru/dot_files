;;; init-internal-apps.el --- internal applications set
;;; Commentary:
;;; Code:

(use-package writeroom-mode)
(use-package restclient)
(use-package ranger
  :general
  ("<f3>" 'ranger)
  :config
  (setq ranger-preview-file nil)
  (setq ranger-cleanup-on-disable t)
  (setq ranger-show-hidden t)
  )


;; (require 'init-neotree) ? need to remove it (not using)


(provide 'init-internal-apps)
;;; init-internal-apps.el ends here
