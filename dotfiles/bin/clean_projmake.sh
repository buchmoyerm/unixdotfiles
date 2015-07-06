#!/bin/bash

ROOT_DIR=${PROJMAKE_ROOT_DIR:-~/workspace/}

BUILD_DIR=${ROOT_DIR%%/}/build

if [ -d ${BUILD_DIR} ]; then
  echo "Removing *.a from ${BUILD_DIR}"
  find ${BUILD_DIR} -name '*.a' -delete

  echo "Removeing *.tsk from ${BUILD_DIR}"
  find ${BUILD_DIR} -name '*.tsk' -delete
else
  echo "Cannot find ${BUILD_DIR}"
fi

