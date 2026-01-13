locals {
  flux_controllers = {
    "source-controller" = [
      "roles/artifactregistry.reader",
      "roles/storage.bucketViewer",
      "roles/storage.objectViewer"
    ]
    "kustomize-controller" = [
      "roles/cloudkms.cryptoKeyDecrypter",
      "roles/container.clusterViewer"
    ]
    "helm-controller" = [
      "roles/container.clusterViewer"
    ]
    "notification-controller" = [
      "roles/pubsub.publisher"
    ]
    "image-reflector-controller" = [
      "roles/artifactregistry.reader"
    ]
  }
  gcp_sa_roles = flatten([
    for sa, roles in local.flux_controllers : [
      for role in roles : {
        sa_name = sa
        role    = role
      }
    ]
  ])
}

