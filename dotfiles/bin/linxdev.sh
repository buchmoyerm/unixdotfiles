#!/bin/bash

NUM_TERMS=1
INDEX=0

while getopts "i:n:h" opt; do
  case $opt in
    i)
      INDEX=$OPTARG
      echo "Index ${INDEX}"
      ;;
    n)
      NUM_TERMS=$OPTARG
      echo "Number of terminals ${NUM_TERMS}"
      ;;
    h)
      echo "-n Number of terminals                  "
      echo "-i Index by which X and Y will be moved"
      echo "-h Prints this usage                    "
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ERROR=1
      ;;
  esac
done

XS=(1480 2840 1450 1940)
YS=(20 20 330 130)
COLS=(140 110 200 320)
ROWS=(50 70 70 40)

if [ "${ERROR}" == 1 ]; then
  exit 1
fi

if [ "${INDEX}" -gt "${NUM_TERMS}" ]; then
  echo "i should be less then n."
  exit 1
fi

case "${NUM_TERMS}" in
1 )
  ;;
2 )
  ;;
3 )
  ;;
4 )
  ;;
* )
  echo "Valid -i values are 0, 1, 2 & 3." >&2
  exit 1
esac

PAUSE_TIME=1
i=${INDEX}
while [ ${i} -lt ${NUM_TERMS} ]; do

  xterm -geometry ${COLS[${i}]}x${ROWS[${i}]}+${XS[${i}]}+${YS[${i}]} &

  i=$((i + 1))
  sleep ${PAUSE_TIME}
done
