#!/bin/bash
set -e

case $OS in
ubuntu)
    sudo apt-get install -y libsecret-1-dev libreadline-dev curl unzip
    ;;

fedora)
    sudo dnf install -y libsecret-devel readline-devel unzip
    ;;
esac

DIR=`mktemp -d`

pushd $DIR
curl -OL https://github.com/sorah/envchain/archive/master.zip
unzip master.zip
cd envchain-master
make
make DESTDIR=$HOME install
popd

rm -rf $DIR
