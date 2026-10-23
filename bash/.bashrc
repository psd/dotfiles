# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# return if not running interactively
[[ $- != *i* ]] && return

# Omarchy default aliases and functions
source "$OMARCHY_PATH/default/bash/rc"

# Python
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# my brain is hard-wired to these two, terrible aliases
alias workon='source .venv/bin/activate'
alias mkvenv='python3 -m venv --prompt . .venv --clear --upgrade-deps && workon'

# my brain was rewired by Bill Joy sometime in 1985
alias vi='nvim-clean'  # vi-style Neovim, see ~/.config/nvim-vi
alias vim='nvim-clean'
export EDITOR=nvim-clean
export VISUAL=nvim-clean
export SUDO_EDITOR=nvim-clean
set -o vi

alias lrt='ls -lh --sort=modified'

# local scripts
export PATH="/home/psd/.local/bin:$PATH:"

# useful for jumping around directories
export CDPATH=.:~/src/psd:~/src:~/src/digital-land/:~:


# Use the systemd user ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
ssh-add -l >/dev/null 2>&1 || ssh-add
