#Set provider 

provider "google" {
  credentials = file(var.gcp_credentials)
  project     = var.gcp_project_id
  region      = var.gcp_region
}


# put tfstate to google storage bucket
# https://developer.hashicorp.com/terraform/language/settings/backends/gcs

terraform {       # встановлює глобальні налаштування для Terraform
  backend "gcs" { # backend для зберігання стану в Google Cloud Storage
    bucket = "kuzianin-tf-state-prod"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

