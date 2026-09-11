;;; init-meow.el --- Meow modal editing configuration (migrated from evil)
;;; Commentary:
;;; Replaces init-evil.el.  Meow blends modal editing into Emacs with
;;; minimal interference with standard Emacs keybindings.
;;; Uses the reference QWERTY layout with custom overrides for the
;;; user's established workflows (undo, commenting, leader keys, etc.).
;;; Code:


;; ── Custom leader keymap ──────────────────────────────────────────
;; We create our own keymap for SPC-prefix dispatch instead of using
;; the default mode-specific-map (C-c), so SPC and C-c stay separate.
(defvar my-meow-leader-map (make-sparse-keymap)
  "Custom leader keymap for meow's SPC-prefix dispatch.")

;; ── Meow core + QWERTY layout ─────────────────────────────────────

(use-package meow
  :demand t

  :config
  ;; ═══════════════════════════════════════════════════════════════
  ;;  meow-setup — reference QWERTY layout from meow's docs,
  ;;  adapted to preserve the user's custom keybindings.
  ;; ═══════════════════════════════════════════════════════════════
  (setq meow-use-clipboard t)

  (defun meow-setup ()
    "Configure meow keybindings (QWERTY layout, customised)."
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)

    ;; ── Motion state (for special buffers like help-mode) ────
    (meow-motion-define-key
     '("j" . meow-next)
     '("k" . meow-prev)
     '("<escape>" . ignore))

    ;; ── Leader keymap digit arguments & help ─────────────────
    ;; Bind into our custom leader map (not mode-specific-map).
    ;; We need to swap the leader entry in meow-keymap-alist first.
    (meow-leader-define-key
     '("1" . meow-digit-argument)
     '("2" . meow-digit-argument)
     '("3" . meow-digit-argument)
     '("4" . meow-digit-argument)
     '("5" . meow-digit-argument)
     '("6" . meow-digit-argument)
     '("7" . meow-digit-argument)
     '("8" . meow-digit-argument)
     '("9" . meow-digit-argument)
     '("/" . meow-keypad-describe-key)
     '("?" . meow-cheatsheet))

    ;; ── Normal state — main editing keybindings ─────────────
    (meow-normal-define-key
     ;; -- Expand (number prefix) --
     '("9" . meow-expand-9)
     '("8" . meow-expand-8)
     '("7" . meow-expand-7)
     '("6" . meow-expand-6)
     '("5" . meow-expand-5)
     '("4" . meow-expand-4)
     '("3" . meow-expand-3)
     '("2" . meow-expand-2)
     '("1" . meow-expand-1)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     ;; -- Thing manipulation --
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     ;; -- Insert / open --
     '("a" . meow-append)
     '("A" . meow-open-below)
     '("i" . meow-insert)
     '("I" . meow-open-above)
     ;; -- Word / symbol movement --
     '("B" . meow-back-word)
     ;; '("b" . backward-word)
     '("b" . meow-back-symbol)
     '("W" . meow-next-word)
     '("w" . meow-next-symbol)
     '("M" . meow-mark-word)
     '("m" . meow-mark-symbol)
     ;; -- Character / line movement (hjkl) --
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("j" . meow-next)
     '("J" . meow-next-expand)
     '("k" . meow-prev)
     '("K" . meow-prev-expand)
     '("l" . meow-right)
     ;; '("L" . meow-right-expand)
     ;; -- Searching --
     '("n" . meow-search)
     '("f" . meow-find)
     '("t" . meow-till)
     ;; -- Editing commands --
     '("c" . meow-change)
     '("x" . meow-delete)
     '("D" . meow-backward-delete)
     '("p" . meow-yank)
     '("r" . meow-replace)
     '("s" . meow-kill)
     '("L" . meow-line)
     '(":" . meow-goto-line)
     '("$" . move-end-of-line)
     '("0" . beginning-of-line)
     ;; '("m" . meow-join)
     ;; -- Block (matching parens etc.) --
     '("o" . meow-block)
     '("O" . meow-to-block)
     ;; -- Selection --
     ;; '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("R" . meow-swap-grab)
     '("Y" . meow-sync-grab)
     '("z" . meow-pop-selection)
     '("v" . meow-visit)
     ;; -- Undo / save / quit --
     '("y" . meow-save)
     '("u" . meow-undo)
     '("U" . meow-undo-in-selection)
     ;; '("q" . meow-quit)
     ;; -- Repeat --
     '("'" . repeat)
     ;; -- Escape passthrough --
     '("<escape>" . meow-cancel-selection))
    )

  ;; ── Replace leader in meow-keymap-alist ──────────────────
  ;; so meow-leader-define-key and keypad dispatch both use our map.
  (setf (alist-get 'leader meow-keymap-alist) my-meow-leader-map)

  ;; ── Call setup (populates keybindings) ────────────────────
  (meow-setup)

  ;; ═══════════════════════════════════════════════════════════════
  ;;  User's custom overrides (applied after meow-setup)
  ;; ═══════════════════════════════════════════════════════════════

  ;; ── Undo: use undo-fu instead of meow-undo ────────────────
  ;; (define-key meow-normal-state-keymap "u" 'undo-fu-only-undo)
  ;; (define-key meow-normal-state-keymap "\C-r" 'undo-fu-only-redo)

  ;; ── g prefix: keep as prefix for commenting, consult, etc. ──
  ;; Remove meow-setup's single-key 'g' binding so 'gc', 'gl', 'go' work.
  (define-key meow-normal-state-keymap "g" nil)
  (define-key meow-normal-state-keymap (kbd "g x") 'meow-swap-grab)
  (define-key meow-normal-state-keymap (kbd "g d") 'xref-find-definitions)
  (with-eval-after-load 'evil-nerd-commenter
    (define-key meow-normal-state-keymap (kbd "g c c") 'evilnc-comment-or-uncomment-lines))

  ;; ── % for block (alternative to 'o') ──────────────────────
  (define-key meow-normal-state-keymap (kbd "%") 'meow-block)

  ;; ── Window navigation (C-hjkl) ─────────────────────────────
  (meow-define-keys 'normal
    '("C-h" . windmove-left)
    '("C-j" . windmove-down)
    '("C-k" . windmove-up)
    '("C-l" . windmove-right)
    '("C-a" . beginning-of-line)
    )

  ;; ── Insert mode: C-e → end-of-line ───────────────────────
  (meow-define-keys 'insert
    '("C-e" . end-of-line))

  ;; ── Highlight symbol navigation ───────────────────────────
  ;; M-n/M-p used instead of C-n/C-p because meow's internal
  ;; line movement (j/k → meow-next/prev) simulates C-n/C-p
  ;; and would trigger highlight-symbol instead of moving lines.
  ;; not needed anymore, using "W" to mark and "n" to navigate
  ;; (define-key meow-normal-state-keymap (kbd "M-n") 'mr/highlight-symbol-next)
  ;; (define-key meow-normal-state-keymap (kbd "M-p") 'mr/highlight-symbol-prev)

  ;; ── Org mode: TAB in normal state ───────────────────────
  ;; TAB (C-i) is bound to mr/jump-forward-smart below.
  ;; In org-mode it falls back to org-cycle; elsewhere it jumps forward.
  ;; No separate TAB binding needed here.

  ;; ── Cursor shapes for different modes ─────────────────────
  (setq meow-normal-cursor '("ForestGreen" box))
  (setq meow-insert-cursor '("#8b0000" bar))
  (setq meow-beacon-cursor '("orange" box))
  (setq meow-motion-cursor '("#8b0000" hollow))
  (setq meow-keypad-cursor '("orange" box))

  ;; ── Enable meow globally ──────────────────────────────────
  (meow-global-mode 1))


;; ── SPC Leader Key Bindings ───────────────────────────────────────
;; Populated after meow loads.  meow-keypad dispatches unrecognised
;; keys to the leader keymap (which now points to my-meow-leader-map).
;; my-meow-leader-map is populated below with define-key.

(with-eval-after-load 'meow
  (define-key my-meow-leader-map (kbd "u") 'scroll-down-command)
  (define-key my-meow-leader-map (kbd "d") 'scroll-up-command)

  ;; Core editing
  (define-key my-meow-leader-map (kbd "w w") 'save-buffer)
  (define-key my-meow-leader-map (kbd "w a") 'save-some-buffers)

  (define-key my-meow-leader-map (kbd "=") 'balance-windows)

  ;; File / project navigation
  (define-key my-meow-leader-map (kbd "f") 'projectile-find-file)
  (define-key my-meow-leader-map (kbd "a") 'consult-ripgrep)
  (define-key my-meow-leader-map (kbd "y") 'consult-yank-pop)

  ;; Git
  (define-key my-meow-leader-map (kbd "v") 'magit-status)
  (define-key my-meow-leader-map (kbd "p g") 'hydra-git-toggle/body)

  ;; Toggles
  ;; (define-key my-meow-leader-map (kbd "p t") 'hydra-toggle/body)
  ;; (define-key my-meow-leader-map (kbd "p r") 'hydra-resize/body)
  ;; (define-key my-meow-leader-map (kbd "p c n") 'hydra-numbers/body)
  ;; (define-key my-meow-leader-map (kbd "p c z") 'hydra-fold/body)

  ;; Avy jumps
  (define-key my-meow-leader-map (kbd "j") 'avy-goto-line-below)
  (define-key my-meow-leader-map (kbd "k") 'avy-goto-line-above)
  (define-key my-meow-leader-map (kbd "l") 'avy-goto-char-in-line)
  (define-key my-meow-leader-map (kbd "s") 'avy-goto-char-timer)

  ;; Expand region
  (define-key my-meow-leader-map (kbd "e") 'er/expand-region)

  ;; Highlight symbol
  (define-key my-meow-leader-map (kbd "p h") 'symbol-overlay-put))

;; ── Deferred leader bindings ─────────────────────────────────────

;; (with-eval-after-load 'init-appearance
;;   (define-key my-meow-leader-map (kbd "c f") 'hydra-zoom/body))


;; ── Packages that need rebinding ──────────────────────────────────

(use-package evil-nerd-commenter)

;; (use-package evil-numbers
;;   :ensure (:host github :repo "cofi/evil-numbers")
;;   :config
;;   (defhydra hydra-numbers (:color pink)
;;     "
;;       change numbers
;;        _i_ increase
;;        _d_ decrease
;;       "
;;     ("i" evil-numbers/inc-at-pt "increase")
;;     ("d" evil-numbers/dec-at-pt "decrease")
;;     ("q" nil "quit")))

(use-package embrace
  :after meow
  :config
  (define-key my-meow-leader-map (kbd "p e a") 'embrace-add)
  (define-key my-meow-leader-map (kbd "p e d") 'embrace-delete)
  (define-key my-meow-leader-map (kbd "p e c") 'embrace-change)
  )


(use-package expand-region)


;; ── Jump history (Vim-like C-o / C-i) ──────────────────────────
;; We use better-jumper for a Vim-style jumplist and advise
;; navigation commands to push the current location before jumping.

(defun mr/jump-forward-smart ()
  "Jump forward in the jump list.
In org-mode, cycle heading visibility instead (because C-i and TAB
share the same key event in Emacs)."
  (interactive)
  (if (derived-mode-p 'org-mode)
      (call-interactively 'org-cycle)
    (call-interactively 'better-jumper-jump-forward)))

(use-package better-jumper
  :config
  ;; Use per-window jump list (matches Vim's default behavior)
  (setq better-jumper-context 'window
        better-jumper-use-evil-jump-advice nil)  ; no evil, we use meow
  (better-jumper-mode +1)

  ;; ── Helper to push position before a jump ────────────────
  (defun mr/better-jumper--push-before-jump (&rest _)
    "Push current location to better-jumper before a jump command."
    (better-jumper-set-jump))

  ;; ══════════════════════════════════════════════════════════════
  ;;  Advise navigation commands to automatically record jumps.
  ;;  Each :before advice pushes the *current* location onto the
  ;;  jumplist just before the command moves point elsewhere.
  ;; ══════════════════════════════════════════════════════════════

  ;; xref: g d (goto-def), M-, (go-back), find-references
  (advice-add 'xref-find-definitions :before #'mr/better-jumper--push-before-jump)
  (advice-add 'xref-go-back          :before #'mr/better-jumper--push-before-jump)
  (advice-add 'xref-find-references  :before #'mr/better-jumper--push-before-jump)

  ;; consult: ALL consult jumps (line, imenu, ripgrep, outline, …)
  ;; consult--jump is the single entry point that every consult
  ;; source calls after you pick a candidate.  Advising it once
  ;; covers g l, g o, SPC a, and anything else consult-powered.
  (with-eval-after-load 'consult
    (advice-add 'consult--jump :before #'mr/better-jumper--push-before-jump))

  ;; avy: ALL avy jumps (char, line, word, timer, …)
  ;; avy-action-goto is the default action when a candidate is chosen.
  ;; Covers SPC j, SPC k, SPC l, SPC s and any other avy-goto-*.
  (with-eval-after-load 'avy
    (advice-add 'avy-action-goto :before #'mr/better-jumper--push-before-jump))

  ;; meow: / search and n/N continuation jumps
  (with-eval-after-load 'meow
    (advice-add 'meow-search :before #'mr/better-jumper--push-before-jump)

    ;; ── Key bindings (normal state) ────────────────────────
    ;; C-o → jump backward (like Vim)
    (define-key meow-normal-state-keymap (kbd "C-o") #'better-jumper-jump-backward)

    ;; C-i → jump forward (like Vim).
    ;; NOTE: C-i and TAB are the same key event in Emacs.
    ;; We use mr/jump-forward-smart so org-mode users still get
    ;; org-cycle on TAB, while everywhere else it jumps forward.
    (define-key meow-normal-state-keymap (kbd "C-i") #'mr/jump-forward-smart))

  ;; dumb-jump: M-d (goto-definition alternative)
  (with-eval-after-load 'dumb-jump
    (advice-add 'dumb-jump-go :before #'mr/better-jumper--push-before-jump))

  ;; Optional — uncomment if you want file/window switches recorded too:
  ;; (with-eval-after-load 'ace-window
  ;;   (advice-add 'ace-window :before #'mr/better-jumper--push-before-jump))
  ;; (advice-add 'projectile-find-file :before #'mr/better-jumper--push-before-jump)
  ;; (advice-add 'magit-status :before #'mr/better-jumper--push-before-jump)
  )

(use-package repeat-fu
  ;; :commands (repeat-fu-mode repeat-fu-execute)

  :config
  (require 'cl-lib)
  (setq repeat-fu-preset 'meow)
  ;; (repeat-fu-declare 'my-save-command :skip t :skip-change t)

  :hook
  ((meow-mode)
   .
   (lambda ()
     (when (and (not (minibufferp)) (not (derived-mode-p 'special-mode)))
       (repeat-fu-mode)
       (define-key meow-normal-state-keymap (kbd "C-'") 'repeat-fu-execute)
       (define-key meow-insert-state-keymap (kbd "C-'") 'repeat-fu-execute)))))



;; ── Dired / Dirvish keybindings (was evil-define-key) ─────────────

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "h") 'dired-up-directory)
  (define-key dired-mode-map (kbd "l") 'dired-find-file))

(with-eval-after-load 'dirvish
  (define-key dirvish-mode-map (kbd "TAB") 'dirvish-subtree-toggle))

(provide 'init-meow)
;;; init-meow.el ends here
