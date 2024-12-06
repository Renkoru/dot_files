;;; init-evil-mlang.el --- Evil multiple language support
;;; Commentary:

;; >>> Source https://gist.github.com/ghost355/a967417bb7e826e833d4
;; Adapted to my system setup
;; Multiple language setup
;; This code helps to work (Emacs + Evil mode) in multilanguage mode
;; You need to install 'xkb-switch'
;; In thу Terminal # issw   show you namу of the current layout

;;; Code:


;; (setq mr-get-kblayout-command "xkb-switch -p | tr -d '\n'")
;; from command hyprctl devices -j
;; (setq keyboard-device "aone-varmilo-keyboard-2")
;; (setq keyboard-device "hid-keyboard-hid-keyboard")
(setq keyboard-device "at-translated-set-2-keyboard")

;; (setq keyboard-device "at-translated-set-2-keyboard")
;; (setq keyboard-device "at-translated-set-2-keyboard")
;; (setq mr-get-kblayout-command (s-replace "KEYBOARD-DEVICE" keyboard-device "hyprctl devices -j | jq -r '.keyboards[] | select(.name == \"KEYBOARD-DEVICE\") | .active_keymap' | head -n1 | sed -e 's/English\\ (US)/0/g' | sed -e 's/Russian/1/g'"))

(defun mr-get-kblayout-command ()
  "Command to get current keyboard layout"
  (s-replace "KEYBOARD-DEVICE" keyboard-device "hyprctl devices -j | jq -r '.keyboards[] | select(.name == \"KEYBOARD-DEVICE\") | .active_keymap' | head -n1 | sed -e 's/English\\ (US)/0/g' | sed -e 's/Russian/1/g'")
  )

;; (setq mr-set-kblayout-command "xkb-switch -s")
;; (setq mr-set-kblayout-command (s-replace "KEYBOARD-DEVICE" keyboard-device "hyprctl switchxkblayout KEYBOARD-DEVICE"))

(defun mr-set-kblayout-command ()
  "Command to set current keyboard layout"
  (s-replace "KEYBOARD-DEVICE" keyboard-device "hyprctl switchxkblayout KEYBOARD-DEVICE")
  )
;; (setq mr-ru-lang_source "setxkbmap -layout ru,us")
;; (setq mr-default-kblayout "us")
(setq mr-default-kblayout "0")
(setq mr-current-kblayout mr-default-kblayout)

(defun evil-mlang-enter-insert-handler ()
  "What we do when enter insert mode."
  (shell-command (concat (mr-set-kblayout-command) " " mr-current-kblayout)))

(defun evil-mlang-enter-leave-handler ()
  "What we do when enter normal mod."
  (setq mr-current-kblayout (replace-regexp-in-string "\n$" ""
                                                      (shell-command-to-string (mr-get-kblayout-command))))
  (shell-command (concat (mr-set-kblayout-command) " " mr-default-kblayout)))

(define-minor-mode evil-mlang-mode
  "Adds needed hooks."
  :lighter " !EML!"

  (if evil-mlang-mode
      (progn
        (add-hook 'evil-insert-state-entry-hook 'evil-mlang-enter-insert-handler)
        (add-hook 'evil-insert-state-exit-hook 'evil-mlang-enter-leave-handler))
    (remove-hook 'evil-insert-state-entry-hook 'evil-mlang-enter-insert-handler)
    (remove-hook 'evil-insert-state-exit-hook 'evil-mlang-enter-leave-handler)))

;; (add-hook 'evil-replace-state-entry-hook                         ;what we do when enter insert mode
;;           (lambda ()
;;             ;; (shell-command (concat "issw " lang_source))))      ;
;;             (shell-command (concat mr-set-kblayout-command " " mr-current-kblayout))))      ;

;; (add-hook 'evil-replace-state-exit-hook                          ;what we do when enter normal mode
;;           (lambda ()
;;             (setq mr-current-kblayout (shell-command-to-string mr-get-kblayout-command))
;;             (shell-command (concat mr-set-kblayout-command " " mr-default-kblayout))))      ;

(provide 'init-evil-mlang)
;;; init-evil-mlang.el ends here
