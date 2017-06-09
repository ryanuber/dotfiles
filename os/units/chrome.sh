#!/bin/bash
set -e

CHROME_BASE_URL=https://dl.google.com/linux/direct/

case $OS in
ubuntu)
    FILE=`mktemp`.deb
    sudo apt-get install -y curl
    curl -L -o $FILE "${CHROME_BASE_URL}/google-chrome-stable_current_amd64.deb"
    sudo apt-get -y install -f $FILE
    rm -f $FILE
    ;;

fedora)
    sudo dnf install -y "${CHROME_BASE_URL}/google-chrome-stable_current_x86_64.rpm"
    ;;
esac
