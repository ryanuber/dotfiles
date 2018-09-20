#!/bin/bash
set -e

FONT_URL=https://github.com/powerline/fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf

INSTALL_DIR=$HOME/.local/share/fonts

mkdir -p $INSTALL_DIR
pushd $INSTALL_DIR
curl -OL $FONT_URL
popd

fc-cache -f -v
