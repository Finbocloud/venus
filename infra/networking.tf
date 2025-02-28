resource "azurerm_subnet" "this_subnet" {
  name                 = "${local.owner}-${local.environment}-${var.subnet}"
  resource_group_name  = azurerm_resource_group.this_rg.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "this_vm_nic" {
  name                = "${local.owner}-${local.environment}-${var.nic}"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name

  ip_configuration {
    name                          = "ip-configuration-vm"
    subnet_id                     = azurerm_subnet.this_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this_publicip.id
  }
}

resource "azurerm_public_ip" "this_publicip" {
  name                    = "${local.owner}-${local.environment}-${var.public_ip}"
  location                = azurerm_resource_group.this_rg.location
  resource_group_name     = azurerm_resource_group.this_rg.name
  allocation_method       = "Static" 

  tags = local.tags
}

resource "azurerm_network_interface_security_group_association" "this_nsg_association" {
  network_interface_id      = azurerm_network_interface.this_vm_nic.id
  network_security_group_id = azurerm_network_security_group.this_nsg.id
}