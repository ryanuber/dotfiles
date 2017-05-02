#!/bin/bash
set -e

UNITS=(
    aws
    chrome
    dns
    envchain
    golang
    ruby
    silversearcher
    slack
    zoom
)

for UNIT in ${UNITS[@]}; do
    echo "== Running unit ${UNIT} ==========================="
    /bin/bash units/${UNIT}.sh
    echo "== Unit ${UNIT} completed ========================="
done
