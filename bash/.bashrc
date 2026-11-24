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
# workon: activate the nearest .venv, searching upwards from $PWD
workon() {
    local dir=$PWD
    while [[ -n $dir && ! -f $dir/.venv/bin/activate ]]; do
        dir=${dir%/*}
    done
    if [[ -z $dir ]]; then
        echo "workon: no .venv found; run mkvenv" >&2
        return 1
    fi
    declare -F deactivate >/dev/null && deactivate
    source "$dir/.venv/bin/activate"
}

# mkvenv [version]: create .venv (with pip) and activate it.
# Version: argument, else .python-version, else latest Python.
mkvenv() {
    local ver=${1:-}
    if [[ -z $ver && -f .python-version ]]; then
        ver=$(head -n1 .python-version)
    fi
    declare -F deactivate >/dev/null && deactivate
    uv venv --seed --clear --prompt . --python "${ver:-3}" .venv && workon
}

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
