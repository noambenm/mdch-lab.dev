import {
  to = google_service_account.flux_sa["source-controller"]
  id = "projects/noambesandbox/serviceAccounts/source-controller@noambesandbox.iam.gserviceaccount.com"
}

import {
  to = google_service_account.flux_sa["kustomize-controller"]
  id = "projects/noambesandbox/serviceAccounts/kustomize-controller@noambesandbox.iam.gserviceaccount.com"
}

import {
  to = google_service_account.flux_sa["helm-controller"]
  id = "projects/noambesandbox/serviceAccounts/helm-controller@noambesandbox.iam.gserviceaccount.com"
}

import {
  to = google_service_account.flux_sa["notification-controller"]
  id = "projects/noambesandbox/serviceAccounts/notification-controller@noambesandbox.iam.gserviceaccount.com"
}

import {
  to = google_service_account.flux_sa["image-reflector-controller"]
  id = "projects/noambesandbox/serviceAccounts/image-reflector-controller@noambesandbox.iam.gserviceaccount.com"
}

# ---------------------------------------------------------------------------------------------------------------------
# 2. Workload Identity Bindings
# ---------------------------------------------------------------------------------------------------------------------

import {
  to = google_service_account_iam_member.flux_workload_identity["source-controller"]
  id = "projects/noambesandbox/serviceAccounts/source-controller@noambesandbox.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/320535199479/locations/global/workloadIdentityPools/mdch-lab-cluster-pool/subject/system:serviceaccount:flux-system:source-controller"
}

import {
  to = google_service_account_iam_member.flux_workload_identity["kustomize-controller"]
  id = "projects/noambesandbox/serviceAccounts/kustomize-controller@noambesandbox.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/320535199479/locations/global/workloadIdentityPools/mdch-lab-cluster-pool/subject/system:serviceaccount:flux-system:kustomize-controller"
}

import {
  to = google_service_account_iam_member.flux_workload_identity["helm-controller"]
  id = "projects/noambesandbox/serviceAccounts/helm-controller@noambesandbox.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/320535199479/locations/global/workloadIdentityPools/mdch-lab-cluster-pool/subject/system:serviceaccount:flux-system:helm-controller"
}

import {
  to = google_service_account_iam_member.flux_workload_identity["notification-controller"]
  id = "projects/noambesandbox/serviceAccounts/notification-controller@noambesandbox.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/320535199479/locations/global/workloadIdentityPools/mdch-lab-cluster-pool/subject/system:serviceaccount:flux-system:notification-controller"
}

import {
  to = google_service_account_iam_member.flux_workload_identity["image-reflector-controller"]
  id = "projects/noambesandbox/serviceAccounts/image-reflector-controller@noambesandbox.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/320535199479/locations/global/workloadIdentityPools/mdch-lab-cluster-pool/subject/system:serviceaccount:flux-system:image-reflector-controller"
}

# ---------------------------------------------------------------------------------------------------------------------
# 3. IAM Roles
# ---------------------------------------------------------------------------------------------------------------------

# source-controller roles
import {
  to = google_project_iam_member.gcp_sa_roles["source-controller-roles/artifactregistry.reader"]
  id = "noambesandbox roles/artifactregistry.reader serviceAccount:source-controller@noambesandbox.iam.gserviceaccount.com"
}
import {
  to = google_project_iam_member.gcp_sa_roles["source-controller-roles/storage.bucketViewer"]
  id = "noambesandbox roles/storage.bucketViewer serviceAccount:source-controller@noambesandbox.iam.gserviceaccount.com"
}
import {
  to = google_project_iam_member.gcp_sa_roles["source-controller-roles/storage.objectViewer"]
  id = "noambesandbox roles/storage.objectViewer serviceAccount:source-controller@noambesandbox.iam.gserviceaccount.com"
}

# kustomize-controller roles
import {
  to = google_project_iam_member.gcp_sa_roles["kustomize-controller-roles/cloudkms.cryptoKeyDecrypter"]
  id = "noambesandbox roles/cloudkms.cryptoKeyDecrypter serviceAccount:kustomize-controller@noambesandbox.iam.gserviceaccount.com"
}
import {
  to = google_project_iam_member.gcp_sa_roles["kustomize-controller-roles/container.clusterViewer"]
  id = "noambesandbox roles/container.clusterViewer serviceAccount:kustomize-controller@noambesandbox.iam.gserviceaccount.com"
}

# helm-controller roles
import {
  to = google_project_iam_member.gcp_sa_roles["helm-controller-roles/container.clusterViewer"]
  id = "noambesandbox roles/container.clusterViewer serviceAccount:helm-controller@noambesandbox.iam.gserviceaccount.com"
}

# notification-controller roles
import {
  to = google_project_iam_member.gcp_sa_roles["notification-controller-roles/pubsub.publisher"]
  id = "noambesandbox roles/pubsub.publisher serviceAccount:notification-controller@noambesandbox.iam.gserviceaccount.com"
}

# image-reflector-controller roles
import {
  to = google_project_iam_member.gcp_sa_roles["image-reflector-controller-roles/artifactregistry.reader"]
  id = "noambesandbox roles/artifactregistry.reader serviceAccount:image-reflector-controller@noambesandbox.iam.gserviceaccount.com"
}

# ---------------------------------------------------------------------------------------------------------------------
# 4. Static Resources
# ---------------------------------------------------------------------------------------------------------------------

import {
  to = google_iam_workload_identity_pool.cluster_pool
  id = "projects/noambesandbox/locations/global/workloadIdentityPools/mdch-lab-cluster-pool"
}

import {
  to = google_iam_workload_identity_pool_provider.flux_provider
  id = "projects/noambesandbox/locations/global/workloadIdentityPools/mdch-lab-cluster-pool/providers/fluxcd"
}
