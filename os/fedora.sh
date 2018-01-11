#!/bin/bash
set -e

UNITS=(
    coreutils
    aws
    chrome
    dns
    envchain
    gdm
    gnome-shell
    golang
    grub
    neovim
    powerline-fonts
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
