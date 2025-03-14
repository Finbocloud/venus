resource "azurerm_container_registry" "this" {
  name                = "uniqueacrname2025"
  resource_group_name = azurerm_resource_group.this_rg.name
  location            = azurerm_resource_group.this_rg.location
  sku                 = "Premium"
}
