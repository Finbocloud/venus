terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.15.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "2ee241a3-3686-4588-bdd7-226f42aa2b20"
  features{}
}
  
