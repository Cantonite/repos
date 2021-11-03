resource "tfe_workspace" "application_environment" {
  for_each = local.application_environments

  name                = "${each.value.application.name}-${each.value.environment.name}"
  organization        = "Cantonite"
  allow_destroy_plan  = false
  speculative_enabled = false
  auto_apply          = false
  execution_mode      = "local"
  working_directory   = "terraform/environments/${each.value.environment.name}"

  vcs_repo {
    identifier     = "Cantonite/${each.value.application.name}"
    oauth_token_id = var.oauth_token_id
    branch         = "main"
  }

  tag_names = concat(
    each.value.application.tags,
    [each.value.environment.name]
  )
}
