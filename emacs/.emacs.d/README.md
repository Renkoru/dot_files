* Third-party dependencies

** Javascript
   - *jshint* for flycheck 'npm install -g jshint'

** Python
   - pyenv TODO: add commands to install pyenv on ubuntu or smth


* General

** To look at:
- !https://github.com/emacs-lsp/lsp-mode [UNDER DEVELOPMENT] good integration with code (Python, ...)?
- https://github.com/Alexander-Miller/treemacs replacement of NeoTree package
- https://github.com/Wilfred/helpful show emacs helps
- https://github.com/wasamasa/shackle to force popup windows opens where you want
- https://github.com/bodil/ohai-emacs good place to look at emacs setup
- https://github.com/hlissner/.emacs.d good place to look at evil/vim setup for emacs
- https://github.com/hlissner/evil-multiedit multiple cursors if evil-mc not enougth
- [[https://github.com/Lindydancer/face-explorer][Face explorer]] some usefull functions to work with faces

** Already using, but new in it
- https://github.com/pashky/restclient.el rest client. Try it! )
- writeroom-mode

;; ecukes (https://github.com/ecukes/ecukes)
;; 'wgrep' for refactoring  (https://github.com/mhayashi1120/Emacs-wgrep)
;; 'indent-tools' for working with indent based formats (https://gitlab.com/emacs-stuff/indent-tools)

- Navigate backward/forward. Explore/use/rewrite:
  * https://github.com/rolandwalker/back-button Rewrite or use it for navigation forward/backward
  * https://gist.github.com/kozikow/bd404c82647db3f97ade1d91018e1a87 Backbutton gist for evil too

### TODO:
;; Use other suggestor for https://github.com/jacktasia/dumb-jump or use ivy (contribute?)

;; You need to install Cask (http://cask.readthedocs.io/) on your system
;; And do: cask install


* Cheatsheet

Disable evil mode

* TODOs

** To try
   - [[http://langserver.org/ ][LSP]] ([[https://github.com/emacs-lsp/lsp-mode][Emacs package]]):
     - [[https://github.com/palantir/python-language-server][Python]]
     - [[https://github.com/sourcegraph/javascript-typescript-langserver][Javascript]]
   - [[https://github.com/skeeto/elfeed][Rss|Atom feed package]]

** Emacs things to learn
   - [ ] Help functions in emacs
     - [ ] Make a list of all kinds of 'help' that emacs has
     - [ ] *C-h C-h* 'help-to-help'
     - [ ] *C-h k* help about command

** Important:
   - Nothing yet...

### Some scripts in work
(let (
    (myvar (split-string (magit-get-current-branch) "-"))
)
 (message (concat (nth 0 myvar) "-" (nth 1 myvar)))
)
