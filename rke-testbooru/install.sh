#!/bin/sh

# This script installs Vagrant, vagrant-libvirt, and RKE.
# Usage: sudo ./install.sh $(whoami)

# https://www.vagrantup.com/docs/installation
# https://github.com/vagrant-libvirt/vagrant-libvirt#installation
# https://rancher.com/docs/rke/latest/en/installation/#download-the-rke-binary

# The user to install the vagrant-libvirt plugin as.
USER=${1:-danbooru}
RKE_VERSION=1.2.8

# Install Vagrant repo.
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/vagrant.list
apt-get update

# Install Vagrant, qemu, and dependencies for vagrant-libvirt.
apt-get install vagrant
apt-get install qemu qemu-utils libvirt-daemon-system libvirt-clients ebtables dnsmasq-base
apt-get install build-essential libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev

# Install vagrant-libvirt as regular user.
sudo -u "$USER" vagrant plugin install vagrant-libvirt

# Install RKE
# https://github.com/rancher/rke/releases
wget https://github.com/rancher/rke/releases/download/v${RKE_VERSION}/rke_linux-amd64 -O /usr/local/bin/rke
chmod +x /usr/local/bin/rke
