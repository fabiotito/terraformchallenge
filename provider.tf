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

#xd2
provider "azurerm" {
  features {}
}

