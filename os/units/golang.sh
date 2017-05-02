#!/bin/bash
set -e

GOLANG_VERSION=1.8.1
GOLANG_URL="https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz"

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

sed -i /golang-start/,/golang-end/d ~/.bashrc
cat >> ~/.bashrc <<EOF
# golang-start
export GOROOT=\$HOME/.goroot/go
export GOPATH=\$HOME/go
export PATH=\$GOROOT/bin:\$GOPATH/bin:\$PATH
# golang-end
EOF
