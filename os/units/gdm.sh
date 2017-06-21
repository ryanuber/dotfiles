#!/bin/bash
set -e

# Set automatic login. Assumes disk encryption requires a pw, otherwise
# this would be a terrible idea.
cat <<EOF | sudo tee /etc/gdm/custom.conf
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=$USER

# With a heavy heart, we disable Wayland. This means dual-screens with
# different DPI settings will just not work. However, we need Zoom and
# Google Hangouts screen sharing to actually work, which is impossible
# in Wayland currently.
WaylandEnable = false
EOF

