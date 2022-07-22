terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  cloud {
    organization = "fabio"

    workspaces {
      name = "terraform-challenge"
    }
  }
}

#xd4
provider "azurerm" {
  features {
    resource_group { 
      prevent_deletion_if_contains_resources = false
    }
  }
}

