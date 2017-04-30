#!/bin/bash
set -e

export OS=`lsb_release -is | tr '[:upper:]' '[:lower:]'`
SCRIPT="${OS}.sh"

if ! [ -f $SCRIPT ]; then
    echo "$SCRIPT not found - exiting"
    exit 1
fi

/bin/bash $SCRIPT
