module "im-workspace" {
  source                     = "terraform-google-modules/bootstrap/google//modules/im_cloudbuild_workspace"
  location                   = var.region
  version                    = "~> 11.0"
  project_id                 = var.project_id
  deployment_id              = var.deployment_id
  im_deployment_repo_uri     = var.im_deployment_repo_uri
  im_deployment_ref          = "main"
  infra_manager_sa           = var.infra_manager_sa
  github_app_installation_id = var.github_app_installation_id
  github_pat_secret          = var.github_pat_secret
}
