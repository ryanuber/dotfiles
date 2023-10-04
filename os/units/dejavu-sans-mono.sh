#!/bin/bash
set -e

FONT_URL=http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.zip

INSTALL_DIR=$HOME/Library/Fonts

TEMPFILE=$(mktemp)
curl -o $TEMPFILE -L $FONT_URL
unzip -j -d $INSTALL_DIR $TEMPFILE */ttf/DejaVuSansMono.ttf
rm -f $TEMPFILE
