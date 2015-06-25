#!/bin/bash

# ~/.bashrc skeleton
# ~/.bashrc runs ONLY on non-login subshells! (different from ksh)
# add lines here very carefully as this may execute when you don't i
# expect them to
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#echo "BASHRC has run"

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# if chimera generated aliases exist, pull them into the current ENV
[ -f ~/.bbalias ] && . ~/.bbalias
#PS1='\[`\\[ $? = 0 ] && X=2 || X=1; tput setaf $X`\]\h\[`tput sgr0`\]:$PWD\$ '

uname=`uname`
#if [[ $uname == "AIX" ]] ; then
#    alias vim="TERM=xterm-new vim"
#    alias gvim="TERM=xterm-new gvim"
#fi

[[ ${TERM} == "screen" ]] && export TERM="screen-256color"

if [ -d ${HOME}/.terminfo/${SYSTYPE} ]
then
    export TERMINFO=${HOME}/.terminfo/${SYSTYPE}
    # Override 'xterm' -> 'xterm-256color'
    if [ ${TERM} = xterm ]
    then
        export TERM=xterm-256color
    fi
    # Override 'rxvt-unicode' -> 'rxvt-unicode-256color'
    if [ ${TERM} = rxvt-unicode ]
    then
        export TERM=rxvt-unicode-256color
    fi
fi


function tm() {
    if [ "$#" -ge 1 ] && [ "$1" = -z ]; then
        shift
        command tmux detach 2>/dev/null
        command tmux attach "$@" || command tmux new-session "$@"
    else
        command tmux "$@"
    fi
}

