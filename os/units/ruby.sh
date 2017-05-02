#!/bin/bash
set -e

case $OS in
ubuntu)
    sudo apt-get install -y curl unzip
    ;;

fedora)
    sudo dnf install unzip
    ;;
esac

for PROG in chruby ruby-install; do
    DIR=`mktemp -d`

    pushd $DIR
    curl -OL "https://github.com/postmodern/$PROG/archive/master.zip"
    unzip master.zip
    cd "${PROG}-master"
    make PREFIX=$HOME/.local SHARE=$HOME/.local/share install
    popd

    rm -rf $DIR
done

sed -i /chruby.sh$/d ~/.bashrc
echo ". ~/.local/share/chruby/chruby.sh" >> ~/.bashrc
