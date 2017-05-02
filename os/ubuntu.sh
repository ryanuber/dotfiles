#!/bin/bash
set -e

UNITS=(
    aws
    dns
    envchain
    ruby
    silversearcher
)

for UNIT in ${UNITS[@]}; do
    echo "== Running unit ${UNIT} ==========================="
    /bin/bash units/${UNIT}.sh
    echo "== Unit ${UNIT} completed ========================="
done