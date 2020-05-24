function source_script {
    if [ -f "$1" ]; then
        . "$1"
    else
        echo "\033[33mwarning: $1 does not exist\033[0m" >&2
    fi
}

function omzsh_init {
    export ZSH="$HOME/.oh-my-zsh"
    ZSH_THEME="powerlevel9k/powerlevel9k"
    DISABLE_UNTRACKED_FILES_DIRTY="true"

    plugins=(osx)
}

function pl9k_init {
    # https://github.com/bhilburn/powerlevel9k/blob/master/README.md
    # https://github.com/bhilburn/powerlevel9k/wiki

    POWERLEVEL9K_STATUS_CROSS=false
    POWERLEVEL9K_STATUS_OK=false
    POWERLEVEL9K_HIDE_BRANCH_ICON=true
    POWERLEVEL9K_SHOW_CHANGESET=true

    #POWERLEVEL9K_TIME_FORMAT="%D{%y-%m-%d %H:%M:%S}"
    #POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S.%.}"
    #POWERLEVEL9K_CUSTOM_VPN="pl9k_vpn_status"

    #POWERLEVEL9K_CUSTOM_VPN_FOREGROUND="black"
    #POWERLEVEL9K_CUSTOM_VPN_BACKGROUND="green"
    POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='008'
    POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='007'

    PL9K_DIR_BACKGROUND='007'
    PL9K_DIR_FOREGROUND='000'
    POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=$PL9K_DIR_BACKGROUND
    POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=$PL9K_DIR_FOREGROUND
    POWERLEVEL9K_DIR_HOME_BACKGROUND=$PL9K_DIR_BACKGROUND
    POWERLEVEL9K_DIR_HOME_FOREGROUND=$PL9K_DIR_FOREGROUND
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=$PL9K_DIR_BACKGROUND
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=$PL9K_DIR_FOREGROUND
    POWERLEVEL9K_DIR_ETC_BACKGROUND=$PL9K_DIR_BACKGROUND
    POWERLEVEL9K_DIR_ETC_FOREGROUND=$PL9K_DIR_FOREGROUND

    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time custom_vpn status context dir vcs)
    POWERLEVEL9K_DISABLE_RPROMPT=true
    #POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(root_indicator background_jobs)
}

function pl9k_vpn_status {
    IFS=$'\n' vpns=($(scutil --nc list | tail +2 | grep -E -o "\"(.+)\"" | tr -d '"'))
    unset IFS
    connected_vpns=()
    for v in ${vpns[@]}; do
        if [[ "$(scutil --nc status "$v" | head -1)" == "Connected" ]]; then
            connected_vpns+=("$v")
        fi
    done
    echo ${connected_vpns[@]}
    unset IFS
}

alias .z=". $HOME/.zshrc"
alias zedit="vim $HOME/.zshrc"
omzsh_init
pl9k_init

source_script "$ZSH/oh-my-zsh.sh"
autoload bashcompinit
bashcompinit

source_script "$HOME/.iterm2-tabs.zsh"

IGNITE_INSTALLATION="/Users/kevinhi/git/kdhira/ignite"

source_script "$HOME/.sh_env"
source_script "$HOME/.sh_aliases"
source_script "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_script "$HOME/bin/autocomplete_ignite"
source_script "$HOME/.iterm2_shell_integration.zsh"
source_script "$HOME/Library/Python/3.7/bin/aws_zsh_completer.sh"
