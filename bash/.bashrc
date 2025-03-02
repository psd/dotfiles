# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# vain attempts of making bash history better
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=2000

# check the window size after each command 
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# my brain was rewired by Bill Joy sometime in 1985
set -o vi
export EDITOR=vi
alias vi='nvim'
alias vim='nvim'

export PATH="$HOME/bin:$PATH"

export CDPATH=.:~/src/psd:~/src:~/src/digital-land/:~:

export PS1='$ '
export PS2="> "

export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# use keychain to ensure ssh-agent is running ..
eval $(keychain --eval id_rsa)
export GPG_TTY=$(tty)

# Python
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# my brain is hard-wired to these two aliases
alias workon='source .venv/bin/activate'
alias mkvirtualenv='python3.12 -m venv --prompt . .venv --clear --upgrade-deps && workon'

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# node version management
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
