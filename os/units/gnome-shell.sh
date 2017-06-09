#!/bin/bash
set -e

# Disable fancy animations
gsettings set org.gnome.desktop.interface enable-animations false

# Why topicons isn't built into the Gnome shell, I know not.
sudo dnf install -y gnome-shell-extension-topicons-plus
gnome-shell-extension-tool -e TopIcons@phocean.net

# Configure mouse settings
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.mouse speed -0.6
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true

# Configure gnome-terminal
SCHEMA=org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/
gsettings set $SCHEMA prev-tab '<Primary>Left'
gsettings set $SCHEMA next-tab '<Primary>Right'
gsettings set $SCHEMA new-tab '<Primary>t'
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
