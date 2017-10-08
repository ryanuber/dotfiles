#!/bin/bash
set -e

case $OS in
mac)
    brew install coreutils gnu-sed
    ;;
esac
