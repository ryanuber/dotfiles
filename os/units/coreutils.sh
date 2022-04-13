#!/bin/bash
set -e

case $OS in
mac)
    brew install coreutils gnu-sed gnu-tar tree
    ;;
fedora)
    sudo dnf install gcc-c++ redhat-lsb-core
    ;;
esac
