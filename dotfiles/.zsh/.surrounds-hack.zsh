function change-hack() {
  read -k 1 option

  if [[ $option == 's' ]]; then
    zle -U Tcs
  elif [[ $option == 'c' ]]; then
    zle vi-change-whole-line
  else
    zle -U ${NUMERIC}Tvc$option
  fi
}

function delete-hack() {
  read -k 1 option

  if [[ $option == 's' ]]; then
    zle -U Tds
  elif [[ $option == 'd' ]]; then
    zle kill-whole-line
  else
    zle -U ${NUMERIC}Tvd$option
  fi
}

function yank-hack() {
  read -k 1 option

  if [[ $option == 's' ]]; then
    zle -U Tys
  elif [[ $option == 'y' ]]; then
    zle vi-yank-whole-line
  else
    zle -U ${NUMERIC}Tvy$option
  fi
}

zle -N change-hack
zle -N delete-hack
zle -N yank-hack
autoload -Uz surround
zle -N delete-surround surround
zle -N change-surround surround
zle -N add-surround surround
bindkey -M vicmd 'Tcs' change-surround
bindkey -M vicmd 'Tds' delete-surround
bindkey -M vicmd 'Tys' add-surround
bindkey -M vicmd 'Tvd' vi-delete
bindkey -M vicmd 'Tvc' vi-change
bindkey -M vicmd 'Tvy' vi-yank
bindkey -M vicmd 'c' change-hack
bindkey -M vicmd 'd' delete-hack
bindkey -M vicmd 'y' yank-hack
bindkey -M visual S add-surround
