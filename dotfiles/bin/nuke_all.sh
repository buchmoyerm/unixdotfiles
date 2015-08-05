#!/bin/bash

ROOT_DIR=${PROJMAKE_ROOT_DIR:-~/workspace/}

BUILD_DIR=${ROOT_DIR%%/}/build
INSTALL_DIR=${ROOT_DIR%%/}/install

if [ -d ${BUILD_DIR} ]; then
  echo "Removing ${BUILD_DIR}"
  rm -rf ${BUILD_DIR}
else
  echo "Cannot find ${BUILD_DIR}"
fi

if [ -d ${INSTALL_DIR} ]; then
  echo "Removing ${INSTALL_DIR}"
  rm -rf ${INSTALL_DIR}
else
  echo "Cannot find ${INSTALL_DIR}"
fi
