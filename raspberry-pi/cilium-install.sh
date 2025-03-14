helm repo add cilium https://helm.cilium.io/
helm install cilium cilium/cilium \
    --version 1.17.1 \
    --namespace cilium \ 
    --values ../infrastructure/cilium/values.yaml \
    --create-namespace \