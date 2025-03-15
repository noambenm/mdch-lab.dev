#!/bin/bash
# restart-pods.sh
#
# This script performs a staged, sequential rollout restart of cluster components
# across different namespaces. Each restart is followed by a pause to allow the
# resources to stabilize before proceeding.
#
# The order is as follows:
# 1. Core Infrastructure (kube-system and cilium)
# 2. Cert-Manager (cert-manager namespace)
# 3. Flux / GitOps Controllers (flux-system namespace)
# 4. Ingress Controller (ingress-nginx namespace)
# 5. Monitoring & Logging (monitoring namespace)
# 6. Application Pods (pihole, cloudflare)
#
# Usage: ./rollout-restart.sh

# Sleep durations (in seconds) between individual restarts in each group
SLEEP_CORE=30
SLEEP_CERT=30
SLEEP_FLUX=30
SLEEP_INGRESS=30
SLEEP_MONITORING=60
SLEEP_APPS=30

echo "Starting staged rollout restart of all cluster components..."

#################################
# 1. Core Infrastructure
#################################

echo "==> Group 1: Core Infrastructure"

# Restart CoreDNS in kube-system (Deployment with label k8s-app=kube-dns)
echo "Restarting CoreDNS (kube-system)..."
kubectl rollout restart deployment -n kube-system -l k8s-app=kube-dns
sleep $SLEEP_CORE

# Restart local-path-provisioner in kube-system
echo "Restarting local-path-provisioner (kube-system)..."
kubectl rollout restart deployment -n kube-system local-path-provisioner
sleep $SLEEP_CORE

# In the cilium namespace:
echo "Restarting Cilium components in 'cilium' namespace..."

# Restart deployments
echo "  Restarting cilium-operator..."
kubectl rollout restart deployment -n cilium cilium-operator
sleep $SLEEP_CORE

echo "  Restarting hubble-relay..."
kubectl rollout restart deployment -n cilium hubble-relay
sleep $SLEEP_CORE

echo "  Restarting hubble-ui..."
kubectl rollout restart deployment -n cilium hubble-ui
sleep $SLEEP_CORE

# Restart daemonsets
echo "  Restarting cilium (DaemonSet)..."
kubectl rollout restart daemonset -n cilium cilium
sleep $SLEEP_CORE

echo "  Restarting cilium-envoy (DaemonSet)..."
kubectl rollout restart daemonset -n cilium cilium-envoy
sleep $SLEEP_CORE

#################################
# 2. Cert-Manager
#################################

echo "==> Group 2: Cert-Manager (cert-manager namespace)"

echo "Restarting cert-manager (controller)..."
kubectl rollout restart deployment -n cert-manager cert-manager
sleep $SLEEP_CERT

echo "Restarting cert-manager-cainjector..."
kubectl rollout restart deployment -n cert-manager cert-manager-cainjector
sleep $SLEEP_CERT

echo "Restarting cert-manager-webhook..."
kubectl rollout restart deployment -n cert-manager cert-manager-webhook
sleep $SLEEP_CERT

#################################
# 3. Flux / GitOps Controllers
#################################

echo "==> Group 3: Flux / GitOps Controllers (flux-system namespace)"

echo "Restarting helm-controller..."
kubectl rollout restart deployment -n flux-system helm-controller
sleep $SLEEP_FLUX

echo "Restarting kustomize-controller..."
kubectl rollout restart deployment -n flux-system kustomize-controller
sleep $SLEEP_FLUX

echo "Restarting notification-controller..."
kubectl rollout restart deployment -n flux-system notification-controller
sleep $SLEEP_FLUX

echo "Restarting source-controller..."
kubectl rollout restart deployment -n flux-system source-controller
sleep $SLEEP_FLUX

#################################
# 4. Ingress Controller
#################################

echo "==> Group 4: Ingress Controller (ingress-nginx namespace)"

echo "Restarting ingress-nginx-controller..."
kubectl rollout restart deployment -n ingress-nginx ingress-nginx-controller
sleep $SLEEP_INGRESS

# If an admission webhook deployment exists, restart it too.
echo "Restarting ingress-nginx-controller-admission (if exists)..."
kubectl rollout restart deployment -n ingress-nginx ingress-nginx-controller-admission || true
sleep $SLEEP_INGRESS

#################################
# 5. Monitoring & Logging
#################################

echo "==> Group 5: Monitoring & Logging (monitoring namespace)"

echo "Restarting kube-prometheus-stack-grafana..."
kubectl rollout restart deployment -n monitoring kube-prometheus-stack-grafana
sleep $SLEEP_MONITORING

echo "Restarting kube-prometheus-stack-kube-state-metrics..."
kubectl rollout restart deployment -n monitoring kube-prometheus-stack-kube-state-metrics
sleep $SLEEP_MONITORING

echo "Restarting kube-prometheus-stack-operator..."
kubectl rollout restart deployment -n monitoring kube-prometheus-stack-operator
sleep $SLEEP_MONITORING

echo "Restarting Alertmanager (StatefulSet)..."
kubectl rollout restart statefulset -n monitoring alertmanager-kube-prometheus-stack-alertmanager
sleep $SLEEP_MONITORING

echo "Restarting Prometheus (StatefulSet)..."
kubectl rollout restart statefulset -n monitoring prometheus-kube-prometheus-stack-prometheus
sleep $SLEEP_MONITORING

echo "Restarting Prometheus Node Exporter (DaemonSet)..."
kubectl rollout restart daemonset -n monitoring kube-prometheus-stack-prometheus-node-exporter
sleep $SLEEP_MONITORING

#################################
# 6. Application Pods
#################################

echo "==> Group 6: Application Pods"

echo "Restarting Pi-hole (pihole namespace)..."
kubectl rollout restart deployment -n pihole pihole
sleep $SLEEP_APPS

echo "Restarting Cloudflare (cloudflare namespace)..."
kubectl rollout restart deployment -n cloudflare cloudflared-deployment
sleep $SLEEP_APPS

echo "Staged rollout restart completed."

