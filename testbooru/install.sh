#!/bin/sh

curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/vagrant.list
apt-get update

apt-get install vagrant
apt-get install qemu libvirt-daemon-system libvirt-clients ebtables dnsmasq-base
apt-get install build-essential libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev

# install as regular user
sudo -u danbooru vagrant plugin install vagrant-libvirt
