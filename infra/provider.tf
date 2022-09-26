provider "google" {}

terraform {
  required_version = "1.3.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.36.0"
    }
  }
  backend "local" {
    path = "rails-cloud-spanner/terraform.tfstate"
  }

}

data "google_project" "default" {}
