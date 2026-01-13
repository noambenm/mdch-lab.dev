resource "google_iam_workload_identity_pool" "cluster_pool" {
  project                   = var.project_id
  workload_identity_pool_id = var.workload_pool_id
  display_name              = "mdch-lab Cluster Pool"
  description               = "pool for connecting the homelab kubernetes cluster to authenticate with gcp"
}

resource "google_iam_workload_identity_pool_provider" "flux_provider" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.cluster_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id
  display_name                       = var.provider_id
  attribute_mapping = {
    "google.subject"                 = "assertion.sub"
    "attribute.namespace"            = "assertion['kubernetes.io']['namespace']"
    "attribute.service_account_name" = "assertion['kubernetes.io']['serviceaccount']['name']"
    "attribute.pod"                  = "assertion['kubernetes.io']['pod']['name']"
  }
  attribute_condition = "assertion['kubernetes.io']['namespace'] == '${var.flux_namespace}'"
  oidc {
    issuer_uri = "https://kubernetes.default.svc.cluster.local"
    jwks_json  = chomp(file("${path.module}/cluster-jwks.json"))
  }
}
