terraform {
  required_providers {
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 1.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.4.0"
    }
    oci = {
      source  = "hashicorp/oci"
      version = ">= 4.7.0"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 2.1.2"
    }
  }
  required_version = ">= 0.13"
}
