#!/opt/bb/bin/bash

ROOT_DIR=${PROJMAKE_ROOT_DIR:-~/workspace/}

BUILD_DIR=${ROOT_DIR%%/}/build
INSTALL_DIR=${ROOT_DIR%%/}/install

# makefiles=$(find $ROOT_DIR -name "gtest*.mk")

# pekludge=$(/opt/bb/bin/egrep "^\s*IS_PEKLUDGE=[^\s]+" "$makefiles" 2> /dev/null | wc -l)
# pekludgeoverride=$(/opt/bb/bin/egrep "IBTEST_NOPEKLUDGE" "$makefiles" 2> /dev/null | wc -l)

# if [ 0 != $pekludgeoverride ] || [ 0 == $pekludge ]; then
  tests=$(find ${BUILD_DIR}/*/*`uname`*/* -name "gtest*.tsk")
  if [ "$tests" != "" ]; then
    echo "attempting to run all available tests"
    for t in $tests; do
      echo "running $t"
      echo " "
      $t
    done;
  else
    echo "No unit tests found"
  fi
# else
#   echo "Unit test makefile contains IS_PEKLUDGE=yes without override. Skipping."
# fi

