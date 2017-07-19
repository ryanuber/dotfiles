#!/bin/bash
set -e

if [ `uname` == 'Darwin' ]; then
    export OS='mac'
    export PROFILE=$HOME/.profile
else
    export OS=`lsb_release -is | tr '[:upper:]' '[:lower:]'`
    export PROFILE=$HOME/.bashrc
fi
SCRIPT="${OS}.sh"

if ! [ -f $SCRIPT ]; then
    echo "$SCRIPT not found - exiting"
    exit 1
fi

/bin/bash $SCRIPT
