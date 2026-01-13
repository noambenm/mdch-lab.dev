variable "project_id" {
  description = "The GCP Project ID where the Service Accounts will be created."
  type        = string
}

variable "project_number" {
  description = "The GCP Project Number (numeric). Required for constructing the Workload Identity principal URI."
  type        = string
}

variable "workload_pool_id" {
  description = "The Workload Identity Pool ID."
  type        = string
}

variable "provider_id" {
  description = "The Provider ID for the WIF pool"
  type        = string
}

variable "flux_namespace" {
  description = "The Kubernetes namespace where Flux is installed."
  type        = string
}
