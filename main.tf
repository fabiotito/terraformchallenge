terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
  }
  backend "azurerm" {
    resource_group_name   = "RSGR-DS-FIRMACONTRATO-EU2-SSS-001"
    storage_account_name  = "stacdsonbeu2sss001"
    #el container varia dependiendo la capa
    container_name        = "communication-dev"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  subscription_id = "c29c9592-70d5-48d8-aa60-628bec42ab7b"

}

module "rsgr" {
  source = "./rsgr"
}