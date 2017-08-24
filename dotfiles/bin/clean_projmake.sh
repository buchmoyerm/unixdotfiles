#!/bin/bash

ROOT_DIR=${PROJMAKE_ROOT_DIR:-~/workspace/}

BUILD_DIR=${ROOT_DIR%%/}/build

BUILD_DIR=$(/home/ibbldbot/ib-build-tools/bin/projmake --printenv PROJMAKE_BUILD_BASE)

if [ -d ${BUILD_DIR} ]; then
#   echo "Removing *.a from ${BUILD_DIR}"
#   find ${BUILD_DIR} -name '*.a' -delete

  echo "Removing *.tsk from ${BUILD_DIR}"
  find ${BUILD_DIR} -name '*.tsk' -delete
else
  echo "Cannot find ${BUILD_DIR}"
fi

