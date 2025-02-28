provider "azurerm" {
  subscription_id = "2ee241a3-3686-4588-bdd7-226f42aa2b20"
  features {}
}
resource "azurerm_resource_group" "example" {
  name     = "my-resources"
  location = "West Europe"
}