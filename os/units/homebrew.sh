#!/bin/bash
set -e

case $OS in
mac)
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/ryan/.profile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
esac
