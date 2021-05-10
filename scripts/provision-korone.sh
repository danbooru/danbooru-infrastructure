apt-get install docker.io ssh-import-id
apt-get install zfs

lvcreate -L 2G -n slog0 vg0 /dev/nvme0n1p2
lvcreate -L 2G -n slog1 vg0 /dev/nvme1n1p2
lvcreate -L 128G -n l2arc0 vg0 /dev/nvme0n1p2
lvcreate -L 128G -n l2arc1 vg0 /dev/nvme1n1p2
lvcreate -l 100%free -n nvme0 vg0 /dev/nvme0n1p2
lvcreate -l 100%free -n nvme1 vg0 /dev/nvme1n1p2
lvcreate -l 100%free -n sda1 vg0 /dev/sda1
lvcreate -l 100%free -n sdb1 vg0 /dev/sdb1

zpool create -o ashift=12 -m /srv/hdd hdd mirror /dev/vg0/sda1 /dev/vg0/sdb1
zpool add hdd cache /dev/vg0/l2arc0 /dev/vg0/l2arc1
zpool add hdd log mirror /dev/vg0/slog0 /dev/vg0/slog1

zpool create -o ashift=12 -m /home/danbooru/images nvme /dev/vg0/nvme0 /dev/vg0/nvme1

zfs create -m /home/danbooru/images/preview  nvme/preview
zfs create -m /home/danbooru/images/crop     nvme/crop
zfs create -m /home/danbooru/images/sample   nvme/sample
zfs create -m /home/danbooru/images/original hdd/original
