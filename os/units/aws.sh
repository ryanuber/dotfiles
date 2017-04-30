#!/bin/bash
set -e

case $OS in
ubuntu)
    sudo apt-get install -y awscli python-pip
    ;;

fedora)
    sudo dnf install awscli
    ;;
esac

pip install awslogs
