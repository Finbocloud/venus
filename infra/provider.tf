terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"  # Updated to latest stable version
    }
  }
  backend "azurerm" {
    storage_account_name = "venusstorageaccount"
    container_name      = "venusstatefile"
    key                 = "venus.tfstate"
    resource_group_name = "DefaultResourceGroup-WEU"
  }
}

provider "azurerm" {
  # Remove the hardcoded subscription_id and use az login instead
  features {}
}
  
