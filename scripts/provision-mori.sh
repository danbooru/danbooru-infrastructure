#!/bin/sh

# This is the install procedure for installing an OS from scratch on OVH. The
# steps are presented as a script but will have to be followed manually.
#
# Install procedure:
#
# * Boot into BIOS
# * Configure legacy BIOS boot mode and boot disk order
# * Boot into rescue shell (https://docs.ovh.com/us/en/dedicated/rescue-mode)
# * Wipe and partition disks
# * Create ZFS root and /boot filesystems
# * Use debootstrap to untar base filesystem
# * Chroot into filesystem
# * Configure networking, users, ssh, install basic packages
# * Reboot
#
# To enable legacy BIOS boot mode:
#
# * Open the remote KVM (in the OVH dashboard under the IPMI tab)
# * Reboot server and press F11 to enter the BIOS
# * Under the Boot tab, in the "Boot option filter" setting, enable "UEFI and Legacy"
# * Reboot
# * Under the Boot tab, change the boot order to add the first NVME drive as the first boot device
# * Reboot
#
# To enter rescue mode (https://docs.ovh.com/us/en/dedicated/rescue-mode):
#
# * In the OVH dashboard, choose the rescue mode boot option
# * Reboot server
# * Wait for the email containing the root password and SSH connection string
# * SSH into server

# Hardware info commands:
#
# ./geekbench (https://www.geekbench.com/download/linux/)
# smartctl -a /dev/nvme0n1
# hdparm -tT /dev/nvme0n1
# inxi -F
# lscpu
# lspci
# dmidecode

# 2x Intel Xeon Gold 6226Rs
# TYAN S7106GM2NR
# 12x16GB ECC 2933Mhz (Nanya NT16GA72D8PBX3P-IX)
# 2x SSD 480GB (Kingston SEDC500M480G)
# 2x NVME 1920GB (Samsung PM-983 / MZQLB1T9HAJR-00007)
# Mellanox MT27640
#
# Disk layout:
#
# 2x SSD 480GB
# * Partition 1: 1G EFI partition
# * Partition 2: 100% Primary partition
# * /boot 1GB   ext4 on lvm raid1
# * /     479GB zfs mirror
#
# 2x NVME 1920GB (Samsung PM-983 / MZQLB1T9HAJR-00007)
# * Partition 1: 100% Primary partition
# * /     1920GB zfs mirror

# https://help.ubuntu.com/lts/installation-guide/amd64/apds04.html
# https://openzfs.github.io/openzfs-docs/Getting%20Started/Ubuntu/Ubuntu%2020.04%20Root%20on%20ZFS.html
# https://wiki.archlinux.org/title/Install_Arch_Linux_on_ZFS#Installation

# The hostname of the server
SERVER_HOSTNAME=xxx

# The server's IPV6 address. Obtained from the OVH control panel.
IPV6=2604:xxxx:xxxx:xxxx::1/64

# The server's IPV6 router. Same as the ipv6 address, with the low order /80 bits set to ff.
IPV6_GATEWAY=2604:xxxx:xxxx:xxff:ff:ff:ff:ff

# The private network IP. Manually assigned.
VRACK_SUBNET=172.16.0.x/24

# The danbooru account's SSH key
SSH_PUBKEY=gh:evazion

# Wipe drives.
blkdiscard -v /dev/sda
blkdiscard -v /dev/sdb
blkdiscard -v /dev/nvme0n1
blkdiscard -v /dev/nvme1n1

# Partition 1: 1G EFI
# Partition 2: 479GB Primary
parted /dev/sda mktable gpt
parted /dev/sda mkpart efi 0% 1G
parted /dev/sda mkpart primary 1G 100%
parted /dev/sda set 2 boot on

# Partition 1: 1G EFI
# Partition 2: 479GB Primary
parted /dev/sdb mktable gpt
parted /dev/sdb mkpart efi 0% 1G
parted /dev/sdb mkpart primary 1G 100%
parted /dev/sdb set 2 boot on

# Partition 1: 1920GB Primary
parted /dev/nvme0n1 mktable gpt
parted /dev/nvme0n1 mkpart primary 0% 100%
parted /dev/nvme1n1 mktable gpt
parted /dev/nvme1n1 mkpart primary 0% 100%

# Create a 1GB raid1 boot volume.
vgcreate vg0 /dev/sda2 /dev/sdb2
lvcreate -n boot --type raid1 -L 1G vg0 /dev/sda2 /dev/sdb2

# Create a volume on each device that takes up the remaining space.
lvcreate -n ssd0 -l 100%free vg0 /dev/sda2
lvcreate -n ssd1 -l 100%free vg0 /dev/sdb2

# Create a zpool named `zroot` mirrored across the ssd0 and ssd1 volumes
modprobe zfs
zpool create -f -o ashift=12 -O compression=lz4 -O acltype=posixacl -O atime=off -O xattr=sa -O normalization=formD -O mountpoint=none -O canmount=off -O devices=off -R /mnt zroot mirror /dev/vg0/ssd0 /dev/vg0/ssd1
zfs create -o mountpoint=none zroot/ROOT
zfs create -o mountpoint=none zroot/data
zfs create -o mountpoint=/ -o devices=on zroot/ROOT/default
zfs create -o mountpoint=/home zroot/data/home
zfs create -o mountpoint=/var zroot/data/var

# Create a zpool named `nvme` mirrored across the /dev/nvme0n1p1 and /dev/nvme1n1p1 volumes
mkdir /mnt/srv
zpool create -f -o ashift=12 -O compression=lz4 -O acltype=posixacl -O atime=off -O xattr=sa -O normalization=formD -O mountpoint=none -O canmount=off -O devices=off -R /mnt/srv nvme mirror /dev/nvme0n1p1 /dev/nvme1n1p1
zfs create -o mountpoint=/srv nvme/data

# Create and mount the /boot filesystem.
mkfs -t ext4 /dev/vg0/boot
mkdir /mnt/boot
mount /dev/vg0/boot /mnt/boot

# Create and mount EFI partition
mkfs.fat -F32 /dev/sda1
mkfs.fat -F32 /dev/sdb1
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

# Get signing keys needed to run debootstrap
wget http://archive.ubuntu.com/ubuntu/pool/main/u/ubuntu-keyring/ubuntu-keyring_2021.03.26.tar.gz
tar -xzvf ubuntu-keyring_2021.03.26.tar.gz
cp -fi ubuntu-keyring-2021.03.26/keyrings/* /usr/share/keyrings/

# Install Ubuntu 21.04 on /mnt using debootstrap.
# https://wiki.ubuntu.com/DebootstrapChroot
# http://archive.ubuntu.com/ubuntu/pool/main/d/debootstrap/?C=M;O=D
wget http://archive.ubuntu.com/ubuntu/pool/main/d/debootstrap/debootstrap_1.0.124_all.deb
dpkg --install debootstrap_1.0.9~hardy1_all.deb
debootstrap --arch amd64 hirsute /mnt # Hirsute is Ubuntu 21.04

# Prepare the chroot.
mount -o bind /dev /mnt/dev
mount -o bind /proc /mnt/proc
mount -o bind /sys /mnt/sys

# Switch to chroot.
chroot /mnt /bin/bash

# The following commands are run inside the chroot

echo $SERVER_HOSTNAME > /etc/hostname

cat <<EOF > /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu hirsute main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu hirsute-updates main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu hirsute-security main restricted universe multiverse
EOF

# Generate locales
export LANG=en_US.UTF-8
locale-gen --purge en_US.UTF-8
update-locale LANG=en_US.UTF-8
dpkg-reconfigure --frontend noninteractive locales

# Install packages
apt-get update
apt-get upgrade -y
apt-get install -y --no-install-recommends \
  linux-image-generic linux-headers-generic grub-efi parted lvm2 zfsutils-linux \
  zfs-initramfs zfs-zed bash-completion openssh-server ssh-import-id git \
  publicsuffix ufw man-db apt-transport-https curl ca-certificates gnupg \
  lsb-release neovim usbutils net-tools psmisc lsof vlan pciutils hdparm \
  ipvsadm nvme-cli smartmontools socat linux-tools-generic rsync
apt-get purge -y cron rsyslog networkd-dispatcher

#systemctl stop rsync
#systemctl disable rsync

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io

# Configure networking
cat <<EOF > /etc/netplan/netplan.yaml
# https://netplan.io/reference
# https://support.us.ovhcloud.com/hc/en-us/articles/360008712939

network:
  version: 2
  ethernets:
    enp24s0f0np0:
      dhcp4: yes
      #addresses: [$IPV6]
      #gateway6: $IPV6_GATEWAY
      #routes:
      #- to: $IPV6_GATEWAY
      #  scope: link
      nameservers:
        addresses:
        - 1.1.1.1
        - 8.8.8.8
    enp175s0f0np0: {}
  vlans:
    vlan.99:
      id: 99
      link: eno2
      addresses: [$VRACK_SUBNET]
EOF

# Switch SSH port to 60022
cat << EOF > /etc/ssh/sshd_config.d/99-local.conf
# https://man7.org/linux/man-pages/man5/sshd_config.5.html
AcceptEnv TZ
PasswordAuthentication No
Port 60022
EOF

# Disable dpkg logging
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
/dev/vg0/boot /boot ext4 defaults,noatime 0 0
/dev/sda1 /boot/efi vfat defaults 0 0
EOF

# Disable Spectre mitigations on kernel command line
cat <<EOF > /etc/default/grub
# If you change this file, run 'update-grub' afterwards
GRUB_DEFAULT=0
GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="mitigations=off init_on_alloc=0"
GRUB_CMDLINE_LINUX=""
EOF

cat << EOF > /etc/systemd/journald.conf
[Journal]
RateLimitBurst=25000
RateLimitIntervalSec=5s
EOF

# Send Docker logs to journald
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

cat << EOF > /etc/systemd/system/x86-energy-perf-policy.service
[Unit]
Description=Set x86 energy policy to performance

[Service]
Type=oneshot
ExecStart=/usr/bin/x86_energy_perf_policy performance

[Install]
WantedBy=multi-user.target
EOF

cat << EOF > /etc/systemd/system/cpupower-performance.service
[Unit]
Description=Set CPU governor to performance

[Service]
Type=oneshot
ExecStart=/usr/bin/cpupower frequency-set -g performance

[Install]
WantedBy=multi-user.target
EOF

systemctl enable cpupower-performance
systemctl enable x86-energy-perf-policy

# Silence log warnings from sudo about /etc/securetty not existing
touch /etc/securetty

# Disable apt-get logging to /var/log/alternatives.log.
rm /var/log/alternatives.log
ln -s /dev/null /var/log/alternatives.log

# /var/log/journal must exist, otherwise journald won't store logs there.
mkdir -p /var/log/journal
systemd-tmpfiles --create --prefix /var/log/journal

# Create user and add SSH key
useradd -m -U -s /bin/bash danbooru
usermod -aG sudo danbooru
sudo -u danbooru ssh-import-id $SSH_PUBKEY

# Create a 'k8s' user with sudoless Docker permissions. Needed by RKE to deploy K8s.
useradd -m -U -s /bin/bash k8s
usermod -aG docker k8s
sudo -u k8s ssh-import-id $SSH_PUBKEY

# Allow SSH to root
sudo -u root ssh-import-id $SSH_PUBKEY

# Set passwords
passwd root
passwd danbooru

# Install bootloader on first device.
vgck --updatemetadata vg0
update-grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ubuntu --recheck --no-floppy

# Exit chroot
exit

# Export pool before reboot, otherwise it may fail to mount on reboot.
umount /mnt/boot/efi /mnt/boot /mnt/proc /mnt/dev /mnt/sys
zfs umount -a
zpool export zroot
zpool export nvme

reboot

# To mount the filesystem in rescue mode:
# zpool import -f -R /mnt zroot

# The following commands are run after reboot

sudo zpool import nvme

# Upgrade zpool features
sudo zpool upgrade -a
sudo zfs upgrade -a

# XXX Force "/var/log/journal/$(cat /etc/machine-id)" to be created to enable persistent logging
sudo systemctl restart systemd-journald

# Configure firewall
#
# Allow SSH, HTTP, HTTPS, and Kubernetes ports on public interface. Deny everything else.
# Allow everything on private network
sudo ufw default allow incoming
sudo ufw default allow outgoing
sudo ufw default allow routed
sudo ufw allow to any port 60022 proto tcp
sudo ufw allow in on enp24s0f0np0 proto tcp to any port 80,443,6443
sudo ufw reject in on enp24s0f0np0

# Enable firewall, disable it if we get locked out and can't hit ^C
sudo ufw enable && sleep 30 && sudo ufw disable
