helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --set prometheusOperator.admissionWebhooks.certManager.enabled=true