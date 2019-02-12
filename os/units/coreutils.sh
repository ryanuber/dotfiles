#!/bin/bash
set -e

case $OS in
mac)
    brew install coreutils gnu-sed gnu-tar
    ;;
fedora)
    sudo dnf install gcc-c++ redhat-lsb-core
    ;;
esac
