#!/bin/bash
set -e

FLUTTER_SDK_DIR=$HOME/.flutter-sdk
FLUTTER_ARCH=arm64
FLUTTER_VERSION=3.22.2-stable
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_${FLUTTER_ARCH}_${FLUTTER_VERSION}.zip"

FILE=`mktemp`

rm -rf $FLUTTER_SDK_DIR
mkdir -p $FLUTTER_SDK_DIR
curl -o $FILE $FLUTTER_URL
unzip -d $FLUTTER_SDK_DIR $FILE
rm -f $FILE

write_env flutter <<EOF
export PATH=$FLUTTER_SDK_DIR/flutter/bin:\$PATH
export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
EOF
