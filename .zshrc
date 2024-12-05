export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="cypher"

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git fzf) # TODO: zoxide

source $ZSH/oh-my-zsh.sh

alias ls='exa -l --git --icons -a'
alias logout='pkill -SIGKILL -u jonas'
alias bios='systemctl reboot --firmware-setup'
alias vim='nvim'
alias ':q'=exit

export PATH=:$HOME/repos/sleep_script/:$PATH:/$HOME/repos/sowon::$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$HOME/cmdline-tools/bin
