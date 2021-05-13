# Testbooru

This directory contains scripts for setting up Testbooru.

Testbooru runs on haachama.donmai.us, inside of a Kubernetes cluster running on
top of three virtual machines. The virtual machines are provisioned by Vagrant,
while Kubernetes is provisioned by RKE.

`../scripts/provision-haachama.sh` installs the OS on the base Testbooru
server. This script is Danbooru-specific and is hardcoded to the network and
disk layout of haachama.donmai.us.

`install.sh` installs Vagrant, libvirt, and RKE on top of the base server.

`Vagrantfile` contains the VM configuration. `provision-vm.sh` sets up the VM
on first boot. It installs Docker and sets up user accounts.

`cluster.yaml` contains the configuration for deploying Kubernetes onto the VMs
using RKE.

# Commands

```sh
# Start the VMs.
vagrant up --parallel

# Delete VMs and destroy old state.
vagrant destroy -f
rm cluster.rkestate kube_config.yml

# Troubleshoot Vagrant.
vagrant ssh node1
vagrant status
vagrant global-status
vagrant port

# Troubleshoot VMs.
virsh list
virsh net-list
virsh net-destroy testbooru0
virsh net-destroy vagrant-libvirt
virsh dumpxml testbooru_node1

# If using Virtualbox instead of libvirt
vboxmanage list vms
vboxmanage list hostonlyifs
vboxmanage showvminfo node1
vboxmanage hostonlyif remove vboxnet0
ssh -i ./.vagrant/machines/node1/virtualbox/private_key vagrant@localhost -p 2222

# Install Kubernetes.
rke up

# Use Kubernetes.
export KUBECONFIG=./kube_config_cluster.yml
kubectl cluster-info
kubectl -n kube-system get pods
kubectl -n kube-system get nodes

# Troubleshoot networking inside VMs.
ip -br link
ip -br addr
ip route
route -n
bridge link
networkctl status --all
cat /etc/netplan/50-vagrant.yaml
tshark -i br0

sudo docker ps
```
