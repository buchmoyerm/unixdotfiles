#!/opt/bb/bin/bash

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#  My old unit test launcher
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# ROOT_DIR=${PROJMAKE_ROOT_DIR:-~/workspace/}

# BUILD_DIR=${ROOT_DIR%%/}/build
# INSTALL_DIR=${ROOT_DIR%%/}/install

# tests=$(find ${BUILD_DIR}/*/*`uname`*/* -name "gtest*.tsk")
# if [ "$tests" != "" ]; then
#   echo "attempting to run all available tests"
#   for t in $tests; do
#     echo "running $t"
#     echo " "
#     $t --gtest_color=yes
#   done;
# else
#   echo "No unit tests found"
# fi

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#  Prateek's unit test runner
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

function printUsage()
{
  echo "-p Pattern to filter out component(s) to look for.  "
  echo "-g Gtest filter command.                            "
  echo "-n Only print the task to be run.                   "
  echo "-h Prints this usage.                               "
}

source "${HOME}/.bash/.bashrc.colors"

PATTERN=
GTEST_FILTER=
DRY_RUN=0

while getopts "p:g:nh" opt; do
  case $opt in
    p)
      PATTERN=$OPTARG
      ;;
    g)
      GTEST_FILTER=$OPTARG
      ;;
    n)
      DRY_RUN=1
      ;;
    h)
      printUsage
      exit 0
      ;;
    \?)
      echo "Idiot !! Invalid option: -$OPTARG"
      printUsage
      exit 1
      ;;
  esac
done

PROJMAKE_CONFIG_PATH=
if [[ -f "./projmake.config" ]]; then
  PROJMAKE_CONFIG_PATH="./projmake.config"
else
  if [[ -f "../projmake.config" ]]; then
    PROJMAKE_CONFIG_PATH="../projmake.config"
  else
    echo "projmake.config not found."
  fi
fi

WORKSPACE="`projmake --printenv=PROJMAKE_WORKSPACE`"
# WORKSPACE=
# if [[ "${PROJMAKE_CONFIG_PATH}" ]]; then
#   WORKSPACE=`cat ${PROJMAKE_CONFIG_PATH}| grep PROJMAKE_WORKSPACE | cut -d'=' -f 2 | cut -d' ' -f 2`
# else
#   # Get workspace from projmake. Verrry slow
#   WORKSPACE="`projmake --printenv=PROJMAKE_WORKSPACE`"
# fi

# Restrict gtests to the project currently being worked on, eg. ibfido,
# libraries, arbiters, etc...
PROJECT_PATH="`pwd`"
PROJECT="`basename ${PROJECT_PATH}`"

# Only run tests for the platform which we are invoked on.
PLATFORM="`uname`"

BUILD_DIR="${WORKSPACE}/build/${PROJECT}/${PLATFORM}*/${PATTERN}"

echo -e "Running tests in ${Blue}${BUILD_DIR}${ColorReset} for ${Cyan}${PLATFORM}${ColorReset}."

for TSK in `find ${BUILD_DIR} -type f -name "*test*.tsk"`;
do
  RUN_CMD="${TSK} --gtest_color=yes"
  ECHORUNSTR="${TSK} --gtest_color=yes"
  if [[ "${PATTERN}" ]]; then
    ECHORUNSTR="${ECHORUNSTR/${PATTERN}/${BPurple}${PATTERN}${ColorReset}}"
  fi

  if [[ "${GTEST_FILTER}" ]]; then
    ECHORUNSTR="${ECHORUNSTR} --gtest_filter=${Red}${GTEST_FILTER}${ColorReset}"
    RUN_CMD="${RUN_CMD} --gtest_filter=${GTEST_FILTER}*"
  fi
  echo -e "Running ${Green}${ECHORUNSTR}${ColorReset}"

  if [[ ${DRY_RUN} -eq 0 ]]; then
    ${RUN_CMD}
  fi
done
