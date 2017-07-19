#!/bin/bash
set -e

case $OS in
ubuntu)
    sudo apt-get install -y awscli python-pip
    ;;

fedora)
    sudo dnf install -y awscli
    ;;

mac)
    brew install awscli awslogs
    exit $?
    ;;
esac

pip install --user awslogs
