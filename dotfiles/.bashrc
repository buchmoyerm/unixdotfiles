#!/bin/bash
# ~/.bashrc skeleton
# ~/.bashrc runs ONLY on non-login subshells! (different from ksh)
# add lines here very carefully as this may execute when you don't
# expect them to
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# if chimera generated aliases exist, pull them into the current ENV
[ -f ~/.bbalias ] && . ~/.bbalias
[ -d /opt/bb ] && export IS_BBRG=1

uname=`uname`

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# commandline editing
#set -o emacs    # emacs style command line mode (default)
set -o vi      # vi style command line mode
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# set -o notify

# try to get backspace working correctly
stty echoe echok ixon ixoff -ixany
[[ $uname == "Linux" ]] && stty erase ^? ||  stty erase \^\h kill \^u intr \^c

shopt -s checkwinsize # don't have the buffer get overwritten after window size changes
shopt -s cdspell # Typo tolerance
shopt -s autocd # just type dir name to cd
shopt -s checkhash # check for command in hash table before looking it up in path
shopt -s cdable_vars # cd can accept variabls that hold directory names
shopt -s checkjobs # list status of any running jobs before exiting
shopt -s histappend # Append history rather than overwrite
shopt -s cmdhist # save all lines of multi line command
shopt -s extglob # extended pattern matching for bash completion
shopt -s globstar # '**' matches all files and no directories
shopt -s dirspell # typo tolerance when tab completing directories

# export PATH=${HOME}/bin:${PATH}

# History fixes
export HISTFILESIZE=5000                # Store 5000 commands in history
export HISTCONTROL=ignoredups:erasedups # Don't put duplicate lines in the history.
export HISTIGNORE="&:[  ]*:exit:ls:bg:fg:history:clear" # ignore certain commands

export PROMPT_COMMAND="history -a"

source $HOME/.myenv

source $HOME/.bash/.bashrc.colors
source $HOME/.bash/.bashrc.aliases
source $HOME/.bash/.bashrc.prompt
source $HOME/.bash/.bashrc.git
[ $IS_BBRG ] && source $HOME/.bash/.bashrc.bbrg
source $HOME/.bash/.bashrc.cmds

if [ $IS_BBRG ] ; then
  PATH="$HOME/workspace/git-ib:$PATH"
  source $HOME/workspace/git-ib/git-ib-autocomplete.sh
fi

# local overrides
[ -f ${HOME}/.local/.bashrc ] && . ${HOME}/.local/.bashrc
