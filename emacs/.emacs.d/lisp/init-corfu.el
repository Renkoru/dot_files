;;; init-corfu.el --- Complition configuration
;;; Commentary:
;;; Code:

(use-package corfu
  :after (eldoc)
  :ensure (corfu :files (:defaults "extensions/*")
                 :includes (corfu-indexed corfu-quick))
  ;; :hook
  ;; (lsp-completion-mode . mr/corfu-setup-lsp) ; Use corfu for lsp completion
  ;; (corfu-mode . corfu-indexed-mode)
  :bind (
         ;; ([remap "C-n"] . corfu-next)
         :map evil-insert-state-map
         ("M-/" . completion-at-point)
         :map corfu-map
         ("C-p" . corfu-previous)
         ("C-n" . corfu-next)
         ;;           "C-n" #'corfu-next
         ;;           "C-p" #'
         ;;           "C-n" #'corfu-next
         ;;           "C-p" #'corfu-previous
         ;;           "<escape>" #'corfu-quit
         ;;           "<return>" #'corfu-insert
         ;; ("M-p" . term-send-up)
         ;; ("M-n" . term-send-down)
         ;; :map term-raw-map
         ;; ("M-o" . other-window)
         ;; ("M-p" . term-send-up)
         ;; ("M-n" . term-send-down)
         ;; )
         )
  ;; :general
  ;; (:states '(insert) "M-/" 'completion-at-point)
  ;; (:keymaps 'corfu-map
  ;;           :states 'insert
  ;;           "C-n" #'corfu-next
  ;;           "C-p" #'corfu-previous
  ;;           "<escape>" #'corfu-quit
  ;;           "<return>" #'corfu-insert
  ;;           "H-SPC" #'corfu-insert-separator
  ;;           ;; "SPC" #'corfu-insert-separator ; Use when `corfu-quit-at-boundary' is non-nil
  ;;           "M-d" #'corfu-show-documentation
  ;;           "C-g" #'corfu-quit
  ;;           "M-l" #'corfu-show-location
  ;;           "M-j" #'corfu-quick-complete
  ;;           )
  :custom
  ;; Works with `indent-for-tab-command'. Make sure tab doesn't indent when you
  ;; want to perform completion
  (tab-always-indent 'complete)
  (completion-cycle-threshold nil)      ; Always show candidates in menu

  (corfu-auto nil)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.25)

  (corfu-min-width 80)
  (corfu-max-width corfu-min-width)     ; Always have the same width
  (corfu-count 14)
  (corfu-scroll-margin 4)
  (corfu-cycle nil)

  ;; `nil' means to ignore `corfu-separator' behavior, that is, use the older
  ;; `corfu-quit-at-boundary' = nil behavior. Set this to separator if using
  ;; `corfu-auto' = `t' workflow (in that case, make sure you also set up
  ;; `corfu-separator' and a keybind for `corfu-insert-separator', which my
  ;; configuration already has pre-prepared). Necessary for manual corfu usage with
  ;; orderless, otherwise first component is ignored, unless `corfu-separator'
  ;; is inserted.
  (corfu-quit-at-boundary nil)
  (corfu-separator ?\s)            ; Use space
  (corfu-quit-no-match 'separator) ; Don't quit if there is `corfu-separator' inserted
  (corfu-preview-current 'insert)  ; Preview first candidate. Insert on input if only one
  (corfu-preselect-first t)        ; Preselect first candidate?

  ;; Other
  (corfu-echo-documentation nil)        ; Already use corfu-doc
  ;; (corfu-indexed-start 1)
  ;; (lsp-completion-provider :none)       ; Use corfu instead for lsp completions
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  :config
  ;; NOTE 2022-03-01: This allows for a more evil-esque way to have
  ;; `corfu-insert-separator' work with space in insert mode without resorting to
  ;; overriding keybindings with `general-override-mode-map'. See
  ;; https://github.com/minad/corfu/issues/12#issuecomment-869037519
  ;; Alternatively, add advice without `general.el':
  (evil-make-overriding-map corfu-map)
  ;; (advice-add 'corfu--setup :after 'evil-normalize-keymaps)
  ;; (advice-add 'corfu--teardown :after 'evil-normalize-keymaps)
  (advice-add 'corfu--setup :after (lambda (&rest _) (evil-normalize-keymaps)))
  (advice-add 'corfu--teardown :after (lambda (&rest _) (evil-normalize-keymaps)))
  ;; (general-add-advice '(corfu--setup corfu--teardown) :after 'evil-normalize-keymaps)

  ;; Enable Corfu more generally for every minibuffer, as long as no other
  ;; completion UI is active. If you use Mct or Vertico as your main minibuffer
  ;; completion UI. From
  ;; https://github.com/minad/corfu#completing-with-corfu-in-the-minibuffer
  (defun corfu-enable-always-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
    (unless (or (bound-and-true-p mct--active) ; Useful if I ever use MCT
                (bound-and-true-p vertico--input))
      (setq-local corfu-auto nil)       ; Ensure auto completion is disabled
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1)

  ;; Setup lsp to use corfu for lsp completion
  ;; (defun mr/corfu-setup-lsp ()
  ;;   "Use orderless completion style with lsp-capf instead of the default lsp-passthrough."
  ;;   (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
  ;;         '(orderless)))
  )

;; (use-package corfu-popupinfo
;;   :load-path "straight/repos/corfu/extensions/"
;;   :after corfu)
;; (use-package corfu-popupinfo
;;   :after corfu
;;   :hook (corfu-mode . corfu-popupinfo-mode)
;;   :custom
;;   (corfu-popupinfo-delay '(0.25 . 0.1))

;; Add extensions
(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  ;; :bind (("C-c p p" . completion-at-point) ;; capf
  ;;        ("C-c p t" . complete-tag)        ;; etags
  ;;        ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ("C-c p k" . cape-keyword)
  ;;        ("C-c p s" . cape-symbol)
  ;;        ("C-c p a" . cape-abbrev)
  ;;        ("C-c p l" . cape-line)
  ;;        ("C-c p w" . cape-dict)
  ;;        ("C-c p \\" . cape-tex)
  ;;        ("C-c p _" . cape-tex)
  ;;        ("C-c p ^" . cape-tex)
  ;;        ("C-c p &" . cape-sgml)
  ;;        ("C-c p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  ;; NOTE: The order matters!
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  )


(provide 'init-corfu)
;;; init-corfu.el ends here
