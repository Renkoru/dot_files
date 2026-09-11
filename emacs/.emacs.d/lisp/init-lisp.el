;;; package --- init-lisp.el
;;; Commentary:
;;; initialization of Lisp mode for Emacs
;;; Code:

;; [meow-migration] lispyville depends on evil, commented out.
;; lispy keybindings changed to meow-normal-state-keymap.
(use-package lispy
  :config
  (define-key lispy-mode-map (kbd "M-q") nil)
  ;; [meow-migration] :keymaps → define-key on both keymaps
  (define-key lispy-mode-map (kbd "g c c") 'lispy-comment)
  (define-key meow-normal-state-keymap (kbd "g c c") 'lispy-comment)
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1))))

;; [meow-migration] lispyville depends on evil, disabled
;; (use-package lispyville
;;   :after lispy
;;   :config
;;   (add-hook 'lispy-mode-hook #'lispyville-mode))

;; (use-package parinfer
;;   :general
;;   ("C-," 'parinfer-toggle-mode)
;;   :init
;;   (progn
;;     (setq parinfer-extensions
;;           '(defaults       ; should be included.
;;              pretty-parens  ; different paren styles for different modes.
;;              evil           ; If you use Evil.
;;              ;; smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
;;              ;; smart-yank ; Yank behavior depend on mode.
;;              paredit))        ; Introduce some paredit commands.
;;     (add-hook 'clojure-mode-hook #'parinfer-mode)
;;     (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
;;     (add-hook 'common-lisp-mode-hook #'parinfer-mode)
;;     (add-hook 'scheme-mode-hook #'parinfer-mode)
;;     (add-hook 'lisp-mode-hook #'parinfer-mode)))

(provide 'init-lisp)
;;; init-lisp.el ends here
