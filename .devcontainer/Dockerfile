FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04
SHELL ["/bin/bash", "-xeuo", "pipefail", "-O", "globstar", "-O", "dotglob", "-c"]

ARG DEBIAN_FRONTEND=noninteractive
ARG KUBECTL_VERSION=1.33.10
ARG RKE_VERSION=1.8.13
ARG CMCTL_VERSION=2.4.1
ARG TERRAFORM_VERSION=1.14.8
ARG CF_TERRAFORMING_VERSION=0.25.0

RUN <<EOS
  apt-get update
  apt-get install -y --no-install-recommends apt-transport-https bash-completion ca-certificates curl git gnupg jq less lsb-release python3 python3-pip python3-venv software-properties-common unzip
  rm -rf /var/lib/apt/lists/*
EOS

RUN <<EOS
  install -m 0755 -d /etc/apt/keyrings

  curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg
  chmod a+r /etc/apt/keyrings/hashicorp.gpg
  echo "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list

  curl -fsSL https://pkgs.k8s.io/core:/stable:/v${KUBECTL_VERSION%.*}/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  chmod a+r /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${KUBECTL_VERSION%.*}/deb/ /" > /etc/apt/sources.list.d/kubernetes.list

  apt-get update
  apt-get install -y --no-install-recommends kubectl terraform=${TERRAFORM_VERSION}-*
  rm -rf /var/lib/apt/lists/*
EOS

RUN <<EOS
  ARCH="$(dpkg --print-architecture)"

  curl -fsSL "https://github.com/rancher/rke/releases/download/v${RKE_VERSION}/rke_linux-${ARCH}" -o /usr/local/bin/rke
  chmod +x /usr/local/bin/rke

  curl -fsSL "https://github.com/cert-manager/cmctl/releases/download/v${CMCTL_VERSION}/cmctl_linux_${ARCH}.tar.gz" -o /tmp/cmctl.tar.gz
  tar -xzf /tmp/cmctl.tar.gz -C /usr/local/bin cmctl
  chmod +x /usr/local/bin/cmctl

  curl -fsSL "https://github.com/cloudflare/cf-terraforming/releases/download/v${CF_TERRAFORMING_VERSION}/cf-terraforming_${CF_TERRAFORMING_VERSION}_linux_${ARCH}.tar.gz" -o /tmp/cf-terraforming.tar.gz
  tar -xzf /tmp/cf-terraforming.tar.gz -C /usr/local/bin cf-terraforming
  chmod +x /usr/local/bin/cf-terraforming

  rm -f /tmp/cmctl.tar.gz
  rm -f /tmp/cf-terraforming.tar.gz
EOS