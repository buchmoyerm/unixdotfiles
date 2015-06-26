#!/bin/ksh

# ~/.kshrc skeleton
# ~/.kshrc runs on ALL ksh and bbksh subshells! put things here
# very carefully as this may execute when you don't expect it to
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#echo "KSHRC has run"

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# if chimera generated aliases exist, pull them into the current ENV
[ -f ~/.bbalias ] && . ~/.bbalias

# ====================================================================
# From https://cms.prod.bloomberg.com/team//display/~jwong547/Set+up+VIM+Environment?secret=av4HrE8A3QNMcQ7VFMYBvz8g2MXjRZOwH3n04g36E78H%2fmITwJw6VND585l1K2XwAAAAAA%3d%3d
# ====================================================================

#PS1='\[`[ $? = 0 ] && X=2 || X=1; tput setaf $X`\]\h\[`tput sgr0`\]:$PWD\$ '

#export HTTP_PROXY=http://devproxy.bloomberg.com:82/
#export HTTPS_PROXY=http://devproxy.bloomberg.com:82/
#export GIT_SSL_NO_VERIFY=true
#export TERM=xterm-256color
