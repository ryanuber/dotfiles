#!/bin/bash
set -e

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv)"
write_env homebrew <<EOF
eval "\$(/opt/homebrew/bin/brew shellenv)"
EOF
