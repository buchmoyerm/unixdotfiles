#!/bin/bash

# arg_string=" ";
# 
# for arg in $@; do
#   arg_string="$arg_string$arg "
# done

bld_cmd="/home/slee601/projmake/bin/projmake $@ -- -j10 -l32"

echo "Build Command:$bld_cmd"

$bld_cmd
