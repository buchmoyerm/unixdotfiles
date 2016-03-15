#!/bin/bash

ROOT_DIR=${PROJMAKE_ROOT_DIR:-~/workspace/} 

INSTALL_DIR=${ROOT_DIR%%/}/install

# INSTALL_DIR=$(/home/slee601/bin/projmake --printenv PROJMAKE_INSTALL_BASE)

if [ -d ${INSTALL_DIR} ]; then
  echo "Removing *.h from ${INSTALL_DIR}"
  find ${INSTALL_DIR} -name '*.h' -delete

  echo "Removing *.a from ${INSTALL_DIR}"
  find ${INSTALL_DIR} -name '*.a' -delete

  echo "Removing *.tsk from ${INSTALL_DIR}"
  find ${INSTALL_DIR} -name '*.tsk' -delete
else
  echo "Cannot find ${INSTALL_DIR}"
fi

