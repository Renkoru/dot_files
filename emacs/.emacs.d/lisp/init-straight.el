;;; init-straight.el --- straight settings
;;; Commentary:
;;; Code:

;; setup straight.el
(let ((bootstrap-file (concat user-emacs-directory "straight/bootstrap.el"))
      (bootstrap-version 2))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(straight-use-package 'use-package)

(straight-use-package 'org)

(straight-use-package 'use-package)
(straight-use-package 'avy)
(straight-use-package 'all-the-icons)
(straight-use-package 'neotree)
(straight-use-package 'projectile)
(straight-use-package 'drag-stuff)
(straight-use-package 'beacon)
(straight-use-package 'yasnippet)
(straight-use-package 'ace-window)
(straight-use-package 'dumb-jump)
(straight-use-package 'editorconfig)
(straight-use-package 'wgrep)
(straight-use-package 'restclient)
(straight-use-package 'jump-tree)

;; (straight-use-package 'helm)
;; (straight-use-package 'helm-ag)
;; (straight-use-package 'helm-swoop)

(straight-use-package 'smex) ;; ranking and remembering M-x
(straight-use-package 'hydra) ;; should be installed before ivy
(straight-use-package 'ivy) ;; not working with cask for some reason
(straight-use-package 'ivy-hydra)
(straight-use-package 'counsel-projectile)

(straight-use-package 'flyspell)
(straight-use-package 'flyspell-correct)
(straight-use-package 'flyspell-correct-ivy)
(straight-use-package 'flycheck)
(straight-use-package 'flycheck-cask)

(straight-use-package 'company)
(straight-use-package 'company-flx)
(straight-use-package 'company-quickhelp)
(straight-use-package 'company-statistics)
(straight-use-package 'company-web)
(straight-use-package 'company-tern)
(straight-use-package 'company-anaconda)

(straight-use-package 'magit)
(straight-use-package 'git-gutter)
(straight-use-package 'git-timemachine)

(straight-use-package 'web-mode)
(straight-use-package 'markdown-mode)
(straight-use-package 'scss-mode)
(straight-use-package 'yaml-mode)
(straight-use-package 'json-mode)
(straight-use-package 'writeroom-mode)
(straight-use-package 'emmet-mode)

(straight-use-package 'rainbow-mode)
(straight-use-package 'rainbow-delimiters)

(straight-use-package 'evil)
(straight-use-package 'evil-leader)
(straight-use-package 'evil-surround)
(straight-use-package 'evil-visualstar)
(straight-use-package 'evil-mc)
(straight-use-package 'evil-matchit)
(straight-use-package 'vimish-fold)
(straight-use-package 'evil-nerd-commenter)
(straight-use-package 'evil-anzu) ;; displays current match and total matches.
(straight-use-package 'evil-goggles)

(straight-use-package 'python-mode)
(straight-use-package 'pyenv-mode)
(straight-use-package 'elpy)
(straight-use-package 'sphinx-doc)
(straight-use-package 'py-yapf)

(straight-use-package 'tern)
(straight-use-package 'js2-mode)
(straight-use-package 'js2-refactor)
(straight-use-package 'rjsx-mode)
(straight-use-package 'js-doc)

(straight-use-package 'alchemist)

(straight-use-package 'leuven-theme)
(straight-use-package 'ample-theme)
(straight-use-package 'color-theme-sanityinc-tomorrow)
(straight-use-package 'solarized-theme)
(straight-use-package 'material-theme)
(straight-use-package 'rich-minority)
(straight-use-package 'smart-mode-line)
(straight-use-package 'nyan-mode)
(straight-use-package 'highlight-symbol)

(straight-use-package 'bind-key)
(straight-use-package 'dash)
(straight-use-package 'exec-path-from-shell)
(straight-use-package 'expand-region)
(straight-use-package 'htmlize)
(straight-use-package 'idle-highlight-mode)
(straight-use-package 'pallet)
(straight-use-package 'popwin)
(straight-use-package 'prodigy)

(straight-use-package 'f)
(straight-use-package 's)
(straight-use-package 'let-alist)



(provide 'init-straight)
;;; init-straight.el ends here
