#!/bin/bash

args=""

for item in "$@" ; do
  if [[ $item == --local ]] ; then
    export LOCUM_LOCAL=1
    echo "Building local"
  else
    args+=$item
  fi
done

bld_cmd="/home/ibbldbot/ib-build-tools/bin/projmake $args -- -j10 -l32'"

echo "Build Command:$bld_cmd"
$bld_cmd

