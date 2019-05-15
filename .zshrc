
# ZSH/OMZSH setup
export ZSH="/Users/kevinhi/.oh-my-zsh"
ZSH_THEME="powerlevel9k/powerlevel9k"
#DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)
. $ZSH/oh-my-zsh.sh
autoload bashcompinit
bashcompinit


test -f "$HOME/.sh_env" && . "$HOME/.sh_env"
test -f "$HOME/.sh_aliases" && . "$HOME/.sh_aliases"

alias .z='. ~/.zshrc'
