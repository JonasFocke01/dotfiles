export ZSH="$HOME/.oh-my-zsh"

export EDITOR='nvim'
export TERM="alacritty"
export TERMINAL="alacritty"
export BROWSER="firefox"

ZSH_THEME="frontcube"

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)

ZSH_AUTOSUGGEST_STRATEGY=(completion history)

source $ZSH/oh-my-zsh.sh

setopt CORRECT
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt APPEND_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
bindkey -v # vi mode

alias ls='eza -l --git --icons -a'
alias vim='nvim'
alias ':q'=exit
alias lsusb='cyme'
alias cat='bat'
alias spotify='ncspot'
alias rm='echo -n "Only use **rm** if you are extra sure! \nA safer way to remove files is with **trash-put**.\nSee **trash --help** for more infos.\nIf you REALY want to use rm, type **\\\\rm**\n"'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export PATH=$PATH:$HOME/.local/bin
