# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mbuchmoyer/.zshrc'

autoload -Uz compinit
compinit -u
# End of lines added by compinstall

export GREP_OPTIONS="--color=auto"
export VISUAL="/opt/bb/bin/vim -v -u ~/.vimrc_min"
export EDITOR="$VISUAL"

source $HOME/.bash/.bashrc.colors
source $HOME/.bash/.bashrc.aliases
# source $HOME/.bash/.bashrc.prompt
source $HOME/.bash/.bashrc.git
source $HOME/.bash/.bashrc.bbrg
source $HOME/.bash/.bashrc.cmds

PATH="$HOME/workspace/git-ib:$PATH"
source $HOME/workspace/git-ib/git-ib-autocomplete.sh
