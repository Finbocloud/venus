terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"  # Updated to latest stable version
    }
  }
}

provider "azurerm" {
  # Remove the hardcoded subscription_id and use az login instead
  features {}
}
  
