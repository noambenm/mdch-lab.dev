# Welcome to mdch-lab! 🏠

**The Ultimate Raspberry Pi Kubernetes Cluster**

This repository hosts all the code, configurations, and features of my Raspberry Pi Kubernetes homelab. The primary goal of this project is to gain hands-on experience and deepen my knowledge of Kubernetes by building, securing, and optimizing a fully functional cluster.

## Repository Structure

The repository is organized following GitOps principles with FluxCD:

- `infrastructure/` - Core infrastructure components
  - `controllers/` - Kubernetes controllers and operators
    - `cilium/` - Cilium CNI configuration
    - `external-secrets/` - External Secrets Operator
    - `kube-prometheus-stack/` - Monitoring stack
    - `loki-stack/` - Logging stack
    - `longhorn/` - Storage management
    - `cloudflare/` - Cloudflare integration
    - `cert-manager/` - Certificate management
  - `configs/` - Infrastructure configurations

- `cluster/` - Cluster-wide configurations
  - `gateway-api/` - Gateway API configurations

- `apps/` - Application deployments
  - `homepage/` - Dashboard application
  - `vaultwarden/` - Password manager
  - `plex/` - Media server
  - `pihole/` - Network-wide ad blocking

- `raspberry-pi/` - Raspberry Pi specific configurations

## Current Infrastructure Components

The cluster is built with the following key components:

- **Kubernetes & K3s** for efficient container orchestration on Raspberry Pi hardware
- **Cilium** as the Container Network Interface (CNI) for enhanced network security and observability
- **Cert-manager** for automated TLS certificate management
- **Prometheus, Grafana & Loki** for robust monitoring, logging, and observability
- **FluxCD** for continuous delivery, maintaining GitOps principles
- **External Secrets Operator** for secure secret management
- **Longhorn** for distributed block storage
- **Gateway API** for advanced ingress configuration

## Project Goals

- Follow Kubernetes best practices, ensuring the cluster is secure, reliable, and scalable
- Gain valuable real-world experience relevant to DevOps and Kubernetes operations
- Document and reflect the evolving state and progress of my homelab clearly and transparently
- Implement modern cloud-native practices in a homelab environment

## Getting Started

1. Clone the repository
2. Review the infrastructure configurations in `infrastructure/`
3. Check the cluster configurations in `cluster/`
4. Explore the application deployments in `apps/`

Feel free to explore, suggest improvements, or collaborate!

