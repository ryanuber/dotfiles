#!/bin/bash
set -xe

AVATAR_URL=https://gravatar.com/avatar/c55cecc94ea228ef48787481b2355575?s=96
WALLPAPER_URL=http://www.hdwallpapers.in/walls/amazing_milky_way-wide.jpg
TERMINAL_FONT_URL=https://github.com/powerline/fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf

PUBKEYS=(
    https://zoom.us/linux/download/pubkey
)

INSTALL_PACKAGES=(
    chromium
    git
    neovim
    tlp
    transmission
    https://downloads.slack-edge.com/linux_releases/slack-2.3.4-0.1.fc21.x86_64.rpm
    https://zoom.us/client/latest/zoom_x86_64.rpm
)

REMOVE_PACKAGES=(
    PackageKit-command-not-found
    firefox
)

DISABLE_SERVICES=(
    atd
    avahi-daemon
    bluetooth
    gssproxy
    ModemManager
)

GOLANG_URL=https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz

# Install public keys
for PUBKEY_URL in ${PUBKEYS[@]}; do
    sudo rpm --import $PUBKEY_URL
done

# Update all packages installed by default.
sudo dnf update -y

# Install software packages.
sudo dnf install -y ${INSTALL_PACKAGES[@]}

# Purge unnecessary software packages.
sudo dnf remove -y ${REMOVE_PACKAGES[@]} || :

# Disable unused services.
for SERVICE in ${DISABLE_SERVICES[@]}; do
    sudo systemctl disable $SERVICE
done

# Install golang
mkdir -p ~/go ~/.goroot
curl -o /tmp/golang.tar.gz $GOLANG_URL
tar -C ~/.goroot -zxvf /tmp/golang.tar.gz
cat >> ~/.bashrc <<EOF
# Golang
export GOROOT=\$HOME/.goroot/go
export GOPATH=\$HOME/go
export PATH=\$GOROOT/bin:\$GOPATH/bin:\$PATH
EOF

# Set up powerline font for neovim
mkdir -p ~/.local/share/fonts
pushd ~/.local/share/fonts
wget $TERMINAL_FONT_URL
fc-cache -f -v
popd

# Configure the mouse settings
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

# Set up the terminal profile
eval PROFILE=:$(gsettings get org.gnome.Terminal.ProfilesList default)
SCHEMA=org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/$PROFILE/
gsettings set $SCHEMA visible-name $USER
gsettings set $SCHEMA use-theme-colors false
gsettings set $SCHEMA foreground-color 'rgb(255,255,255)'
gsettings set $SCHEMA scrollback-unlimited true
gsettings set $SCHEMA use-system-font false
gsettings set $SCHEMA font 'DejaVu Sans Mono for Powerline 10'
gsettings set $SCHEMA default-size-columns 90
gsettings set $SCHEMA default-size-rows 40
gsettings set $SCHEMA palette "
[
    'rgb(85,87,83)',
    'rgb(239,41,41)',
    'rgb(138,226,52)',
    'rgb(252,233,79)',
    'rgb(114,159,207)',
    'rgb(173,127,168)',
    'rgb(52,226,226)',
    'rgb(211,215,207)',
    'rgb(85,87,83)',
    'rgb(239,41,41)',
    'rgb(138,226,52)',
    'rgb(252,233,79)',
    'rgb(114,159,207)',
    'rgb(173,127,168)',
    'rgb(52,226,226)',
    'rgb(238,238,236)'
]"

# Configure the desktop environment.
WALLPAPER_FILE=$HOME/Pictures/$(basename $WALLPAPER_URL)
curl -o $WALLPAPER_FILE -L $WALLPAPER_URL
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_FILE"
gsettings set org.gnome.desktop.screensaver picture-uri "file://$WALLPAPER_FILE"

# Set the user profile details.
sudo curl -o /var/lib/AccountsService/icons/$USER -L $AVATAR_URL
sudo sed -i "s|^Icon=.*|Icon=/var/lib/AccountsService/icons/$USER|" /var/lib/AccountsService/users/$USER

# Configure zoom client.
zoom &
sleep 3
killall zoom
sqlite3 ~/.zoom/data/zoomus.db <<EOF
UPDATE zoom_kv
SET value = 338432272
WHERE key == "com.zoom.pt.settings.general";
EOF

# Configure GRUB boot loader.
sudo sed -i 's|GRUB_TIMEOUT=.*|GRUB_TIMEOUT=1|' /etc/default/grub
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
