#!/bin/bash

# arg_string=" ";
# 
# for arg in $@; do
#   arg_string="$arg_string$arg "
# done

bld_cmd="/home/slee601/bin/projmake $@ -- -j10 -l32'"

if [ -f "x.mk" ]; then

  echo "setting config source"
  echo "Build Command:$bld_cmd"
  CONFIG_SRC=x.mk $bld_cmd

else

  echo "Build Command:$bld_cmd"
  $bld_cmd

fi
