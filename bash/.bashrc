# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# vain attempts to make bash history less rubbish
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=2000

# my brain was rewired by Bill Joy sometime in 1985
export EDITOR=vi
set -o vi
alias vi='nvim'
alias vim='nvim'

# check the window size after each command, sets LINES and COLUMNS variables
# probably overkill as I rarely resize my terminal
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# bash supplied magic
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# some hack-scripts ..
export PATH="$HOME/bin:$PATH"

# useful for jumping around directories
export CDPATH=.:~/src/psd:~/src:~/src/digital-land/:~:

# prompt like it's 1975
export PS1='$ '
export PS2="> "

# use keychain to ensure ssh-agent is running ..
eval $(keychain --eval id_rsa)

# https://dev.gnupg.org/T3412
export GPG_TTY=$(tty)

# Python
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# my brain is hard-wired to these two, terrible aliases
alias workon='source .venv/bin/activate'
alias mkvenv='python3.13 -m venv --prompt . .venv --clear --upgrade-deps && workon'

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# node version management
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
