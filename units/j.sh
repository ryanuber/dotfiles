#!/bin/bash
set -e

write_env j <<EOF
$(cat units/j/j.sh)
export J_SEARCHDIRS=\$HOME/code${J_SEARCHDIRS##\$HOME/code}
EOF
