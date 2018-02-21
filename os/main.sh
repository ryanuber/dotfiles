#!/bin/bash
set -e

case $1 in
-unit)
    shift
    TARGET_UNIT=$1
    ;;
-list-units)
    LIST_UNITS=1
    ;;
-full)
    FULL=1
    ;;
esac

if [ -z "${TARGET_UNIT}${LIST_UNITS}${FULL}" ]; then
    echo "Usage:"
    echo "./main.sh [-unit UNIT] [-list-units] [-full]"
    exit 1
fi

if [ `uname` == 'Darwin' ]; then
    export OS='mac'
    export PROFILE=$HOME/.profile
else
    export OS=`lsb_release -is | tr '[:upper:]' '[:lower:]'`
    export PROFILE=$HOME/.bashrc
fi
OS_SCRIPT="${OS}.sh"

if ! [ -f $OS_SCRIPT ]; then
    echo "$OS_SCRIPT not found - exiting"
    exit 1
fi

source $OS_SCRIPT

if [ -n "$LIST_UNITS" ]; then
    for UNIT in ${UNITS[@]}; do
        echo $UNIT
    done
    exit 0
fi

for UNIT in ${UNITS[@]}; do
    if [ -z "$TARGET_UNIT" -o "$UNIT" == "$TARGET_UNIT" ]; then
        echo "== Running unit ${UNIT} ==========================="
        /bin/bash units/${UNIT}.sh
        echo "== Unit ${UNIT} completed ========================="
    fi
done
