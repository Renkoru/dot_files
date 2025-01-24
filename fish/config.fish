function fish_greeting
    artprint --random -t "$(misfortune -s -L 3)"
end

abbr --add lsa eza -la --icons=auto
abbr --add pupd sudo pacman -Suy
abbr --add yupd yay -Suya


# Docker abbrs
abbr --add dc docker compose
abbr --add dcu docker compose up -d
abbr --add dcs docker compose stop
abbr --add dcd docker compose down
abbr --add dps docker compose ps
abbr --add dlog docker compose log

set -x EDITOR nvim
set -x SSH_AUTH_SOCK "/run/user/1000/ssh-agent.socket"
set -x WORKON_HOME $HOME/.local/share/virtualenvs


# After installation of Pyenv
set -x PATH "/home/mrurenko/.pyenv/bin" $PATH
# status --is-interactive; and . (pyenv init -|psub)
# status --is-interactive; and . (pyenv virtualenv-init -|psub)

set -x PATH "$HOME/.poetry/bin" $PATH

set -x PATH "$HOME/.local/bin" $PATH

set -x PATH "$(go env GOPATH)/bin" $PATH


# if test "$XDG_VTNR" -le 2
#     tbsm
# end
source /opt/asdf-vm/asdf.fish

# should be on the end of config file
zoxide init fish | source

# failed in configuring and using direnv
direnv hook fish | source


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# copy next to
# eval /opt/anaconda/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
