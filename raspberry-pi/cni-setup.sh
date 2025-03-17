# installs crd for service monitors
k apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/refs/heads/main/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml

# creates namespace of cilium
k apply -f ..infrastructure/controllers/cilium/namespace.yaml

helm install cilium cilium/cilium --version 1.14.0 \
    --namespace cilium  \
    -f ..infrastructure/controllers/cilium/values.yaml