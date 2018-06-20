alias dc="docker-compose"
alias dps="docker-compose ps"
alias dlog="docker-compose log"

set -x SSH_AUTH_SOCK "/run/user/1000/ssh-agent.socket"
set -x WORKON_HOME $HOME/.local/share/virtualenvs

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /home/mrurenko/projects/wyng/instagram-ingestion/node_modules/tabtab/.completions/serverless.fish ]; and . /home/mrurenko/projects/wyng/instagram-ingestion/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /home/mrurenko/projects/wyng/instagram-ingestion/node_modules/tabtab/.completions/sls.fish ]; and . /home/mrurenko/projects/wyng/instagram-ingestion/node_modules/tabtab/.completions/sls.fish