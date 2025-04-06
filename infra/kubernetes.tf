# resource "azurerm_kubernetes_cluster" "this_aks" {
#   name                = "${local.owner}-${local.environment}-${var.aks_name}"
#   location            = azurerm_resource_group.this_rg.location
#   resource_group_name = azurerm_resource_group.this_rg.name
#   dns_prefix          = "akscluster"
#   kubernetes_version  = "1.27.3"
# data "azurerm_kubernetes_service_versions" "current" {
#   location = azurerm_resource_group.this_rg.location
# }

resource "azurerm_kubernetes_cluster" "this_aks" {
  name                = "${local.owner}-${local.environment}-${var.aks_name}"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
  dns_prefix          = "akscluster"
  kubernetes_version  = "1.30.9"
  
  node_resource_group = "${azurerm_resource_group.this_rg.name}-network-rg"
  default_node_pool {
    name                 = "systempool"
    vm_size              = "Standard_DS2_v2"
    orchestrator_version = "1.30.9"
    zones                = [1, 2, 3]
    auto_scaling_enabled = true
    #enable_auto_scaling  = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    vnet_subnet_id       = azurerm_subnet.this_subnet.id
    node_labels = {
      "nodepool-type" = "system"
      "environment"   = "dev"
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
    tags = {
      "nodepool-type" = "system"
      "environment"   = "dev"
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
  }
  # Identity (System Assigned or Service Principal)
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this_user_id.id]
  }
  #add_profile
  azure_policy_enabled = true
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
    dns_service_ip    = "10.3.0.10"
    service_cidr      = "10.3.0.0/16"
  }

  tags = local.tags
}