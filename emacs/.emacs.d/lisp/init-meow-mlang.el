;;; init-meow-mlang.el --- Meow multiple language support (migrated from evil-mlang)
;;; Commentary:
;;; Adapted from init-evil-mlang.el to work with meow hooks.
;;; Switches keyboard layout to English when entering normal mode,
;;; restores previous layout when entering insert mode.
;;; Code:

;; (setq keyboard-device "at-translated-set-2-keyboard")
(setq keyboard-device "aone-varmilo-keyboard")

(defun mr-get-kblayout-command ()
  "Command to get current keyboard layout."
  (s-replace "KEYBOARD-DEVICE" keyboard-device
             "hyprctl devices -j | jq -r '.keyboards[] | select(.name == \"KEYBOARD-DEVICE\") | .active_keymap' | head -n1 | sed -e 's/English\\ (US)/0/g' | sed -e 's/Russian/1/g'"))

(defun mr-set-kblayout-command ()
  "Command to set current keyboard layout."
  (s-replace "KEYBOARD-DEVICE" keyboard-device
             "hyprctl switchxkblayout KEYBOARD-DEVICE"))

(setq mr-default-kblayout "0")
(setq mr-current-kblayout mr-default-kblayout)

(defun meow-mlang-enter-insert-handler ()
  "Restore previous layout when entering insert mode."
  (shell-command (concat (mr-set-kblayout-command) " " mr-current-kblayout)))

(defun meow-mlang-exit-insert-handler ()
  "Save current layout and switch to English when leaving insert mode."
  (setq mr-current-kblayout (replace-regexp-in-string "\n$" ""
                                                      (shell-command-to-string (mr-get-kblayout-command))))
  (shell-command (concat (mr-set-kblayout-command) " " mr-default-kblayout)))

(define-minor-mode meow-mlang-mode
  "Adds needed hooks for keyboard layout switching with meow."
  :lighter " !EML!"

  (if meow-mlang-mode
      (progn
        (add-hook 'meow-insert-enter-hook 'meow-mlang-enter-insert-handler)
        (add-hook 'meow-insert-exit-hook 'meow-mlang-exit-insert-handler))
    (remove-hook 'meow-insert-enter-hook 'meow-mlang-enter-insert-handler)
    (remove-hook 'meow-insert-exit-hook 'meow-mlang-exit-insert-handler)))

(provide 'init-meow-mlang)
;;; init-meow-mlang.el ends here

;; [meow-migration] Original evil-mlang.el is preserved in init-evil-mlang.el (commented out).
;; Key changes:
;; - evil-insert-state-entry-hook → meow-insert-enter-hook
;; - evil-insert-state-exit-hook → meow-insert-exit-hook
;; - evil-mlang-mode → meow-mlang-mode
;; - evil-mlang-enter-insert-handler → meow-mlang-enter-insert-handler
;; - evil-mlang-enter-leave-handler → meow-mlang-exit-insert-handler
;; Note: meow hooks are insert-enter/exit (not state-entry/exit).
