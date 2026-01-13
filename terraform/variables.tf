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

variable "deployment_id" {
  description = "A unique identifier for the deployment, often used for naming resources."
  type        = string
}

variable "im_deployment_repo_uri" {
  description = "The URI of the repository containing the Infrastructure Manager deployment configurations."
  type        = string
}

variable "github_app_installation_id" {
  description = "The installation ID of the GitHub App."
  type        = string
}

variable "github_pat_secret" {
  description = "The Resource ID (e.g., projects/x/secrets/y/versions/z) of the GitHub Personal Access Token stored in Secret Manager."
  type        = string
}
