
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

## User configuration
## Enable Pyenv on zsh start: Added '$HOME/.pyenv/bin'
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

## Enable rbenv on zsh start
# export PATH="$HOME/.rbenv/bin:$PATH"

## emacs project dependencies tool
export PATH="$HOME/.cask/bin:$PATH"

export SSH_AUTH_SOCK="/run/user/1000/ssh-agent.socket"

