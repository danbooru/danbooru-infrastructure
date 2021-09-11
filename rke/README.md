# About

[Rancher Kubernetes Engine](https://rancher.com/docs/rke/latest/en/) (RKE) is
used to deploy Kubernetes on the servers in production. It's also used to add
nodes, remove nodes, and upgrade the Kubernetes version.

Installing the cluster will create a `cluster.rkestate` file and a
`kube_config_cluster.yml` file. These files should be saved and kept in a safe
place.

# Installation

* [Download the RKE binary](https://rancher.com/docs/rke/latest/en/installation/#download-the-rke-binary)
* Install Docker on each node.
* Create a `k8s` user on each node.
* Add the user to the `docker` group
* Add your SSH pubkey to the user's `~/.ssh/authorized_keys`
* Configure `cluster.yml` so that RKE can SSH into each node as the `k8s` user.
* Run `./rke up`

# Commands

```sh
# Get RKE binary
wget https://github.com/rancher/rke/releases/download/v1.2.11/rke_linux-amd64 -O ./rke

# To install the cluster, edit cluster.yml and run `rke up`
# https://rancher.com/docs/rke/latest/en/installation/
./rke up

# To add, remove, or update nodes, edit cluster.yml and run `rke up` again
# https://rancher.com/docs/rke/latest/en/managing-clusters/
./rke up

# Test that the Kubernetes cluster is working
./rke version

# Get the cluster.rkestate file
./rke util get-state file

# Back up Kubernetes cluster state.
# Automatic daily etcd snapshots are also stored in /opt/rke/etcd-snapshots/ on each node.
# https://rancher.com/docs/rke/latest/en/etcd-snapshots/one-time-snapshots/
./rke etcd snapshot-save

# Restore Kubernetes cluster state from backup
# https://rancher.com/docs/rke/latest/en/etcd-snapshots/restoring-from-backup/
./rke etcd snapshot-restore

# Destroy the Kubernetes cluster (dangerous)
./rke remove
```

# Troubleshooting

* Make sure Docker is installed on every node.
* Make sure SSH is configured properly and RKE can SSH into each node.
* Make sure the SSH user exists and has sudoless Docker permissions.
* Make sure port 6443 is open and RKE can talk to the Kubernetes API server.
* Replace the cluster.rkestate symlink with the real file. RKE doesn't like symlinks.

# See also

* https://rancher.com/docs/rke/latest/en/
