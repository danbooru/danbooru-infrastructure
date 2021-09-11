# Commands

```sh
export KUBECONFIG=/path/to/danbooru-infrastructure/secrets/kube_config_cluster.yml

# Get token for kubernetes dashboard
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/evazion -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"

kubectl cluster-info
kubectl get pods -A
kubectl get nodes -A

kubectl diff -k .
kubectl apply -k .

kubectl proxy
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=default

# https://cert-manager.io/docs/usage/kubectl-plugin
kubectl cert-manager status certificate donmai-us -n danbooru
kubectl cert-manager renew donmai-us -n danbooru
```

# Krew

```sh
# Install krew
# https://krew.sigs.k8s.io/docs/user-guide/setup/install/

(
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
    tar zxvf krew.tar.gz &&
    KREW=./krew-"${OS}_${ARCH}" &&
    "$KREW" install krew
)

# Add to ~/.bashrc
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

kubectl krew install cert-manager
kubectl krew install ingress-nginx
```

# Helm

```sh
  # https://helm.sh/docs/intro/install/
  curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
  sudo apt-add-repository "deb https://baltocdn.com/helm/stable/debian/ all main"
  sudo apt-get update
  sudo apt-get install helm
```

# cert-manager

```sh
  kubectl cert-manager status certificate donmai-us -n danbooru
  kubectl cert-manager renew donmai-us -n danbooru
```
