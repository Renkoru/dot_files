; init-evil.el

(require 'elscreen)
(require 'neotree)
(require 'evil-surround)
; (require 'evil-matchit)
(require 'evil-leader)
(require 'evil-tabs)
(require 'evil)

(require 'rainbow-delimiters)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(global-set-key [(shift f12)] 'highlight-symbol-prev)
; (global-rainbow-delimiters-mode)

(global-evil-surround-mode 1)
; (global-evil-matchit-mode 1)
(global-evil-leader-mode 1)
(global-evil-tabs-mode t)


(evil-mode 1)


;; Evil settings
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(define-key evil-normal-state-map (kbd "M-k") 'drag-stuff-up)
(define-key evil-normal-state-map (kbd "M-j") 'drag-stuff-down)

(define-key evil-normal-state-map (kbd "M-l") 'drag-stuff-right)
(define-key evil-normal-state-map (kbd "M-h") 'drag-stuff-left)

(define-key evil-normal-state-map (kbd "[ SPC") (kbd "ko <escape> j"))
(define-key evil-normal-state-map (kbd "] SPC") (kbd "o <escape> k"))

(define-key evil-normal-state-map (kbd "[ SPC") (kbd "ko <escape> j"))
(define-key evil-normal-state-map (kbd "] SPC") (kbd "o <escape> k"))

(define-key evil-normal-state-map (kbd "gcc") 'evilnc-comment-or-uncomment-lines)
(define-key evil-normal-state-map (kbd "go") 'helm-semantic-or-imenu)
;; (define-key evil-normal-state-map (kbd "gl") 'helm-occur)
(define-key evil-normal-state-map (kbd "gl") 'helm-swoop)

(define-key evil-normal-state-map (kbd "tol") 'linum-mode)
(define-key evil-normal-state-map (kbd "tor") 'rainbow-delimiters-mode)

;; (global-set-key (kbd "M-b") 'helm-projectile-recentf)
;; (global-set-key (kbd "M-g") 'helm-projectile-ag)
(define-key evil-normal-state-map (kbd "SPC s") 'avy-goto-char-2)
;; (define-key evil-normal-state-map (kbd "SPC ss") 'avy-goto-char-2)
;; (define-key evil-normal-state-map (kbd "SPC sh") 'helm-swoop)


(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "w" 'save-buffer
  "q" 'kill-buffer-and-window
  "=" (kbd "C-w =")
  "y" 'helm-show-kill-ring
  "j" 'avy-goto-line
  "k" 'avy-goto-line
  "l" 'avy-goto-char-in-line
  "h" 'avy-goto-char-in-line
  "g" 'magit-status
  "f" 'helm-projectile-find-file
  "r" 'helm-projectile-recentf
  "a" 'helm-projectile-ag
)

; (define-key evil-normal-state-map "c" nil)
; (define-key evil-motion-state-map "cu" 'universal-argument)

(global-set-key [f3] 'neotree-toggle)
(setq neo-theme 'nerd)
(add-hook 'neotree-mode-hook
        (lambda ()
          (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)
          (define-key evil-normal-state-local-map (kbd "O") 'neotree-change-root)
          (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)
          (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
          (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
          (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
          (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-horizontal-split)
          (define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-vertical-split)))


(provide 'init-evil)


;; TODO: to know what is going on here
;; Auto mark config.
(when (require 'auto-mark nil t)
  (setq auto-mark-command-class-alist
        '((anything . anything)
          (goto-line . jump)
          (indent-for-tab-command . ignore)
          (undo . ignore)))
  (setq auto-mark-command-classifiers
        (list (lambda (command)
                (if (and (eq command 'self-insert-command)
                         (eq last-command-char ? ))
                    'ignore))))
  (global-auto-mark-mode 1))

;; get if from
;; http://stackoverflow.com/questions/3393834/how-to-move-forward-and-backward-in-emacs-mark-ring
;; oposite to pop-to-mark-command
(defun unpop-to-mark-command ()
       "Unpop off mark ring. Does nothing if mark ring is empty."
       (interactive)
       (when mark-ring
         (let ((pos (marker-position (car (last mark-ring)))))
           (if (not (= (point) pos))
               (goto-char pos)
             (setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
             (set-marker (mark-marker) pos)
             (setq mark-ring (nbutlast mark-ring))
             (goto-char (marker-position (car (last mark-ring))))))))
;; (defun unpop-to-mark-command ()
;;   "Unpop off mark ring. Does nothing if mark ring is empty."
;;   (interactive)
;;       (when mark-ring
;;         (setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
;;         (set-marker (mark-marker) (car (last mark-ring)) (current-buffer))
;;         (when (null (mark t)) (ding))
;;         (setq mark-ring (nbutlast mark-ring))
;;         (goto-char (marker-position (car (last mark-ring))))))


;; Added from
;; https://www.masteringemacs.org/article/fixing-mark-commands-transient-mark-mode
;; And modified.
;; TODO: What is going on here ????

(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
   Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
  This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (push-mark-no-activate)
  (set-mark-command 1)
  (set-mark-command 1))

;; TODO: Find another mapings?
(define-key evil-normal-state-map (kbd "C-i") 'unpop-to-mark-command)
(define-key evil-normal-state-map (kbd "C-o") 'jump-to-mark)

;; When i visual select some region last mark is resetting.
;; Emacs lost it and i can't jump back to it.  (C-i)
;; This hook add some sacrifice mark to reset it.
(add-hook 'activate-mark-hook 'push-mark-no-activate)
