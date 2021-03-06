locals {
  applications = {
    ".github" = {
      name               = ".github"
      description        = "Centralised repository for org-wide sharing."
      gitignore_template = "Terraform"
      tags               = ["github"]
      environments       = {}
    }
    "terraform-deployment-pipeline" = {
      name               = "terraform-deployment-pipeline"
      description        = "A sample application which uses Terraform and is promoted through a pipeline."
      gitignore_template = "Terraform"
      tags               = ["terraform", "pipelines", "samples"]
      environments = {
        development = { name = "development" }
        staging     = { name = "staging" }
        production  = { name = "production" }
      }
    }
    "docker-images" = {
      name               = "docker-images"
      description        = "A place for Docker images."
      gitignore_template = "VisualStudio"
      tags               = ["docker"]
      environments       = {}
    }
    "aws-service-graph-test" = {
      name = "aws-service-graph-test"
      description = "A test suite that aimlessly calls AWS services in a chain."
      gitignore_template = "Terraform"
      tags               = ["terraform", "pipelines", "samples"]
      environments = {
        development = { name = "development" }
      }
    }
  }

  application_environment_list = flatten([
    for application_key, application in local.applications : [
      for environment_key, environment in application.environments : {
        "${application_key}-${environment_key}" = {
          "environment" = environment
          "application" = application
        }
      }
    ]
  ])

  application_environments = { for item in local.application_environment_list :
    keys(item)[0] => values(item)[0]
  }
}
