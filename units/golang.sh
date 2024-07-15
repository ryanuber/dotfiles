#!/bin/bash
set -e

GOBASE=$HOME/.go
GOROOT=$GOBASE/root
GOPATH=$GOBASE/path

GOLANG_ARCH=darwin-arm64

GOLANG_VERSION=1.22.5
GOLANG_URL="https://storage.googleapis.com/golang/go${GOLANG_VERSION}.${GOLANG_ARCH}.tar.gz"

FILE=`mktemp`

rm -rf $GOROOT
mkdir -p $GOROOT $GOPATH
curl -o $FILE $GOLANG_URL
gtar -C $GOROOT --wildcards --anchored --strip-components=1 -zxvf $FILE go/*

write_env golang <<EOF
export GOROOT=$GOROOT
export GOPATH=$GOPATH
export PATH=$GOROOT/bin:$GOPATH/bin:\$PATH
EOF
