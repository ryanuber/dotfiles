#!/bin/bash
set -e

gsed -i /chruby-start/,/chruby-end/d $PROFILE
cat >> $PROFILE <<EOF
# chruby-start
. ~/.local/share/chruby/chruby.sh
# chruby-end
EOF

brew install chruby ruby-install
