#!/bin/bash
set -e

# Configure GRUB boot loader.
case $OS in
fedora)
    sudo sed -i 's|GRUB_TIMEOUT=.*|GRUB_TIMEOUT=1|' /etc/default/grub
    sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
    ;;
esac
