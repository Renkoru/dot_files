;;; init-selectrum-stack.el --- Appearance settings
;;; Commentary:
;;; Code:

;; TOOD packages
;; 1. https://gitlab.com/OlMon/consult-projectile

(use-package prescient)
(use-package ivy-prescient)
(use-package company-prescient)
(use-package selectrum-prescient)

(use-package marginalia
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  ;; :bind (("M-A" . marginalia-cycle)
  ;;        :map minibuffer-local-map
  ;;        ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))


(use-package embark
  ;; :bind
  ;; (("C-." . embark-act)         ;; pick some comfortable binding
  ;;  ("C-;" . embark-dwim)        ;; good alternative: M-.
  ;;  ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :bind (:map minibuffer-local-map
              ("C-o" . #'embark-export)
              ("M-o" . #'embark-act))

;; embark-prompter to embark-completing-read-prompter.


  ;; :general
  ;; (:states 'normal
  ;;          "C-." 'embark-act
  ;;          "C-;" 'embark-dwim)
  ;; (my-space-leader
  ;;   "y" 'consult-yank-pop
  ;;   "f" 'consult-find
  ;;   "a" 'consult-ripgrep)
  ;; (:keymaps 'global "C-;" 'embark-dwim)
  ;; (:keymaps 'minibuffer-local-map "C-." :states 'normal 'embark-dwim)

  ;; :init

  ;; Optionally replace the key help with a completing-read interface
  ;; (setq prefix-help-command #'embark-prefix-help-command)

  :config
  (setq embark-indicators
        '(embark-minimal-indicator
          embark-highlight-indicator))

  ;; If you want to add new actions to existing target
  (general-def embark-file-maporg-mode-map
    "r" 'dired-do-chmod)

  ;; (setq embark-prompter 'embark-completing-read-prompter)

  ;; Hide the mode line of the Embark live/completions buffers
  ;; (add-to-list 'display-buffer-alist
  ;;              '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
  ;;                nil
  ;;                (window-parameters (mode-line-format . none))))
  )


;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  ;; :hook
  ;; (embark-collect-mode . consult-preview-at-point-mode)
  )


(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.

  ;; TODO: move not consult binding out of here
  :general
  (:states 'normal
           "gl" 'consult-line
           "go" 'consult-imenu)
  (my-space-leader
    "y" 'consult-yank-pop
    "f" 'projectile-find-file
    "a" 'consult-ripgrep)
  (:keymaps 'global "C-q" 'consult-buffer)
  (:keymaps 'global "M-f" 'find-file)

  :config
  (setq consult-ripgrep-command
        "rg --smart-case --null --line-buffered --color=always --max-columns=500   --no-heading --line-number . -e ARG OPTS")

  ;; TODO: Preview key does not work
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any)
   consult-buffer consult-ripgrep consult-git-grep consult-grep
   consult--source-bookmark consult--source-recent-file
   consult--source-project-recent-file
   :preview-key (kbd "C-.")
   )

  ;; 2. projectile.el (projectile-project-root)
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-root-function #'projectile-project-root)
  )

(use-package selectrum
  :config
  (selectrum-mode +1)
  (selectrum-prescient-mode +1)
  (prescient-persist-mode +1)

  :general
  (:keymaps 'global "C-c p p" 'projectile-switch-project)
  (:keymaps 'selectrum-minibuffer-map "C-j" #'selectrum-insert-current-candidate)
  ;; (:states 'normal
  ;;          "gl" 'counsel-grep-or-swiper
  ;;          "go" 'counsel-imenu)
  ;; (my-space-leader "y" 'counsel-yank-pop)
  ;; (:keymaps 'global "C-q" 'ivy-switch-buffer)
  ;; (:keymaps 'global "M-x" 'counsel-M-x)
  ;; (:keymaps 'global "M-f" 'counsel-find-file)
  ;; (:keymaps 'global "C-c C-i" 'ivy-resume)

  )


(provide 'init-selectrum-stack)

;;; init-selectrum-stack.el ends here
