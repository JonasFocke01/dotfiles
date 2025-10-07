export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'

ZSH_THEME="frontcube"

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)

ZSH_AUTOSUGGEST_STRATEGY=(completion history)

source $ZSH/oh-my-zsh.sh

setopt CORRECT
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
bindkey -v # vi mode

fzf_history() {
    local dynamic_history=~/.zsh_history
    local custom_history=~/.custom_zsh_history

    cat <(tac $dynamic_history) <(cat $custom_history) | fzf --query="$BUFFER" --reverse --height=10
}
zle -N fzf_history
bindkey '^R' fzf_history

alias ls='exa -l --git --icons -a'
alias vim='nvim'
alias ':q'=exit

export PATH=:$HOME/repos/sleep_script/:$PATH:/$HOME/repos/sowon::$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$HOME/cmdline-tools/bin:$HOME/repos/github_issue_roulette/target/release:$HOME/repos/remindy/target/release
