#!/bin/bash
set -e

case $OS in
ubuntu)
    sudo apt-get install -y neovim
    ;;

fedora)
    sudo dnf install -y neovim
    ;;
esac
