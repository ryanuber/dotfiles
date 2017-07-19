#!/bin/bash
set -e

UNITS=(
    homebrew
    coreutils
    aws
    envchain
    golang
    neovim
    ruby
    silversearcher
)

for UNIT in ${UNITS[@]}; do
    echo "== Running unit ${UNIT} ==========================="
    /bin/bash units/${UNIT}.sh
    echo "== Unit ${UNIT} completed ========================="
done
