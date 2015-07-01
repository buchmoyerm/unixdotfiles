# ~/.profile skeleton
# ~/.profile runs on interactive login shells if it exists
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo "~/.profile has run"

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# commandline editing
set -o emacs    # emacs style command line mode (default)
#set -o vi      # vi style command line mode

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# this variable needs to be set for pnewtask/pnewscript to function
# if you don't know what to put here leave it alone or ask your team.
#GROUP=put_your_group_here

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# chimera not present/didn't run, set some basic stuff up 
# hope /etc/passwd is good enough
if [ ! "$BBENV" ] 
then
     PS1="${HOSTNAME}:\${PWD} \$ " 
     PATH=$PATH:/usr/sbin
     ##LPDEST=put_your_printer_here
     ##GROUP=put_your_group_here
     stty erase \^\h kill \^u intr \^c
     stty echoe echok ixon ixoff -ixany

     if [ $(uname) = "SunOS" ] && [ ! "$BASH" ]
     then
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

# don't have the buffer get overwritten after window size changes
shopt -s checkwinsize


# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White


Ochre='\e[38;5;95m'

function git_color {
  local git_status="$(git status 2> /dev/null)"
  
  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $Red
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $Green
  elif [[ $git_status =~ "Your branch is behind" ]]; then
    echo -e $Yellow
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $Cyan
  else
    echo -e $Ochre
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo $" ($branch)"
  elif [[ $git_status =~ $on_branch ]]; then
    local commit=${BASH_REMATCH[1]}
    echo $" ($commit)"
  fi
}

function prompt {
#     export PS1="$BLACKBOLD[\t]$GREEN \u@\h$RESET:$BLUEBOLD\w$RESET$RED"'$(__git_ps1)'"$RESET \\$ "
  PS1="\[$Yellow\][\t]\[$Color_Off\]\n"
  PS1+="\[$IBlue\]\u\[$Color_Off\]"
  PS1+="@"
  PS1+="\[$Green\]\h\[$Color_Off\]"
  PS1+=":\w"
  PS1+="\[\$(git_color)\]\$(git_branch)\[$Color_Off\]"
  PS1+=" \\$ "
}
prompt

# export GIT_PS1_SHOWDIRTYSTATE=true
# export GIT_PS1_SHOWUNTRACKEDFILES=true

alias findtsk='find . -name "*.tsk" -exec ls -l {} \;'
alias ls="ls --color"
alias ll="ls -lrt --color"
alias less="less -i -R"
alias op1="/bb/admin/ngetprdwin.py -u op1 -d'op1' -i -s"

function tcless() {
  if [ $# -eq 0 ]; then
    echo "Usage: tcless [filename]"
  else
    command tail -f "$@" | bblc | less
  fi
}
complete -o default -o nospace  tcless

# git types
alias g="git"
alias gi="git"
__git_complete g _git
__git_complete gi _git

alias work="cd ~/workspace"

# set up proxy so that github will work (needed for vundle)
export HTTP_PROXY="http://devproxy.bloomberg.com:82/"
export HTTPS_PROXY="http://devproxy.bloomberg.com:82/"
export NO_PROXY="localhost,.dev.bloomberg.com,127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
export GIT_SSL_NO_VERIFY=1

# use vim compatible with YCM
alias vim="/opt/swt/bin/vim"
alias gvim="/opt/swt/bin/gvim"
export VISUAL="/opt/swt/bin/vim"
export EDITOR="$VISUAL"

export TERM=xterm-256color

# projmake auto complete
function _projmake-completer {
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "AIX-powerpc-32 AIX-powerpc-64 SunOS-sparc-32 SunOS-sparc-64 Linux-x86_64-32 Linux-x86_64-64" -- $cur) )
}

complete -o default -o nospace -F _projmake-completer projmake.sh 
complete -o default -o nospace -F _projmake-completer projmake 

# tab completion help
bind 'set completetion-ignore-case On'
bind 'set show-all-if-ambiguous On'


source ./.bashrc

echo -en "\033]0;$HOSTNAME\a"

# Start TMUX
# [ -z "$TMUX" ] && command -v tmux attach > /dev/null && TERM=xterm-256color && exec tmux attach

# if [ -z "$TMUX" ]; then
#    base_session='session'
#    # Create a new session if it doesn't exist
#    tmux has-session -t $base_session || tmux new-session -d -s $base_session
#    # Are there any clients connected already?
#    client_cnt=$(tmux list-clients | wc -l)
#    if [ $client_cnt -ge 1 ]; then
#       session_name=$base_session"-"$client_cnt
#       tmux new-session -d -t $base_session -s $session_name
#       tmux -2 attach-session -t $session_name \; set-option destroy-unattached
#    else
#       tmux -2 attach-session -t $base_session
#    fi
# fi

# (tmux ls | grep -vq attached && tmux at) || tmux
