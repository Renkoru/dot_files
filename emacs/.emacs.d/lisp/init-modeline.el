;;; init-modeline.el --- Appearance settings
;;; Commentary:
;;; Code:


(use-package telephone-line
  :config

  (defface my-red '((t (:foreground "white" :background "indian red"))) "")
  (defface my-blue '((t (:foreground "white" :background "SteelBlue4"))) "")

  (setq telephone-line-faces
        '((red . (my-red . my-red))
          (blue . (my-blue . my-blue))
          (evil . telephone-line-modal-face)
          (modal . telephone-line-modal-face)
          (ryo . telephone-line-ryo-modal-face)
          (accent . (telephone-line-accent-active . telephone-line-accent-inactive))
          (nil . (mode-line . mode-line-inactive))))

  (telephone-line-defsegment mr/telephone-line-projectile-project-name ()
    (ignore-errors (format "[%s]" (projectile-project-name))))

  (telephone-line-defsegment mr/telephone-line-magit-current-branch-segment ()
    (magit-get-current-branch))

  (telephone-line-defsegment mr/telephone-line-flycheck-segment ()
    (replace-regexp-in-string "FlyC" "FC" (flycheck-mode-line-status-text)))


  (telephone-line-defsegment* mr/telephone-line-buffer-status-segment ()
    `(""
      ;; mode-line-client ; Why do I need this?
      mode-line-modified
      ;; mode-line-mule-info ; coding system -- I'm almost always on utf-8. Do I even need this info?
      ;; mode-line-remote ;-- no need to indicate this specially
      ;; mode-line-frame-identification ; -- Do not know what is it for
      ))

  (telephone-line-defsegment mr/telephone-line-buffer-segment ()
    mode-line-buffer-identification)

  (use-package rich-minority
    :config
    (rich-minority-mode 1)
    (setq rm-whitelist '(" emc" " ws"))

    (telephone-line-defsegment mr/telephone-line-rich-minority-segment ()
      (rm--mode-list-as-string-list))
    )

  (setq telephone-line-lhs
        '((red    . (mr/telephone-line-buffer-status-segment))
          (evil   . (telephone-line-evil-tag-segment))
          (blue   . (mr/telephone-line-projectile-project-name))
          (accent . (mr/telephone-line-magit-current-branch-segment
                     telephone-line-process-segment))
          (nil    . (mr/telephone-line-buffer-segment
                     mr/telephone-line-rich-minority-segment))))

  (setq telephone-line-rhs
        '((nil    . (telephone-line-misc-info-segment
                     mr/telephone-line-flycheck-segment))
          (accent . (telephone-line-position-segment))
          (evil   . (telephone-line-major-mode-segment))))

  (setq telephone-line-primary-left-separator 'telephone-line-cubed-left
        telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
        telephone-line-primary-right-separator 'telephone-line-cubed-right
        telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)

  (setq
   ;; telephone-line-height 24
   telephone-line-evil-use-short-tag t)

  (telephone-line-mode t))


(provide 'init-modeline)

;;; init-modeline.el ends here
