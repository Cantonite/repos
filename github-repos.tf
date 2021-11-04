resource "github_repository" "this" {
  for_each = local.applications

  name               = each.value.name
  description        = each.value.description
  gitignore_template = try(each.value.gitignore_template, null)
  topics             = each.value.tags
  homepage_url       = "cantonite.com"
  license_template   = "agpl-3.0"
  visibility         = "public"

  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  archive_on_destroy     = false
  archived               = false
  auto_init              = true
  delete_branch_on_merge = true
  has_downloads          = false
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  is_template            = false
  vulnerability_alerts   = true
}

resource "github_branch_default" "this" {
  for_each = local.applications

  branch     = "main"
  repository = github_repository.this[each.key].name
}

resource "github_repository_environment" "this" {
  for_each = local.application_environments

  environment = each.value.environment.name
  repository  = each.value.application.name

  reviewers {
    users = [data.github_user.mattcanty.id]
  }

  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}
