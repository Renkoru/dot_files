;;; Compiled snippets and support files for `js-ts-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'js-ts-mode
                     '(("vreq" "var $1 = require('$0');" "var require" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/var_require" nil nil)
                       ("us" "'use strict';$0" "use strict" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/use strict" "direct-keybinding" nil)
                       ("scl" "console.log($1);$0" "simple console log" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/simple_console_log" "direct-keybinding" nil)
                       ("rc" "// $1\n// --mrurenko `(format-time-string \"%Y-%m-%d\")`$0" "review-comment" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/review-comment" nil nil)
                       ("req" "require('$0');" "require" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/require" nil nil)
                       ("oa" "Object.assign({}$1, $2, {$3});$0" "object assign" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/object assign" nil nil)
                       ("ofn" "$1: function ($2) {\n  $0\n}," "in object function" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/in object function" "direct-keybinding" nil)
                       ("oefn" "$1: function (evt$2) {\n  evt.preventDefault();$0\n},\n" "in object event function" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/in object event function" "direct-keybinding" nil)
                       ("imf" "import $1 from '$2';" "import_from" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/import_from" nil nil)
                       ("if" "if ($1) {\n$0\n}" "if" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/if" nil nil)
                       ("dit" "describe('$1', () => {\n  it('$2', () => {\n    $0expect(true).toEqual(false);\n  });\n});\n" "describe-it" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/describe-it" nil nil)
                       ("caf" "const $1 = ($2) => ($3);$0" "const arrow function" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/const_arrow_function" nil nil)
                       ("jcl" "console.log('--- > $1: %s', JSON.stringify($2, null, 2));$0" "Console log Json Stringify" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/console_log_json_2" "direct-keybinding" nil)
                       (nil "console.log('--- > $0: %s', JSON.stringify(`yas/selected-text`, null, 2));" "json" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/console_log_json" "M-c k" nil)
                       ("cl" "console.log('\\n>>>>>> $1');\nconsole.log($0);\nconsole.log('<<<<<< end block $1');" "console_log" nil nil nil "/home/mrurenko/.emacs.d/snippets/js-ts-mode/console_log" "direct-keybinding" nil)))


;;; Do not edit! File generated at Sat Nov 23 15:16:23 2024
