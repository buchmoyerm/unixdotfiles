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
  local dest="$HOME/`basename $src`"
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
for f in `ls -A $DOTFILES`; do
  if should_install $f; then
    link "$DOTFILES/$f"
  fi
done
