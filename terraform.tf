terraform {
  required_version = "1.0.9"

  backend "remote" {
    organization = "Cantonite"

    workspaces {
      name = "repos"
    }
  }
}
