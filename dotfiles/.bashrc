#!/bin/bash

# ~/.bashrc skeleton
# ~/.bashrc runs ONLY on non-login subshells! (different from ksh)
# add lines here very carefully as this may execute when you don't
# expect them to
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo "BASHRC has run"

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# if chimera generated aliases exist, pull them into the current ENV
[ -f ~/.bbalias ] && . ~/.bbalias

uname=`uname`
#if [[ $uname == "AIX" ]] ; then
#    alias vim="TERM=xterm-new vim"
#    alias gvim="TERM=xterm-new gvim"
#fi

[[ ${TERM} == "screen" ]] && export TERM="screen-256color"

# if [ -d ${HOME}/.terminfo/${SYSTYPE} ]
# then
#     export TERMINFO=${HOME}/.terminfo/${SYSTYPE}
#     # Override 'xterm' -> 'xterm-256color'
#     if [ ${TERM} = xterm ]
#     then
#         export TERM=xterm-256color
#     fi
#     # Override 'rxvt-unicode' -> 'rxvt-unicode-256color'
#     if [ ${TERM} = rxvt-unicode ]
#     then
#         export TERM=rxvt-unicode-256color
#     fi
# fi
# 

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# commandline editing
#set -o emacs    # emacs style command line mode (default)
set -o vi      # vi style command line mode
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# try to get backspace working correctly
stty erase \^\h kill \^u intr \^c
stty echoe echok ixon ixoff -ixany
stty erase ^?

# don't have the buffer get overwritten after window size changes
shopt -s checkwinsize

# Typo tolerance
shopt -s cdspell

# History fixes
export HISTFILESIZE=5000          # Store 5000 commands in history
export HISTCONTROL=ignoredups    # Don't put duplicate lines in the history.
shopt -s histappend                 # Append history rather than overwrite

export GREP_OPTIONS="--color=auto"
export VISUAL="/opt/bb/bin/gvim -v"
export EDITOR="$VISUAL"

source $HOME/.bash/.bashrc.colors
source $HOME/.bash/.bashrc.aliases
source $HOME/.bash/.bashrc.prompt
source $HOME/.bash/.bashrc.git
source $HOME/.bash/.bashrc.bbrg
source $HOME/.bash/.bashrc.cmds

PATH="$HOME/workspace/git-ib:$PATH"
source $HOME/workspace/git-ib/git-ib-autocomplete.sh
