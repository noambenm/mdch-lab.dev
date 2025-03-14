helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install kube-prometheus-stack prometheus-community/ \
  --namespace monitoring \
  --create-namespace -f values.yaml