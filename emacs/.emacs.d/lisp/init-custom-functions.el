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

(defun copy-buffer-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((buffername (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-name))))
    (when buffername
      (kill-new buffername)
      (message "Copied buffer file name '%s' to the clipboard." buffername))))


(defun mr-json-loads ($string &optional $from $to)
  "Remove the following letters: {a e i o u}.
Got from somewhere on StackOverflow

When called interactively, work on current paragraph or text selection.

When called in lisp code, if ξstring is non-nil, returns a changed string.
If ξstring nil, change the text in the region between positions ξfrom ξto."
  (interactive
   (if (use-region-p)
       (list nil (region-beginning) (region-end))
     (let ((bds (bounds-of-thing-at-point 'paragraph)) )
       (list nil (car bds) (cdr bds)) ) ) )

  (let (workOnStringP inputStr outputStr)
    (setq workOnStringP (if $string t nil))
    (setq inputStr (if workOnStringP $string (buffer-substring-no-properties $from $to)))
    (setq outputStr
          (let ((case-fold-search t))
            (replace-regexp-in-string "\\\\\"" "\"" inputStr))  )

    (if workOnStringP
        outputStr
      (save-excursion
        (delete-region $from $to)
        (goto-char $from)
        (insert outputStr)
        ;; (json-pretty-print $from $to)
        )) )
  )



(provide 'init-custom-functions)
