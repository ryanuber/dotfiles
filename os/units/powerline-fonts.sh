#!/bin/bash
set -e

FONT_URL=https://raw.githubusercontent.com/powerline/fonts/master/UbuntuMono/Ubuntu%20Mono%20derivative%20Powerline%20Bold.ttf

INSTALL_DIR=$HOME/.local/share/fonts

mkdir -p $INSTALL_DIR
pushd $INSTALL_DIR
curl -OL $FONT_URL
popd

fc-cache -f -v
