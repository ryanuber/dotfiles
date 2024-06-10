#!/bin/bash
set -e

brew install coreutils gnu-sed gnu-tar tree

write_env coreutils <<EOF
alias ls='gls --color=auto'
alias sed='gsed'
alias date='gdate'
export LS_COLORS='di=38;5;75:ln=38;5;170:ex=38;5;47:st=48;5;57;38;5;75:tw=48;5;53;38;5;75:ow=48;5;125;38;5;75:cd=38;5;221:bd=38;5;209'
EOF
