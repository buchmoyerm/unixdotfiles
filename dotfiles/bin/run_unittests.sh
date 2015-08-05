#!/opt/bb/bin/bash

ROOT_DIR=${PROJMAKE_ROOT_DIR:-~/workspace/}

BUILD_DIR=${ROOT_DIR%%/}/build
INSTALL_DIR=${ROOT_DIR%%/}/install

pushd ~/workspace/

echo "attempting to run all available tests"
/home/ibbldbot/ib-build-tools/jenkins-scripts/offline-nightly-unittests.sh

popd
