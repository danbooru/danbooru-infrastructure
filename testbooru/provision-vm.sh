#!/usr/bin/env bash

set -euo pipefail

timedatectl set-timezone UTC

# https://docs.docker.com/config/containers/logging/journald/
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

# https://docs.docker.com/engine/install/ubuntu/
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

apt-get purge -y at snapd unattended-upgrades multipath-tools packagekit rsyslog accountsservice policykit-1 networkd-dispatcher fwupd cron haveged ifplugd
apt-get autoremove -y

systemctl stop unattended-upgrades motd-news.timer man-db.timer
systemctl mask motd-news.timer man-db.timer

useradd -m -U -s /bin/bash danbooru
usermod -aG sudo danbooru
sudo -u danbooru ssh-import-id gh:evazion
sudo -u root ssh-import-id gh:evazion

sed -i -e '/swap/d' /etc/fstab
swapoff -a
rm /swap.img

#sudo ufw allow to any port 22 proto tcp
#sudo ufw allow in on eno1 to any port 80,443,6443
#sudo ufw reject in on eno1
