;;; init-modeline.el --- Appearance settings
;;; Commentary:
;;; Code:

(defun mr/truncate-file-path (path max-length)
  "Cuts file PATH from the end to MAX-LENGTH."

  (let* ((file-paths (reverse (split-string path "/")))
         (total-parts (length file-paths))
         (result (pop file-paths))
         (next-length (+ (length result) (length (car file-paths)))))

    (while (and (< next-length max-length) file-paths)
      (setq result (concat (pop file-paths) "/" result))
      (setq next-length (+ (length result) (length (car file-paths)))))
    result
    )
  )

(defun mr/get-filename-with-directory ()
  (interactive "P")

  (if buffer-file-name
      (let ((proj-path (projectile-project-root))
            (path-to-truncate buffer-file-name))

        (if proj-path
            (setq path-to-truncate
                  (replace-regexp-in-string proj-path "" path-to-truncate))
            )

        (mr/truncate-file-path path-to-truncate 50)
        )

    mode-line-buffer-identification
    )
  )

(defun mr/get-git-branch-name ()
  ;; (truncate-string-to-width (magit-get-current-branch) 10 0 nil ">")
  (let ((branch-name (magit-get-current-branch))
        (max-name-length 30))
    (if branch-name
        (s-left max-name-length branch-name)
      nil
      )
    ))

(defun mr/acronym (text)
  (upcase
   (mapconcat (lambda (x) (substring x 0 1))
              (s-split "-" text)
              "")
   ))

(use-package telephone-line
  :config

  (defface my-red '((t (:foreground "white" :background "indian red"))) "")
  (defface my-green '((t (:foreground "grey39" :background "LightGreen"))) "")
  (defface my-grey '((t (:foreground "grey39" :background "LightGrey"))) "")
  (defface my-blue '((t (:foreground "grey32" :background "AliceBlue"))) "")


  (setq telephone-line-faces
        '((red . (my-red . my-red))
          (green . (my-green . mode-line-inactive))
          (grey . (my-grey . mode-line-inactive))
          (blue . (my-blue . my-blue))
          (evil . telephone-line-modal-face)
          (modal . telephone-line-modal-face)
          (ryo . telephone-line-ryo-modal-face)
          (accent . (telephone-line-accent-active . telephone-line-accent-inactive))
          (nil . (mode-line . mode-line-inactive))))

  (telephone-line-defsegment mr/telephone-line-projectile-project-name ()
    (let ((project-name (projectile-project-name)))
      (if (and
           (> (string-width project-name) 10)
           (cl-search "-" project-name))
          (mr/acronym project-name)
        project-name)
      )
    )

  (telephone-line-defsegment mr/telephone-line-magit-current-branch-segment ()
    (mr/get-git-branch-name))

  (telephone-line-defsegment mr/telephone-line-anzu-segment ()
    (anzu--update-mode-line))

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
    ;; mode-line-buffer-identification ; replaced by my function
    (mr/get-filename-with-directory)
    )

  (telephone-line-defsegment mr/telephone-line-process-segment ()
    ;; telephone-line-process-segment; replaced by my function
   (if mode-line-process
       (concat "" mode-line-process)
       ;; (concat "(wip)" mode-line-process)
     nil))


  (use-package rich-minority
    :config
    (rich-minority-mode 1)
    (setq rm-whitelist '(" emc" " ws" " !EML!"))

    (telephone-line-defsegment mr/telephone-line-rich-minority-segment ()
      (rm--mode-list-as-string-list))
    )

  (setq telephone-line-lhs
        '((red    . (mr/telephone-line-anzu-segment
                     mr/telephone-line-buffer-status-segment
                     mr/telephone-line-process-segment))
          (green   . (mr/telephone-line-buffer-segment))
          (blue . (telephone-line-position-segment))
          ;; (evil   . (telephone-line-evil-tag-segment))
          (blue    . (mr/telephone-line-flycheck-segment))
          ))

  (setq telephone-line-rhs
        '((blue    . (telephone-line-misc-info-segment)) ;; just for the color
          (green . (mr/telephone-line-projectile-project-name
                    mr/telephone-line-magit-current-branch-segment))
          (blue   . (mr/telephone-line-rich-minority-segment
                     telephone-line-major-mode-segment))))

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
