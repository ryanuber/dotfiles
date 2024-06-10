#!/bin/bash
set -e

write_env key-bindings <<EOF
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
EOF

write_env gitprompt <<EOF
source ~/.gitprompt
EOF

write_env local-bin <<EOF
export PATH=\$PATH:\$HOME/bin:\$HOME/.local/bin
EOF
