resource "azurerm_linux_virtual_machine" "this_linux_vm" {
  name                = "${local.owner}-${local.environment}-${var.linux_vm_name}"
  resource_group_name = azurerm_resource_group.this_rg.name
  location            = azurerm_resource_group.this_rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.this_vm_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/azure_terraform_key.pub")
    #ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure_terraform_key -C "vitaliseaka@ymail.com"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
custom_data = filebase64("${path.module}/cloud-init.yml")
}

#1. generate ssh key (both private and public) using the below command
# ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure_terraform_key
# ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure_terraform_key -C "vitaliseaka@ymail.com"

# Ensure public IP config is set and linked in network interface card
# or
# Option 2: Use Azure CLI to Get the Private IP (For Internal Access) If you don't want to assign a public IP,
# you can access the VM from another Azure VM within the same virtual network:
# az vm list-ip-addresses -g example-resources -n example-machine --query "[].virtualMachine.network.privateIpAddresses" -o tsv

#2. ssh into the vm using
# ssh -i ~/.ssh/azure_terraform_key adminuser@51.145.42.110  
# or
# If using a private IP (internal connection from another Azure VM):
# ssh -i ~/.ssh/id_rsa adminuser@<PRIVATE_IP>




#3. Once logged in, change the password using below command
# passwd

#4. Install docker using below command
# ssh -i ~/.ssh/azure_terraform_key Sargeene@51.145.42.110
