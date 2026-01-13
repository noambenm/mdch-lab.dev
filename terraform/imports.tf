import {
  for_each = local.flux_controllers
  to       = google_service_account.flux_sa[each.key]
  id       = "projects/${var.project_id}/serviceAccounts/${each.key}@${var.project_id}.iam.gserviceaccount.com"
}

import {
  for_each = local.flux_controllers
  to       = google_service_account_iam_member.flux_workload_identity[each.key]
  id       = "projects/${var.project_id}/serviceAccounts/${each.key}@${var.project_id}.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${var.workload_pool_id}/subject/system:serviceaccount:${var.flux_namespace}:${each.key}"
}

import {
  for_each = {
    for permission in local.gcp_sa_roles : "${permission.sa_name}-${permission.role}" => permission
  }
  to = google_project_iam_member.gcp_sa_roles[each.key]
  id = "${var.project_id} ${each.value.role} serviceAccount:${each.value.sa_name}@${var.project_id}.iam.gserviceaccount.com"
}

import {
  to = google_iam_workload_identity_pool.cluster_pool
  id = "projects/${var.project_id}/locations/global/workloadIdentityPools/${var.workload_pool_id}"
}

import {
  to = google_iam_workload_identity_pool_provider.flux_provider
  id = "projects/${var.project_id}/locations/global/workloadIdentityPools/${var.workload_pool_id}/providers/fluxcd"
}
