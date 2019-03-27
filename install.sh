#!/bin/bash

# Installs dotfiles and helpers

realpath() {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

safe_link(){
  local src="$1"
  local dest="$HOME/`basename $src`"
  if [ ! -e "$dest" ]; then
    ln -sf "$src" "$dest"
  fi
}

link(){
  local src="$1"
  local dest=${src##${DOTFILES}}
  dest="${HOME}${dest##"/dotfiles"}"
  # local dest="$HOME/`basename $src`"
  if [ -e "$dest" ]; then
    rm -rf "$dest"
  fi
  ln -sf "$src" "$dest"
}

# Get root
SCRIPT_PATH=`realpath $0`
DOTFILES=`dirname $SCRIPT_PATH`

should_install() {
  local file="$1"
  if [ $file = "install.sh" ]; then
    return 1;
  elif [ $file = ".git" ]; then
    return 1;
  fi
  return 0;
}

# Install dotfiles
for f in `ls -A $DOTFILES/dotfiles`; do
  if should_install $f; then
    link "$DOTFILES/dotfiles/$f"
  fi
done

# install oh-my-zsh addons
oh_my_zsh_custom=(themes plugins)
for cust in ${oh_my_zsh_custom[@]} ; do
  for f in `ls -A $DOTFILES/.oh-my-zsh/custom/${cust}`; do
    if should_install $f; then
      link "$DOTFILES/.oh-my-zsh/custom/${cust}/$f"
    fi
  done
done
