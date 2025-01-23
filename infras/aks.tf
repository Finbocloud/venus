#Read the configuration details at the foot of this manifest
resource "azurerm_kubernetes_cluster" "this_aks" {
  name                = "${local.owner}-${var.aks_name}-${local.environment}"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
  dns_prefix          = "${var.environment}-cluster"
  kubernetes_version  = "2.35.1"
  #kubernetes_version  = data.azurerm_kubernetes_service_versions.current.version_prefix
  node_resource_group = "${azurerm_resource_group.this_rg.name}-network-rg"
  default_node_pool {
    name                 = "systempool"
    vm_size              = "Standard_DS2_v2"
    orchestrator_version = "1.29.7" #data.azurerm_kubernetes_service_versions.current.version_prefix
    zones                = [1, 2, 3]
    enable_auto_scaling  = True
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
  #oms_agent
  # oms_agent {
  #   log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
  # }
  #Azure AD Integration Block
  # azure_active_directory_role_based_access_control {
  #   managed                = true
  #   admin_group_object_ids = [azuread_group.aks_administrators.id]
  # }
  # # Linux Profile
  # linux_profile {
  #   admin_username = var.linux_profile_admin_username
  #   ssh_key {
  #     key_data = file(var.ssh_public_key)
  #   }
  # }
  # Network Profile
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
    dns_service_ip    = "10.3.0.10"
    service_cidr      = "10.3.0.0/16"
  }
  tags = local.tags
}





# resource "azurerm_kubernetes_cluster" "this_aks" {
#   name                = var.aks-name
#   location            = azurerm_resource_group.this_rg.location
#   resource_group_name = azurerm_resource_group.this_rg.name
#   dns_prefix          = "dns-prefix"

#   default_node_pool {
#     name       = "default"
#     node_count = 1
#     vm_size    = "Standard_D2_v2"
#   }

#    identity {
#     type = "UserAssigned"
#     identity_ids = [azurerm_user_assigned_identity.this_user_id.id]
#   }
#   tags = local.tags
# }