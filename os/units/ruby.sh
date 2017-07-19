#!/bin/bash
set -e

case $OS in
mac)
    SED=gsed
    ;;
*)
    SED=sed
    ;;
esac

$SED -i /chruby-start/,/chruby-end/d $PROFILE
cat >> $PROFILE <<EOF
# chruby-start
. ~/.local/share/chruby/chruby.sh
# chruby-end
EOF

case $OS in
ubuntu)
    sudo apt-get install -y curl unzip
    ;;

fedora)
    sudo dnf install -y unzip
    ;;

macos)
    brew install chruby ruby-install
    exit $?
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
