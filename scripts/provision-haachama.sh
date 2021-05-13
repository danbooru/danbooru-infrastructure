#!/bin/sh

# https://help.ubuntu.com/lts/installation-guide/amd64/apds04.html
# https://openzfs.github.io/openzfs-docs/Getting%20Started/Ubuntu/Ubuntu%2020.04%20Root%20on%20ZFS.html
# https://wiki.archlinux.org/title/Install_Arch_Linux_on_ZFS#Installation

# Install ZFS (this assumes we're running in Debian 10)
apt-get update
apt-get install -t buster-backports zfsutils-linux # https://wiki.debian.org/ZFS#Installation
apt-get install ubuntu-archive-keyring # needed by debootstrap

# Wipe both drives.
blkdiscard -v /dev/nvme0n1
blkdiscard -v /dev/nvme1n1

# Partition 1 is a 2M partition for Grub. Partition 2 is the main partition that takes up the remaining space.
parted /dev/nvme0n1 mktable gpt
parted /dev/nvme0n1 mkpart grub 0% 2M
parted /dev/nvme0n1 mkpart primary 2M 100%
parted /dev/nvme0n1 set 1 bios_grub on
parted /dev/nvme0n1 set 2 boot on

parted /dev/nvme1n1 mktable gpt
parted /dev/nvme1n1 mkpart grub 0% 2M
parted /dev/nvme1n1 mkpart primary 2M 100%
parted /dev/nvme1n1 set 1 bios_grub on
parted /dev/nvme1n1 set 2 boot on

# Create a 1GB raid1 boot volume.
vgcreate vg0 /dev/nvme0n1p2 /dev/nvme1n1p2
lvcreate -n boot --type raid1 -L 1G vg0 /dev/nvme0n1p2 /dev/nvme1n1p2

# Create a volume on each device that takes up the remaining space.
lvcreate -n nvme0 -l 100%free vg0 /dev/nvme0n1p2
lvcreate -n nvme1 -l 100%free vg0 /dev/nvme1n1p2

# Create a zpool named `zroot` mirrored across the nvme0 and nvme1 volumes on each device.
zpool create -f -o ashift=9 -O acltype=posix -O atime=off -O xattr=sa -O dnodesize=auto -O normalization=formD -O mountpoint=none -O canmount=off -O devices=off -R /mnt zroot mirror /dev/vg0/nvme0 /dev/vg0/nvme1
zfs create -o mountpoint=none zroot/ROOT
zfs create -o mountpoint=none zroot/data
zfs create -o mountpoint=/ -o devices=on zroot/ROOT/default
zfs create -o mountpoint=/home zroot/data/home
zfs create -o mountpoint=/var zroot/data/var

# Create and mount the /boot filesystem.
mkfs -t ext4 /dev/mapper/vg0-boot
mkdir /mnt/boot
mount /dev/mapper/vg0-boot /mnt/boot

# Install Ubuntu 21.04 on /mnt using debootstrap.
# https://wiki.ubuntu.com/DebootstrapChroot
# http://archive.ubuntu.com/ubuntu/pool/main/d/debootstrap/?C=M;O=D
wget http://archive.ubuntu.com/ubuntu/pool/main/d/debootstrap/debootstrap_1.0.124_all.deb
dpkg --install debootstrap_1.0.9~hardy1_all.deb
debootstrap --arch amd64 hirsute /mnt # Hirsute is Ubuntu 21.04

# Prepare the chroot.
mkdir /mnt/dev
mount -o bind /dev /mnt/dev
mount -o bind /proc /mnt/proc
mount -o bind /sys /mnt/sys

# Switch to chroot.
chroot /mnt /bin/bash

# The following commands are run inside the chroot
cat <<EOF > /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu hirsute main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu hirsute-updates main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu hirsute-security main restricted universe multiverse
EOF

cat <<EOF > /etc/netplan/netplan.yaml
# https://netplan.io/reference
# https://docs.hetzner.com/robot/dedicated-server/ip/additional-ip-adresses
# https://docs.hetzner.com/robot/dedicated-server/network/net-config-debian/

network:
  version: 2
  ethernets:
    enp9s0:
      addresses:
      - 65.21.78.115/32
      - 2a01:4f9:3b:52cc::2/64
      gateway4: 65.21.78.65
      gateway6: fe80::1
      routes:
      - to: 65.21.78.65/32
        scope: link
      nameservers:
        addresses:
        - 1.1.1.1
        - 8.8.8.8
  bridges:
    br0:
      interfaces: []
      addresses:
      - 135.181.224.49/29
EOF

mkdir -p /etc/ssh/sshd_config.d
cat << EOF > /etc/sshd_config.d/99-local.conf
# https://man7.org/linux/man-pages/man5/sshd_config.5.html
AcceptEnv TZ
PasswordAuthentication No
Port 60022
EOF

mkdir -p /etc/dpkg
cat <<EOF > /etc/dpkg/dpkg.cfg
# https://man7.org/linux/man-pages/man1/dpkg.1.html
# https://man7.org/linux/man-pages/man5/dpkg.cfg.5.html

# Do not enable debsig-verify by default; since the distribution is not using
# embedded signatures, debsig-verify would reject all packages.
no-debsig

# Log dpkg output to journald instead of /var/log/dpkg.log
log /dev/null
status-logger "systemd-cat -t dpkg -p info"
EOF

cat <<EOF > /etc/fstab
/dev/mapper/vg0-boot /boot ext4 defaults,noatime 0 0
EOF

echo haachama > /etc/hostname

# Silence log warnings from sudo about /etc/securetty not existing
touch /etc/securetty

# Disable apt-get logging to /var/log/alternatives.log.
rm /var/log/alternatives.log
ln -s /dev/null /var/log/alternatives.log

# /var/log/journal must exist, otherwise journald won't store logs there.
mkdir -p /var/log/journal
systemd-tmpfiles --create --prefix /var/log/journal

export LANG=en_US.UTF-8
update-locale LANG=en_US.UTF-8
locale-gen --purge en_US.UTF-8
dpkg-reconfigure --frontend noninteractive locales

apt-get update
apt-get upgrade
apt-get install --no-install-recommends \
  linux-image-generic linux-headers-generic grub-pc parted lvm2 zfsutils-linux \
  zfs-initramfs zfs-zed bash-completion openssh-server ssh-import-id git \
  publicsuffix ufw man-db apt-transport-https curl ca-certificates gnupg \
  lsb-release neovim usbutils net-tools psmisc lsof
apt-get purge cron rsyslogd networkd-dispatcher

# Install Vagrant and libvirt
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/vagrant.list
apt-get update

apt-get install vagrant
apt-get install qemu qemu-utils libvirt-daemon-system libvirt-clients ebtables dnsmasq-base
apt-get install build-essential libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev

# Install vagrant-libvirt as regular user
sudo -u danbooru vagrant plugin install vagrant-libvirt

# Install RKE
# https://github.com/rancher/rke/releases
# https://rancher.com/docs/rke/latest/en/installation/#download-the-rke-binary
wget https://github.com/rancher/rke/releases/download/v1.2.8/rke_linux-amd64 -O /usr/local/bin/rke
chmod +x /usr/local/bin/rke

useradd -m -U -s /bin/bash danbooru
usermod -aG sudo danbooru
sudo -u danbooru ssh-import-id gh:evazion
sudo -u root ssh-import-id gh:evazion

passwd root
passwd danbooru

# Install bootloader on first device.
update-grub
grub-install --verbose /dev/nvme0n1

# Exit chroot
exit

# Export pool before reboot, otherwise it may fail to mount on reboot.
umount /mnt/boot /mnt/proc /mnt/dev /mnt/sys
zfs umount -a
zpool export zroot

reboot

# To mount the filesystem in rescue mode:
# zpool import -f -R /mnt zroot
