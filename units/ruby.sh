#!/bin/bash
set -e

brew install chruby ruby-install
write_env ruby <<EOF
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
EOF
