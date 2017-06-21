#!/bin/bash
set -e

case $OS in
ubuntu)
    sudo apt-get install -y dnsmasq
    ;;

fedora)
    sudo dnf install -y dnsmasq
    ;;
esac

# Disable dnsmasq so we can use the NetworkManager integration.
sudo systemctl disable dnsmasq

# Enable the dnsmasq integration in NetworkManger.
sudo sed -i /^dns=/d /etc/NetworkManager/NetworkManager.conf
sudo tee /etc/NetworkManager/conf.d/00-dnsmasq.conf <<EOF
[main]
dns=dnsmasq
EOF

# Ensure the config dir exists.
sudo mkdir -p /etc/NetworkManager/dnsmasq.d

# Write the prod VPN config file.
sudo tee /etc/NetworkManager/dnsmasq.d/prod.conf <<EOF
server=/.consul/10.181.1.4
server=/.consul/10.181.2.4
server=/.consul/10.181.3.4

server=/.consul/10.151.1.8
server=/.consul/10.181.2.8
server=/.consul/10.181.3.8
EOF

# Write the Oasis vpn config file.
sudo tee /etc/NetworkManager/dnsmasq.d/oasis.conf <<EOF
server=/.consul/10.151.1.4
server=/.consul/10.151.2.4
server=/.consul/10.151.3.4

server=/.consul/10.151.1.8
server=/.consul/10.151.2.8
server=/.consul/10.151.3.8
EOF

# Ensure the nsswitch.conf hosts setting is correct.
sudo sed -i /^hosts:/d /etc/nsswitch.conf
echo "hosts: files dns resolve myhostname" | sudo tee -a /etc/nsswitch.conf
