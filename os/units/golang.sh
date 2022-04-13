#!/bin/bash
set -e

GOBASE=$HOME/.go
GOROOT=$GOBASE/root
GOPATH=$GOBASE/path

case $OS in
mac)
    GOLANG_ARCH=darwin-amd64
    SED=gsed
    TAR=gtar
    ;;
*)
    GOLANG_ARCH=linux-amd64
    SED=sed
    TAR=tar
    ;;
esac

GOLANG_VERSION=1.18
GOLANG_URL="https://storage.googleapis.com/golang/go${GOLANG_VERSION}.${GOLANG_ARCH}.tar.gz"

case $OS in
ubuntu)
    sudo apt-get install -y curl
    ;;
esac

FILE=`mktemp`

rm -rf $GOROOT
mkdir -p $GOROOT $GOPATH
curl -o $FILE $GOLANG_URL
$TAR -C $GOROOT --wildcards --anchored --strip-components=1 -zxvf $FILE go/*

$SED -i /golang-start/,/golang-end/d $PROFILE
cat >> $PROFILE <<EOF
# golang-start
export GOROOT=$GOROOT
export GOPATH=$GOPATH
export PATH=$GOROOT/bin:$GOPATH/bin:\$PATH
# golang-end
EOF
