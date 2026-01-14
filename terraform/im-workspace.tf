module "im-workspace" {
  source                     = "terraform-google-modules/bootstrap/google//modules/im_cloudbuild_workspace"
  version                    = "~> 11.0"
  location                   = var.region
  trigger_location           = var.region
  project_id                 = var.project_id
  repo_connection_name       = "im-mdch-lab"
  deployment_id              = var.deployment_id
  im_deployment_repo_uri     = var.im_deployment_repo_uri
  im_deployment_ref          = "main"
  infra_manager_sa           = var.infra_manager_sa
  custom_cloudbuild_sa_name  = "cb-sa-mdch-lab"
  github_app_installation_id = var.github_app_installation_id
  github_pat_secret          = var.github_pat_secret
}
