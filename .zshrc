function source_script {
    test -f "$1" && . "$1"
}

function omzsh_init {
    export ZSH="$HOME/.oh-my-zsh"
    ZSH_THEME="powerlevel9k/powerlevel9k"
    DISABLE_UNTRACKED_FILES_DIRTY="true"
}

function pl9k_init {
    # https://github.com/bhilburn/powerlevel9k/blob/master/README.md
    # https://github.com/bhilburn/powerlevel9k/wiki

    POWERLEVEL9K_HIDE_BRANCH_ICON=true
    POWERLEVEL9K_SHOW_CHANGESET=true

    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time status context dir vcs)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(root_indicator background_jobs)
}


alias .z=". $HOME/.zshrc"
alias zedit="vim $HOME/.zshrc"
omzsh_init
pl9k_init

source_script "$ZSH/oh-my-zsh.sh"
autoload bashcompinit
bashcompinit

source_script "$HOME/.sh_env"
source_script "$HOME/.sh_aliases"
source_script "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_script "$HOME/bin/_ignite_completion"
