abbr --add lsa ls -la
abbr --add pupd sudo pacman -Suy
abbr --add yupd yay -Suya
abbr --add kbd /bin/bash /home/mrurenko/dot_files/scripts/keyboard.sh
abbr --add amt xinput set-prop \"rdashevsky work trackpad\" 285 1 and xinput set-prop \"rdashevsky work trackpad\" 296 0.3 and libinput-gestures-setup restart


# Docker abbrs
abbr --add dc docker-compose
abbr --add dcu docker-compose up -d
abbr --add dcs docker-compose stop
abbr --add dcd docker-compose down
abbr --add dps docker-compose ps
abbr --add dlog docker-compose log

set -x SSH_AUTH_SOCK "/run/user/1000/ssh-agent.socket"
set -x WORKON_HOME $HOME/.local/share/virtualenvs

# After installation of Pyenv
set -x PATH "/home/mrurenko/.pyenv/bin" $PATH
# status --is-interactive; and . (pyenv init -|psub)
# status --is-interactive; and . (pyenv virtualenv-init -|psub)

set -x PATH "$HOME/.poetry/bin" $PATH

set -x PATH "$HOME/.local/bin" $PATH


# if test "$XDG_VTNR" -le 2
#     tbsm
# end
source ~/.asdf/asdf.fish

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# copy next to
# eval /opt/anaconda/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
