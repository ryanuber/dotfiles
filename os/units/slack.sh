#!/bin/bash
set -e

SLACK_VERSION=2.5.2
SLACK_BASE_URL=https://downloads.slack-edge.com/linux_releases

case $OS in
ubuntu)
    ARTIFACT="slack-desktop-${SLACK_VERSION}-amd64.deb"
    FILE=`mktemp`.deb
    sudo apt-get install -y curl
    curl -L -o $FILE "${SLACK_BASE_URL}/${ARTIFACT}"
    sudo apt-get -y install -f $FILE
    rm -f $FILE
    ;;

fedora)
    ARTIFACT="slack-${SLACK_VERSION}-0.1.fc21.x86_64.rpm"
    sudo dnf install "${SLACK_BASE_URL}/${ARTIFACT}"
    ;;
esac
