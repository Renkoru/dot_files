; init-custom-functions.el
;; My custom functions


;; Evaluate the new bit of code in Emacs
;; (maybe by using C-M-x somewhere in the body of the function definition)
;; and invoke the command with M-x copy-file-name-to-clipboard.

;; This command is part of Prelude(it’s named prelude-copy-file-name-to-clipboard there).
(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))



(provide 'init-custom-functions)
