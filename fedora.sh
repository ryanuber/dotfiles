#!/bin/bash
set -xe

AVATAR_URL=https://gravatar.com/avatar/c55cecc94ea228ef48787481b2355575?s=96
WALLPAPER_URL=http://www.hdwallpapers.in/walls/amazing_milky_way-wide.jpg
TERMINAL_FONT_URL=https://github.com/powerline/fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf

PUBKEYS=(
    https://zoom.us/linux/download/pubkey
)

EXTERNAL_REPO_RPMS=(
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-25.noarch.rpm
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-25.noarch.rpm
)

INSTALL_PACKAGES=(
    awscli
    chromium
    gnome-shell-extension-openweather
    git
    gstreamer1-libav
    gstreamer1-plugin-mpg123
    gstreamer1-plugin-openh264
    gstreamer1-plugins-bad-freeworld
    jq
    libsecret-devel
    mpg123-libs
    neovim
    powertop
    readline-devel
    redis
    shutter
    simple-scan
    the_silver_searcher
    tlp
    transmission
    uuid
    https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.rpm
    https://downloads.slack-edge.com/linux_releases/slack-2.3.4-0.1.fc21.x86_64.rpm
    https://zoom.us/client/latest/zoom_x86_64.rpm
)

INSTALL_GROUPS=(
    "C Development Tools and Libraries"
)

REMOVE_PACKAGES=(
    PackageKit-command-not-found
    firefox
)

PIP_PACKAGES=(
    awslogs
)

DISABLE_SERVICES=(
    atd
    avahi-daemon
    bluetooth
    gssproxy
    ModemManager
)

GOLANG_URL=https://storage.googleapis.com/golang/go1.7.5.linux-amd64.tar.gz

# Install public keys
for PUBKEY_URL in ${PUBKEYS[@]}; do
    sudo rpm --import $PUBKEY_URL
done

# Purge unnecessary software packages.
sudo dnf remove -y ${REMOVE_PACKAGES[@]} || :

# Install external repos
sudo dnf install -y ${EXTERNAL_REPO_RPMS[@]}

# Enable Cisco openh264 repo
sudo dnf config-manager --set-enabled fedora-cisco-openh264

# Update all packages installed by default.
sudo dnf update -y

# Install software packages.
sudo dnf install -y ${INSTALL_PACKAGES[@]}
for GROUP in "${INSTALL_GROUPS[@]}"; do
    sudo dnf groupinstall -y "${GROUP}"
done

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

# Install pip packages
for PKG in ${PIP_PACKAGES[@]}; do
    pip install --user $PKG
done

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

# Set up the terminal profiles
eval DEFAULT_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default)
MONITOR_PROFILE=$(uuidgen)

gsettings set org.gnome.Terminal.ProfilesList list "['$DEFAULT_PROFILE','$MONITOR_PROFILE']"

for PROFILE in $DEFAULT_PROFILE $MONITOR_PROFILE; do
    SCHEMA=org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/

    if [ $PROFILE == $MONITOR_PROFILE ]; then
        FONT_SIZE=11
        PROFILE_NAME=monitor
    else
        FONT_SIZE=10
        PROFILE_NAME=$USER
    fi

    gsettings set $SCHEMA visible-name $PROFILE_NAME
    gsettings set $SCHEMA use-theme-colors false
    gsettings set $SCHEMA foreground-color 'rgb(255,255,255)'
    gsettings set $SCHEMA scrollback-unlimited true
    gsettings set $SCHEMA use-system-font false
    gsettings set $SCHEMA font "DejaVu Sans Mono for Powerline $FONT_SIZE"
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
done

# Configure the desktop environment.
WALLPAPER_FILE=$HOME/Pictures/$(basename $WALLPAPER_URL)
curl -o $WALLPAPER_FILE -L $WALLPAPER_URL
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_FILE"
gsettings set org.gnome.desktop.screensaver picture-uri "file://$WALLPAPER_FILE"
gsettings set org.gnome.desktop.interface clock-format '12h'
SCHEMA=org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application
gsettings set $SCHEMA/abrt-applet/ enable false

# Set the user profile details.
sudo curl -o /var/lib/AccountsService/icons/$USER -L $AVATAR_URL
sudo sed -i "/^Icon=.*/d" /var/lib/AccountsService/users/$USER
echo "Icon=/var/lib/AccountsService/icons/$USER" | sudo tee -a /var/lib/AccountsService/users/$USER

# Configure zoom client.
zoom &
sleep 3
killall zoom
sqlite3 ~/.zoom/data/zoomus.db <<EOF
UPDATE zoom_kv
SET value = "338432784"
WHERE key == "com.zoom.pt.settings.general";

UPDATE zoom_kv
SET value = "false"
WHERE key == "com.zoom.agc";
EOF

# Configure GRUB boot loader.
sudo sed -i 's|GRUB_TIMEOUT=.*|GRUB_TIMEOUT=1|' /etc/default/grub
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

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

# Install envchain.
mkdir -p ~/git
git clone https://github.com/sorah/envchain ~/git/envchain
pushd ~/git/envchain
make
make DESTDIR=$HOME install
popd

# Install chruby.
git clone https://github.com/postmodern/chruby ~/git/chruby
pushd ~/git/chruby
make PREFIX=$HOME/.local install
popd
cat >> ~/.bashrc <<EOF
# Source chruby helper
. ~/.local/share/chruby/chruby.sh
EOF

# Install ruby-installer.
git clone https://github.com/postmodern/ruby-install ~/git/ruby-install
pushd ~/git/ruby-install
make PREFIX=$HOME/.local install
popd

# Install the flash plugin.
FLASH_PLUGIN_URL=https://fpdownload.adobe.com/pub/flashplayer/pdc/24.0.0.194/flash_player_ppapi_linux.x86_64.tar.gz
curl -L $FLASH_PLUGIN_URL \
    | sudo tar -C /usr/lib64/chromium-browser/PepperFlash -zxvf -

# Configure the gnome weather shell extension
SCHEMA=org.gnome.shell.extensions.openweather
gsettings set $SCHEMA unit fahrenheit
gsettings set $SCHEMA wind-speed-unit mph
gsettings set $SCHEMA pressure-unit psi
gsettings set $SCHEMA refresh-interval-current 600
gsettings set $SCHEMA refresh-interval-forecast 3600
gsettings set $SCHEMA appid-fc 2191ed80fb23838ebede43bc19580b7f
gsettings set $SCHEMA weather-provider darksky.net
gsettings set $SCHEMA city '33.1968352521268,-117.285215120784>Oceanside, San Diego County, California, 92056, United States of America >-1'
gnome-shell-extensions-tool -e openweather-extension@jenslody.de

# Install/configure topicons plus
git clone https://github.com/phocean/TopIcons-plus ~/git/TopIcons-plus
pushd ~/git/TopIcons-plus
gnome-shell-extension-tool -e TopIcons@phocean.net
popd


# Disable selinux. It's not ready for the desktop.
sudo sed -i s/SELINUX=.*/SELINUX=disabled/g /etc/selinux/config

# Audio bridge auto-poweroff on battery.
sudo sed -i s/^SOUND_POWER_SAVE_ON_BAT=.*/SOUND_POWER_ON_BAT=300/g /etc/default/tlp

# Configure shutter screenshots
mkdir -p ~/.shutter
cat > ~/.shutter/drawingtool.xml <<EOF
<opt>
  <drawing autoscroll="" fill_color="#00000000ffff" fill_color_alpha="0.160262660734963" font="Sans Regular 16" height="785" line_width="10" mode="60" stroke_color="#ffff00000000" stroke_color_alpha="1" width="1281" x="639" y="327" />
</opt>
EOF
