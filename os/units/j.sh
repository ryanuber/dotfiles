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

$SED -i /j-start/,/j-end/d $PROFILE
cat >> $PROFILE <<EOF
# j-start
export J_SEARCHDIRS="\$HOME:\$GOPATH/src/*/*"
# j-end
EOF
