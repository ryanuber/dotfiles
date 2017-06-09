#!/bin/bash
set -e

# Enable user themes.
sudo dnf install -y gnome-shell-extension-user-theme
gnome-shell-extension-tool -e user-theme@gnome-shell-extensions.gcampax.github.com

# Disable fancy animations
gsettings set org.gnome.desktop.interface enable-animations false

# Why topicons isn't built into the Gnome shell, I know not.
sudo dnf install -y gnome-shell-extension-topicons-plus
gnome-shell-extension-tool -e TopIcons@phocean.net || :

# Disable top hot corner. Also not sure why this is not a built-in option.
sudo dnf install -y gnome-shell-extension-no-topleft-hot-corner
gnome-shell-extension-tool -e nohotcorner@azuri.free.fr || :

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

# Configure the gnome weather shell extension
sudo dnf install -y gnome-shell-extension-openweather
SCHEMA=org.gnome.shell.extensions.openweather
gsettings set $SCHEMA unit fahrenheit
gsettings set $SCHEMA wind-speed-unit mph
gsettings set $SCHEMA pressure-unit psi
gsettings set $SCHEMA refresh-interval-current 600
gsettings set $SCHEMA refresh-interval-forecast 3600
gsettings set $SCHEMA appid-fc 2191ed80fb23838ebede43bc19580b7f
gsettings set $SCHEMA weather-provider darksky.net
gsettings set $SCHEMA city '33.1968352521268,-117.285215120784>Oceanside, San Diego County, California, 92056, United States of America >-1'
gnome-shell-extension-tool -e openweather-extension@jenslody.de || :

# Use a flat, dark theme for the shell.
mkdir -p ~/.themes
TEMPDIR=$(mktemp -d)
pushd $TEMPDIR
git clone https://github.com/nerdbeere/flat-dark-gnome-theme
mv flat-dark-gnome-theme/flat-dark ~/.themes
popd
rm -rf $TEMPDIR
gsettings set org.gnome.shell.extensions.user-theme name 'flat-dark'
