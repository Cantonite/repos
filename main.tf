terraform {
  required_version = "1.0.9"

  backend "remote" {
    organization = "Cantonite"

    workspaces {
      name = "repos"
    }
  }
}

locals {
  repos = {
    "terraform-deployment-pipeline" = {
      description        = "A sample application which uses Terraform and is promoted through a pipeline"
      gitignore_template = "Terraform"
      topics             = ["terraform", "pipelines", "samples"]
    }
  }
}

resource "github_repository" "this" {
  for_each = local.repos

  name               = each.key
  description        = each.value.description
  gitignore_template = each.value.gitignore_template
  topics             = each.value.topics
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
  for_each = local.repos

  branch     = "main"
  repository = github_repository.this[each.key].name
}
