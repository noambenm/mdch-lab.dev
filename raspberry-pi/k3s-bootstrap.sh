#!/bin/bash

set -e

### 1. Modify /boot/firmware/cmdline.txt ###
CMDLINE_FILE="/boot/firmware/cmdline.txt"
CMDLINE_PARAMS="cgroup_memory=1 cgroup_enable=memory"
if ! grep -q "$CMDLINE_PARAMS" $CMDLINE_FILE; then
    echo "Adding cgroup parameters..."
    sudo sed -i "$ s/$/ $CMDLINE_PARAMS/" $CMDLINE_FILE
else
    echo "Cgroup parameters already exist."
fi

### 2. Install iptables ###
echo "Installing iptables..."
sudo apt update
sudo apt install -y iptables

### 3. Create K3s config.yaml ###
CONFIG_PATH="/etc/rancher/k3s"
sudo mkdir -p $CONFIG_PATH
CONFIG_FILE="$CONFIG_PATH/config.yaml"
if [ ! -f "$CONFIG_FILE" ]; then
sudo tee $CONFIG_FILE > /dev/null << EOF
disable:
  - "servicelb"
  - "traefik"
  - "metrics-server"
  - "local-storage"

disable-kube-proxy: true
disable-network-policy: true
flannel-backend: "none"
etcd-expose-metrics: true

kube-controller-manager-arg:
  - "bind-address=0.0.0.0"

kube-scheduler-arg:
  - "bind-address=0.0.0.0"
EOF
else
  echo "K3s config.yaml already exists."
fi

### 4. Install K3s ###
if ! command -v k3s &> /dev/null; then
  echo "Installing K3s..."
  curl -sfL https://get.k3s.io | sh -
else
  echo "K3s already installed."
fi

### 5. Configure kubectl access ###
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
export KUBECONFIG=~/.kube/config

grep -qxF 'export KUBECONFIG=~/.kube/config' ~/.bashrc || echo 'export KUBECONFIG=~/.kube/config' >> ~/.bashrc

### 6. Enable kubectl bash completion and alias ###
sudo apt-get install -y bash-completion
grep -qxF "source /usr/share/bash-completion/bash_completion" ~/.bashrc || echo "source /usr/share/bash-completion/bash_completion" >> ~/.bashrc

sudo mkdir -p /etc/bash_completion.d/
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
sudo chmod a+r /etc/bash_completion.d/kubectl
grep -qxF 'alias k=kubectl' ~/.bashrc || echo 'alias k=kubectl' >> ~/.bashrc
grep -qxF 'complete -o default -F __start_kubectl k' ~/.bashrc || echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc

### 7. Install Helm with auto completion ###
if ! command -v helm &> /dev/null; then
  echo "Installing Helm..."
  curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
  sudo apt-get install apt-transport-https --yes
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
  sudo apt-get update
  sudo apt-get install helm

  helm completion bash | sudo tee /etc/bash_completion.d/helm > /dev/null
else
  echo "Helm already installed."
fi

### 8. Install Kustomize with auto completion ###
if ! command -v kustomize &> /dev/null; then
  echo "Installing Kustomize..."
  curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
  sudo mv ./kustomize /usr/local/bin/

  kustomize completion bash | sudo tee /etc/bash_completion.d/kustomize > /dev/null
else
  echo "Kustomize already installed."
fi

### 9. Install Cilium CLI with alias and auto completion ###
if ! command -v cilium &> /dev/null; then
  echo "Installing Cilium CLI..."
  CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
  CLI_ARCH=amd64
  if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
  curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
  sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
  sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
  rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

  cilium completion bash | sudo tee /etc/bash_completion.d/cilium > /dev/null
fi

grep -qxF "alias cilium='cilium --namespace cilium'" ~/.bashrc || echo "alias cilium='cilium --namespace cilium'" >> ~/.bashrc

### 10. Install Flux CLI with auto completion ###
if ! command -v flux &> /dev/null; then
  echo "Installing Flux CLI..."
  curl -s https://fluxcd.io/install.sh | sudo bash

  flux completion bash | sudo tee /etc/bash_completion.d/flux > /dev/null
else
  echo "Flux CLI already installed."
fi

### Finalize by sourcing ~/.bashrc ###
source ~/.bashrc

echo "All tasks completed successfully!"
echo "Please restart your shell to apply the changes."