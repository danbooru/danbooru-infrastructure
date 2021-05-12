# Testbooru

This directory contains scripts for setting up the server that runs Testbooru.

Testbooru runs on haachama.donmai.us, inside of a Kubernetes cluster running on
top of a set of three virtual machines. The virtual machines are provisioned by
Vagrant. Kubernetes is provisioned by RKE.

`../scripts/provision-haachama.sh` installs the OS on the base Testbooru
server. This script is Danbooru-specific and is hardcoded to the network and
disk layout of haachama.donmai.us.

`install.sh` installs Vagrant, libvirt, and RKE on top of the base server.

`Vagrantfile` contains the VM configuration. `provision-vm.sh` sets up the VM
on first boot. It installs Docker and sets up user accounts.

`cluster.yaml` contains the configuration for deploying Kubernetes on the VMs
with RKE.

# Commands

```sh
vagrant up --parallel
vagrant ssh node1
vagrant status
vagrant global-status
vagrant port

vagrant destroy -y
rm cluster.rkestate kube_config.yml # do this to clean up old state after destroying the VMs.

virsh list
virsh net-list
virsh net-destroy vagrant-libvirt

# If using Virtualbox instead of libvirt
vboxmanage list vms
vboxmanage list hostonlyifs
vboxmanage showvminfo node1
vboxmanage hostonlyif remove vboxnet0
ssh -i ./.vagrant/machines/node1/virtualbox/private_key vagrant@localhost -p 2222

./rke up

export KUBECONFIG=./kube_config_cluster.yml
kubectl cluster-info
kubectl -n kube-system get pods
kubectl -n kube-system get nodes

# debug networking inside the VM
ip -br link
ip -br addr
ip route

sudo docker ps
```
