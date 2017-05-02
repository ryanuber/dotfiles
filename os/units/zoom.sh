#!/bin/bash
set -e

ZOOM_BASE_URL=https://zoom.us/client/latest

case $OS in
ubuntu)
    FILE=`mktemp`.deb
    sudo apt-get install -y curl
    curl -L -o $FILE "${ZOOM_BASE_URL}/zoom_amd64.deb"
    sudo apt-get -y install -f $FILE
    rm -f $FILE
    ;;

fedora)
    sudo dnf install "${ZOOM_BASE_URL}/zoom_x86_64.rpm"
    ;;
esac
