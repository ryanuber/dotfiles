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

cp ../bin/j $HOME/bin/j
$SED -i /j-start/,/j-end/d $PROFILE
cat >> $PROFILE <<EOF
# j-start
export J_SEARCHDIRS="\$HOME/git:\$GOPATH/src/*/*"
. $HOME/bin/j
# j-end
EOF
