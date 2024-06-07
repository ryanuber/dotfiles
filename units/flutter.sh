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

gsed -i /flutter-start/,/flutter-end/d $PROFILE
cat >>$PROFILE <<EOF
# flutter-start
export PATH=$FLUTTER_SDK_DIR/flutter/bin:\$PATH
# flutter-end
EOF
