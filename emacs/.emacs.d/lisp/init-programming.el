;;; init-programming.el --- Emacs settings
;;; Commentary:
;;; Code:

;; Golang: 'gopls' should be installed

;; https://github.com/progfolio/elpaca/issues/398
;; (unload-feature 'eldoc t)
;; (setq custom-delayed-init-variables '())
;; (defvar global-eldoc-mode nil)

(use-package eldoc
  :ensure nil
  :config
  (global-eldoc-mode)) ;; This is usually enabled by default by Emacs

(use-package jsonrpc
  :ensure nil
  )

;; (use-package eldoc
;;   :ensure (:wait t)
;;   :config
;;   (eldoc-mode 1)
;;   (setq eldoc-idle-delay 1.5)
;;   )

(use-package eglot
  :ensure nil
  :after (eldoc jsonrpc)
  :defer t
  :config
  (my-space-leader "cr" 'eglot-rename)

  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              ;; Show flymake diagnostics first.
              (setq eldoc-documentation-functions
                    (cons #'flymake-eldoc-function
                          (remove #'flymake-eldoc-function eldoc-documentation-functions)))
              ;; Show all eldoc feedback.
              (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))

  )

(defun eglot-format-buffer-on-save ()
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

;; Apply formatting for various languages
(use-package apheleia
  :hook (prog-mode . apheleia-mode))


(use-package turbo-log
  :ensure (:host github :repo "artawower/turbo-log.el")
  :general
  (:states 'visual "SPC l" 'turbo-log-print-immediately)
  :config
  (setq turbo-log-allow-insert-without-tree-sitter-p t)

  (add-to-list 'turbo-log-loggers '(jtsx-tsx-mode
                                    (:loggers
                                     ("console.log(%s)" "console.debug(%s)" "console.warn(%s)")
                                     :jump-list
                                     ((class_declaration
                                       (:current-node-types
                                        (property_identifier)
                                        :destination-node-names
                                        ("constructor")
                                        :parent-node-types
                                        (public_field_definition))))
                                     :msg-format-template "'TCL: %s'" :identifier-formatter-rules
                                     ((property_identifier
                                       (:formatter "this.%s" :parent-node-types
                                                   (public_field_definition))))
                                     :identifier-node-types
                                     ("identifier" "member_expression" "property_identifier")))
               )
  )

(use-package emmet-mode
  :hook (tsx-ts-mode . emmet-mode)
  :general
  (:states 'insert "C-j" 'emmet-expand-line)

  :config
  (add-to-list 'emmet-jsx-major-modes 'your-jsx-major-mode)
  ;; Auto-start on any markup modes
  (add-hook 'sgml-mode-hook 'emmet-mode)
  ;; enable Emmet's css abbreviation.
  (add-hook 'css-mode-hook  'emmet-mode)
  (setq emmet-self-closing-tag-style " /"))

;; Setup TreeSitter
;; (require 'treesit)

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (cmake "https://github.com/uyha/tree-sitter-cmake")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (go "https://github.com/tree-sitter/tree-sitter-go")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (make "https://github.com/alemuller/tree-sitter-make")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (dockerfile "https://github.com/camdencheek/tree-sitter-dockerfile" "main" "src")
        (nu "https://github.com/nushell/tree-sitter-nu" "main" "src")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; (use-package treesit-auto
;;   :demand t
;;   :config
;;   (global-treesit-auto-mode))

;; (setq major-mode-remap-alist
;;       '((yaml-mode . yaml-ts-mode)
;;         (bash-mode . bash-ts-mode)
;;         (js2-mode . js-ts-mode)
;;         (typescript-mode . typescript-ts-mode)
;;         (json-mode . json-ts-mode)
;;         (css-mode . css-ts-mode)
;;         (go-mode . go-ts-mode)
;;         (python-mode . python-ts-mode)))

;; learn and use text-objects with treesit
;; (setq treesit-font-lock-level 4)
;; treesit-font-lock-feature-list is a variable defined in ‘treesit.el’.

(use-package combobulate
  :ensure (:host github :repo "mickeynp/combobulate")
  :preface
  ;; You can customize Combobulate's key prefix here.
  ;; Note that you may have to restart Emacs for this to take effect!
  (setq combobulate-key-prefix "C-c o")

  ;; Optional, but recommended.
  ;;
  ;; You can manually enable Combobulate with `M-x
  ;; combobulate-mode'.
  :hook ((python-ts-mode . combobulate-mode)
         (js-ts-mode . combobulate-mode)
         (css-ts-mode . combobulate-mode)
         (yaml-ts-mode . combobulate-mode)
         (json-ts-mode . combobulate-mode)
         (typescript-ts-mode . combobulate-mode)
         ;; (go-ts-mode . combobulate-mode)
         (tsx-ts-mode . combobulate-mode))
  ;; Amend this to the directory where you keep Combobulate's source
  ;; code.

  ;; :load-path ("../elpaca/repos/combobulate/")
  :general
  (general-nmap
    "M-k" 'combobulate-drag-up
    "M-j" 'combobulate-drag-down
    "M-h" 'combobulate-navigate-up
    "M-l" 'combobulate-navigate-down
    )
  )
;; (require rx)
;; (straight-use-package
;;  '(evil-ts :type git :host github :repo "foxfriday/evil-ts")
;;  :config
;;  (evil-define-text-object my-if-or-try (count &optional beg end type)
;;    (evil-ts-select-obj (rx (or "else" "for" "with" "try" "if") "_statement")))

;;  (keymap-set evil-inner-text-objects-map "i" 'my-if-or-try)
;;  (keymap-set evil-outer-text-objects-map "i" 'my-if-or-try)
;;  )

;; (evil-define-text-object foo (count &optional beg end type)
;;   "Select three characters."
;;   (list (point) (+ 3 (point))))


;; (keymap-set evil-inner-text-objects-map "f" 'foo)
;; (keymap-set evil-outer-text-objects-map "f" 'foo)
;; (define-key evil-matlab-textobjects-outer-map "f" 'foo)
;; (define-key evil-matlab-textobjects-inner-map "f" 'foo)

;; (define-key evil-outer-text-objects-map "f" #'foo)
;; (define-key evil-inner-text-objects-map "f" #'foo)

;;   (combobulate-query-capture)

;;                                               (function_declaration body: (_) @function.inner)

;; (defun mr/tcap ()
;;   (interactive)
;;   (message "hererer")
;;   (message "%s" (treesit-node-at (point)))
;;   ;; (setq mr/tcap-res (treesit-query-capture
;;   (message "%s" (treesit-query-capture
;; 		     (treesit-node-at (point)) '(
;;                                               (function_declaration body: (_) @function.inner)
;; 			       )))
;;   )

;; ;; (treesit-query-capture node query beg end node-only))

;; (treesit-query-capture )

;;   (use-package evil-textobj-tree-sitter
;;     :config
;;     ;; bind `function.outer`(entire function block) to `f` for use in things like `vaf`, `yaf`
;;     (define-key evil-outer-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.outer"))
;;     ;; bind `function.inner`(function block without name and args) to `f` for use in things like `vif`, `yif`
;;     ;; (define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner"))
;; ;; The first arguemnt to `evil-textobj-tree-sitter-get-textobj' will be the capture group to use
;; ;; and the second arg will be an alist mapping major-mode to the corresponding query to use.
;; (define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner"
;;                                               '((typescript-ts-mode . (function_declaration body: (_) @function.inner))
;;                                                 ;; (rust-mode . [(use_declaration) @import])
;;                                                 )))
;;     )
;;   )


(provide 'init-programming)
