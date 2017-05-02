#!/bin/bash
set -e

case $OS in
ubuntu)
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install -y neovim
    ;;

fedora)
    sudo dnf install neovim
    ;;
esac
