#!/bin/bash
set -e

case $OS in
mac)
    GOLANG_ARCH=darwin-amd64
    SED=gsed
    ;;
*)
    GOLANG_ARCH=linux-amd64
    SED=sed
    ;;
esac

GOLANG_VERSION=1.8.1
GOLANG_URL="https://storage.googleapis.com/golang/go${GOLANG_VERSION}.${GOLANG_ARCH}.tar.gz"

case $OS in
ubuntu)
    sudo apt-get install -y curl
    ;;
esac

FILE=`mktemp`

rm -rf ~/.goroot
mkdir -p ~/go ~/.goroot
curl -o $FILE $GOLANG_URL
tar -C ~/.goroot -zxvf $FILE

$SED -i /golang-start/,/golang-end/d $PROFILE
cat >> $PROFILE <<EOF
# golang-start
export GOROOT=\$HOME/.goroot/go
export GOPATH=\$HOME/go
export PATH=\$GOROOT/bin:\$GOPATH/bin:\$PATH
# golang-end
EOF
