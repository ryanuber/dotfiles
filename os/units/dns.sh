#!/bin/bash
set -e

case $OS in
ubuntu)
    sudo apt-get install -y dnsmasq
    sudo systemctl enable dnsmasq
    sudo tee /etc/dnsmasq.conf <<EOF
no-negcache
bind-interfaces
listen-address=127.0.0.1
server=/.consul/10.181.1.4
server=/.consul/10.151.1.8
server=/.consul/10.181.2.4
server=/.consul/10.181.2.8
server=/.consul/10.181.3.4
server=/.consul/10.181.3.8
EOF
    ;;
esac

sudo sed -i /^hosts:/d /etc/nsswitch.conf
echo "hosts: files dns resolve myhostname" | sudo tee -a /etc/nsswitch.conf
