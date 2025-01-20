resource "azurerm_container_registry" "example" {
  name                = "${local.owner}-${local.environment}-${var.acr_name}"
  resource_group_name = azurerm_resource_group.this_rg.name
  location            = azurerm_resource_group.this_rg.location
  sku                 = "Premium"
}