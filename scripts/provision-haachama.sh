#!/bin/sh

# https://help.ubuntu.com/lts/installation-guide/amd64/apds04.html
# https://openzfs.github.io/openzfs-docs/Getting%20Started/Ubuntu/Ubuntu%2020.04%20Root%20on%20ZFS.html#
# https://wiki.archlinux.org/title/Install_Arch_Linux_on_ZFS#Installation

apt-get update
apt-get install -t buster-backports zfsutils-linux # For Debian 10 (https://wiki.debian.org/ZFS#Installation)
apt-get install ubuntu-archive-keyring # For Debian 10 (needed by debootstrap)

blkdiscard -v /dev/nvme0n1
blkdiscard -v /dev/nvme1n1

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

vgcreate vg0 /dev/nvme0n1p2 /dev/nvme1n1p2
lvcreate -n boot --type raid1 -L 1G vg0 /dev/nvme0n1p2 /dev/nvme1n1p2
lvcreate -n nvme0 -l 100%free vg0 /dev/nvme0n1p2
lvcreate -n nvme1 -l 100%free vg0 /dev/nvme1n1p2

zpool create -f -o ashift=9 -O acltype=posix -O atime=off -O xattr=sa -O dnodesize=auto -O normalization=formD -O mountpoint=none -O canmount=off -O devices=off -R /mnt zroot mirror /dev/vg0/nvme0 /dev/vg0/nvme1
zfs create -o mountpoint=none zroot/ROOT
zfs create -o mountpoint=none zroot/data
zfs create -o mountpoint=/ -o devices=on zroot/ROOT/default
zfs create -o mountpoint=/home zroot/data/home
zfs create -o mountpoint=/var zroot/data/var

mkfs -t ext4 /dev/mapper/vg0-boot
mkdir /mnt/boot
mount /dev/mapper/vg0-boot /mnt/boot

# https://wiki.ubuntu.com/DebootstrapChroot
# http://archive.ubuntu.com/ubuntu/pool/main/d/debootstrap/?C=M;O=D
wget http://archive.ubuntu.com/ubuntu/pool/main/d/debootstrap/debootstrap_1.0.124_all.deb
dpkg --install debootstrap_1.0.9~hardy1_all.deb
debootstrap --arch amd64 hirsute /mnt # Hirsute is Ubuntu 21.04

mkdir /mnt/dev
mount -o bind /dev /mnt/dev
mount -o bind /proc /mnt/proc
mount -o bind /sys /mnt/sys

# switch to chroot
chroot /mnt /bin/bash

# the following commands are run inside the chroot
cat <<EOF > /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu hirsute main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu hirsute-updates main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu hirsute-security main restricted universe multiverse
EOF

cat <<EOF > /etc/netplan/netplan.yaml
# https://netplan.io/reference
network:
  version: 2
  ethernets:
    enp9s0:
      dhcp4: true
EOF

cat <<EOF > /etc/fstab
/dev/mapper/vg0-boot /boot ext4 defaults,noatime 0 0
EOF

mkdir -p /etc/docker
cat << EOF > /etc/docker/daemon.json
  {
    "log-driver": "journald",
    "log-opts": {
      "mode": "non-blocking",
      "max-buffer-size": "8m"
    }
  }
EOF

cat << EOF > /etc/sysctl.d/99-local.conf
# https://serverfault.com/questions/875035/sane-value-for-net-ipv4-tcp-max-syn-backlog-in-sysctl-conf/953908#953908
# https://medium.com/@pawilon/tuning-your-linux-kernel-and-haproxy-instance-for-high-loads-1a2105ea553e
# https://blog.cloudflare.com/syn-packet-handling-in-the-wild
net.ipv4.tcp_max_syn_backlog = 8192
net.core.netdev_max_backlog = 8192
net.core.somaxconn = 8192

# https://www.nginx.com/blog/overcoming-ephemeral-port-exhaustion-nginx-plus
net.ipv4.ip_local_port_range = 1024 65535

net.ipv4.conf.all.log_martians = 1

fs.file-max = 16777216
fs.nr_open = 16777216

kernel.panic = 60
kernel.pid_max = 4194304
EOF

cat << EOF > /etc/systemd/journald.conf
[Journal]
RateLimitBurst=25000
RateLimitIntervalSec=5s
EOF

echo haachama > /etc/hostname

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
  lsb-release neovim usbutils
apt-get purge cron rsyslogd networkd-dispatcher

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install --no-install-recommends docker-ce docker-ce-cli containerd.io

useradd -m -U -s /bin/bash danbooru
usermod -aG sudo danbooru
sudo -u danbooru ssh-import-id gh:evazion
sudo -u root ssh-import-id gh:evazion

passwd root
passwd danbooru

update-grub
grub-install --verbose /dev/nvme0n1

# outside chroot

umount /mnt/boot /mnt/proc /mnt/dev /mnt/sys
zfs umount -a
zpool export zroot
reboot

# To mount the filesystem in rescue mode:
# zpool import -f -R /mnt zroot
