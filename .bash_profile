#!/bin/bash
# Author: Kevin Hira

# Import common script
test -f "$HOME/bin/_ignite_completion" && . "$HOME/bin/_ignite_completion"
test -f "$HOME/.iterm2_shell_integration.bash" && . "$HOME/.iterm2_shell_integration.bash"

test -f "$HOME/.sh_env" && . "$HOME/.sh_env"
test -f "$HOME/.sh_aliases" && . "$HOME/.sh_aliases"

# Completion
if [ -f "/usr/local/etc/bash_completion" ]; then
    source /usr/local/etc/bash_completion
    GIT_COMPLETION_IMPORT=1
fi

# PS1
if [ $GIT_COMPLETION_IMPORT -eq 1 ]; then
    PS1='\[\e[33m\]\u\[\e[2;36m\]@\h\[\e[0m\] \[\e[33m\]\w\[\e[2;37m\]$(__git_ps1)\[\e[0m\]\$ '
    GIT_PS1_SHOWDIRTYSTATE=true
else
    PS1='\[\e[0;37m\][\[\e[0;32m\]\u\[\e[0;32m\]@\[\e[0;32m\]\h \[\e[0;37m\]\W\[\e[0;37m\]]$ \[\e[0m\]'
    #PS1='\u@\h \w\$ '
fi


# Profile loading
alias .b='. ~/.bash_profile'

export RBENV_ROOT="$HOME/.rbenv"
if [ -d $RBENV_ROOT ]; then
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init -)"
fi
