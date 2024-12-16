export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'

ZSH_THEME="frontcube"

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)

ZSH_AUTOSUGGEST_STRATEGY=(completion history)

source $ZSH/oh-my-zsh.sh

alias ls='exa -l --git --icons -a'
alias vim='nvim'
alias ':q'=exit

export PATH=:$HOME/repos/sleep_script/:$PATH:/$HOME/repos/sowon::$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$HOME/cmdline-tools/bin
