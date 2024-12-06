;;; init-javascript.el --- javascript

;;; Commentary:

;; Investigate this package and fork and update it to use ripgrep and ivy/counsel to select cantidates
;; https://github.com/nicolaspetton/xref-js2

;;; Code:
(use-package flymake-eslint)


;; JS packages
;; use-package nodejs-repl ?

;; !! Cause some freezes in some cases: org, tramp?
;; (use-package jest)

;; Replaced by treesit
;; (use-package typescript-mode
;;   :hook (typescript-mode-hook . eglot-ensure)
;;   :mode "\\.ts\\'")

;; (use-package ng2-mode
;;   :hook (ng2-ts-mode . eglot-ensure))

;; Angular setup
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))

(add-hook 'typescript-ts-mode-hook 'eglot-ensure)


;; TODO: implement angular switch to template and spec file
;; (defun ng-open-counterpart (type)
;;   "Opens the corresponding template or component file to this one."
;;   (interactive)
;;   (find-file (ng2--counterpart-name (buffer-file-name))))

;;   :hook (ng2-ts-mode . eglot-ensure))


;; (use-package js2-mode
;;   ;; :mode ("\\.js\\'" . js2-mode)
;;   :hook (js-mode-hook . eglot-ensure)
;;   :config
;;   (setq js-switch-indent-offset 4)
;;   (add-hook 'js2-mode-hook 'js2-imenu-extras-mode) ;; Better imenu
;;   (setq js2-mode-show-parse-errors nil)
;;   (setq js2-mode-show-strict-warnings nil)
;;   )

;; (use-package js-doc
;;   :straight (:host github :repo "dogayuksel/js-doc")
;; )

;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(defun js-jsx-indent-line-align-closing-bracket ()
  "Workaround sgml-mode and align closing bracket with opening bracket"
  (save-excursion
    (beginning-of-line)
    (when (looking-at-p "^ +\/?> *$")
      (delete-char sgml-basic-offset))))

(use-package rjsx-mode
  :mode ("\\.jsx\\'" "\\.tsx\\'")
  :config
  (add-to-list 'auto-mode-alist '("\\.react\\.js$" . rjsx-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.jsx$" . rjsx-mode))
  ;; (setq sgml-basic-offset 4) ;; need for js2-jsx-indent-line
  ;; (advice-add #'js-jsx-indent-line :after #'js-jsx-indent-line-align-closing-bracket)


  ;; ;; JSX
  ;; (add-to-list 'auto-mode-alist '("\\.jsx\\'".web-mode))
  ;; (add-hook 'web-mode-hook
  ;;           (lambda()
  ;;             (when(string-equal "jsx"(file-name-extension buffer-file-name))
  ;;               (setup-tide-mode))))
  ;; configure jsx - tide checker to run after your default jsx checker
  ;; (flycheck-add-mode 'javascript-eslint 'web-mode)
  )

;; (use-package add-node-modules-path
;;   :after (:any js2-mode rjsx-mode typescript-mode)
;;   :hook (js2-mode rjsx-mode typescript-mode))



;; ---------------------
;; Install node.js v0.12.0 or greater.
;; Make sure tsconfig.json or jsconfig.json is present in the root folder of the project.
;; Tide is available in melpa.You can install tide via package - install M - x package - install[ret] tide
;; (use-package tide
;;   :general
;;   (:states 'normal :keymaps '(js-mode-map typescript-mode-map) "gd" 'tide-jump-to-definition)
;;   (:states 'normal :keymaps '(js-mode-map typescript-mode-map) "gb" 'tide-jump-back)

;;   :config
;;   (defun setup-tide-mode ()
;;     (interactive)
;;     (tide-setup)
;;     (flycheck-mode +1)
;;     (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;     (eldoc-mode +1)
;;     ;; (tide-hl-identifier-mode +1)

;;     ;; company is an optional dependency. You have to
;;     ;; install it separately via package-install
;;     ;; `M-x package-install [ret] company`
;;     (company-mode +1))

;;   ;; aligns annotation to the right hand side
;;   (setq company-tooltip-align-annotations t)

;;   ;; formats the buffer before saving
;;   ;; (add-hook 'before-save-hook 'tide-format-before-save)

;;   (add-hook 'typescript-mode-hook #'setup-tide-mode)
;;   (add-hook 'rjsx-mode-hook #'setup-tide-mode)
;;   (add-hook 'js2-mode-hook #'setup-tide-mode))


;; (add - hook 'typescript-mode-hook #'setup - tide - mode)

;; configure javascript - tide checker to run after your default javascript checker

;; Not usable for now, investigate package, maybe found some usefull things
;; (use-package js2-refactor
;;   :config
;;   (add-hook 'js2-mode-hook #'js2-refactor-mode))

;; (add-hook 'js-mode-hook 'js2-minor-mode)

(defun js-custom ()
  "JavaScript-mode-hook."
  (setq js-indent-level 2)
  (setq tab-width 2)
  )

(defun ts-custom ()
  "Typescript-mode-hook."
  (setq typescript-indent-level 2)
  (setq tab-width 2)
  )

(setq-default js2-global-externs '("describe" "expect" "it" "jest" ))

(add-hook 'js-mode-hook 'js-custom)
(add-hook 'typescript-mode-hook 'ts-custom)

;; (setq js2-highlight-level 3)

;; (setq-default js2-strict-trailing-comma-warning nil)
;; '(js2-strict-trailing-comma-warning nil)
;; (setq js2-strict-trailing-comma-warning nil)

(use-package vue-mode
  :mode "\\.vue\\'"
  :init
  (add-hook 'mmm-mode-hook
            (lambda ()
              (set-face-background 'mmm-default-submode-face nil)))
  )

;; (use-package tree-sitter
;;   :config
;;   (global-tree-sitter-mode)
;;   (push '(ng2-html-mode . html) tree-sitter-major-mode-language-alist)
;;   (push '(ng2-ts-mode . typescript) tree-sitter-major-mode-language-alist)
;;   (push '(scss-mode . css) tree-sitter-major-mode-language-alist)
;;   (push '(scss-mode . typescript) tree-sitter-major-mode-language-alist))

;; (use-package tree-sitter-langs
;;   :ensure t
;;   :after tree-sitter)

(use-package jsdoc
  :elpaca (:host github :repo "isamert/jsdoc.el"))

(provide 'init-javascript)
;;; init-javascript.el ends here
