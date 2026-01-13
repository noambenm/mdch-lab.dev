resource "google_service_account" "flux_sa" {
  for_each     = local.flux_controllers
  project      = var.project_id
  account_id   = each.key
  display_name = title(replace(each.key, "-", " "))
  description  = "GCP Service Account that the flux controller impersonate"
}

resource "google_service_account_iam_member" "flux_workload_identity" {
  for_each           = local.flux_controllers
  service_account_id = google_service_account.flux_sa[each.key].name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${var.workload_pool_id}/subject/system:serviceaccount:${var.flux_namespace}:${each.key}"
}

resource "google_project_iam_member" "gcp_sa_roles" {
  for_each = {
    for permission in local.gcp_sa_roles : "${permission.sa_name}-${permission.role}" => permission
  }
  project = var.project_id
  role    = each.value.role
  member  = google_service_account.flux_sa[each.value.sa_name].member
}
