# ~/.profile skeleton
# ~/.profile runs on interactive login shells if it exists
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
function __print_debug
{
  tty -s
  # if [ $? -eq 0 ] ; then
  #   echo "$@"
  # fi
}

__print_debug "~/.profile has run"


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# this variable needs to be set for pnewtask/pnewscript to function
# if you don't know what to put here leave it alone or ask your team.
#GROUP=put_your_group_here

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# chimera not present/didn't run, set some basic stuff up
# hope /etc/passwd is good enough
if [ ! "$BBENV" ] && [ -d /opt/bb ]
then
     PS1="${HOSTNAME}:\${PWD} \$ "
     PATH=$PATH:/usr/sbin
     ##LPDEST=put_your_printer_here
     ##GROUP=put_your_group_here
     stty erase \^\h kill \^u intr \^c
     stty echoe echok ixon ixoff -ixany

     if [ $(uname) = "SunOS" ] && [ ! "$BASH" ] ; then
          set -o emacs
          alias __A=$(print '\0020') # ^P = up = previous command
          alias __B=$(print '\0016') # ^N = down = next command
          alias __C=$(print '\0006') # ^F = right = forward a character
          alias __D=$(print '\0002') # ^B = left = back a character
          alias __H=$(print '\0001') # ^A = home = beginning of line
          stty erase ^?
          #echo "SunOS keys set"
     fi
fi

# Set up terminal type
if [ "${XTERM:-unset}" == unset ] ; then
  __print_debug "putty!!"
  if [ "${TERM:-unset}" == xterm ] ; then
      case ${SYSTYPE} in
          # SunOS)
          #     export TERM=xtermc ;;
          # AIX)
          #     export TERM=xterm-new ;;
          Linux)
  #             export TERMINFO=/opt/bb/share/terminfo
              # export TERM=putty-256color ;;
              export TERM=xterm-256color ;;
      esac
  fi
else
  __print_debug "real xterm!!"
  #this fixes vim inside tmux when using EOD
  #it also breaks vim inside tmux when using putty
  # if [ ${TMUX:-unset} != unset ] ; then
  #   if [ ${TERM} = xterm-256color ] ; then
  #     export TERM=screen-256color
  #   fi
  # fi
fi

# source ${HOME}/.bashrc

