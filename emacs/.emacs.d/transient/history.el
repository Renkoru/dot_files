((magit-blame
  ("-w"))
 (magit-branch nil)
 (magit-commit nil
               ("--allow-empty")
               ("--no-verify"))
 (magit-fetch nil)
 (magit-gitignore nil)
 (magit-log
  ("-n256" "--graph" "--decorate"))
 (magit-merge nil)
 (magit-patch-apply nil)
 (magit-patch-create nil)
 (magit-pull nil)
 (magit-push nil
             ("--force-with-lease"))
 (magit-rebase nil
               ("--autostash")
               ("--rebase-merges=no-rebase-cousins")
               ("--autostash" "--interactive")
               ("--rebase-merges=no-rebase-cousins" "--autostash")
               ("--rebase-merges=rebase-cousins" "--autostash")
               ("--rebase-merges=no-rebase-cousins" "--interactive"))
 (magit-remote
  ("-f"))
 (magit-reset nil)
 (magit-revert
  ("--edit"))
 (magit-stash nil
              ("--include-untracked"))
 (transient:magit-rebase:--rebase-merges=))
