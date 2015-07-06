#!/bin/bash

echo "PWD = ${PWD}"
#TASK="/bb/bin/ibhistbackfill.tsk"
#TASK="/home/praman6/ib/bin/ibhistbackfill.sundev1.tsk"
TASK="/home/mbuchmoyer/workspace/build/ibhistbackfill/AIX-powerpc-64/src/m_ibhistbackfill/ibhistbackfill.ibm_64.tsk"
CONFIG_FILE="/home/mbuchmoyer/workspace/ibhistbackfill/src/m_ibhistbackfill/ibhistbackfill.cfg"
#CONFIG_FILE="/bb/bin/ibhistbackfill.cfg"
#START_TIME="2014/12/23_00:00:00"
#END_TIME="2014/12/23_23:00:00"
#JOURNAL_DIR="/bb/logs/ibtmonad_saved_journals"
# COMMIT="--noCommit"
COMMIT=""
START_TIME="2015/05/07_00:00:00"
END_TIME="2015/05/07_23:59:59"
JOURNAL_DIR="/home/mbuchmoyer/workspace/data/journal_dir"
#   --sourceMach 66 \

CMD="${TASK} \
  ${COMMIT} \
  --configFile ${CONFIG_FILE} \
  --startTime ${START_TIME} \
  --endTime ${END_TIME} \
  --journalDir ${JOURNAL_DIR}"

if [[ $1 == "-n" ]]; then
  echo ${CMD}
else
  ${CMD}
fi

#~/ib/bin/ibhistbackfill.sundev1.tsk \
#  --configFile ~/ib/repos/applications/ibhistbackfill/ibhistbackfill.cfg \
#  --startTime 2014/12/23_00:00:00 \
#  --endTime 2014/12/23_23:00:00 \
#  --journalDir /bb/logs/ibtmonad_urn_journals

#  --noCommit \
