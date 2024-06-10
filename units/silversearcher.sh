#!/bin/sh

brew install the_silver_searcher

write_env silversearcher <<EOF
alias ag='ag --color-match "38;5;222" --color-line-number "38;5;240" --color-path "38;5;47"'
export FZF_DEFAULT_COMMAND='ag -Q -l --nocolor --hidden -g ""'
EOF
