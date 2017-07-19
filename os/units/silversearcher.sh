#!/bin/sh

case $OS in
ubuntu)
    sudo apt-get -y install silversearcher-ag
    ;;

fedora)
    sudo dnf install -y the_silver_searcher
    ;;

mac)
    brew install the_silver_searcher
    ;;
esac
