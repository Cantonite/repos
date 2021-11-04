locals {
  applications = {
    "terraform-reusable-workflows-crash" = {
      name               = "terraform-reusable-workflows-crash"
      description        = "I spotted a weird issue with Terraform application crashing when used in a reusable workflow."
      gitignore_template = "Terraform"
      tags               = ["terraform", "pipelines", "samples"]
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
