#!/bin/bash
set -e

case $OS in
mac)
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ;;
esac
