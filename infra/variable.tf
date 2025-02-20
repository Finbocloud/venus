variable "rg_name" {
  description = "resourcegroup name"
  type        = string
  default     = "rg"
}
variable "owner" {
  description = "resource owner"
  type        = string
  default     = "ray"
}
variable  "environment"{
    description = "resource environment"
    type        = string
    default     = "dev"
}
variable "location" {
  description = "resourcegroup location"
  type        = string
  default     = "uksouth"
}
variable "vnet" {
  description = "virtual network"
  type        = string
  default     = "vnet"
}
variable "subnet" {
  description = "network subnet"
  type        = string
  default     = "subnet"
}
variable "nic" {
  description = "network interface card"
  type        = string
  default     = "nic"
}
variable "public_ip" {
  description = "public ip address"
  type        = string
  default     = "public_ip"
}
variable "linux_vm_name" {
  description = "linux vm name"
  type        = string
  default     = "linuxvm"
}
variable "aks_name" {
  description = "aks name"
  type        = string
  default     = "kubernetes-service"
}
variable "acr_name" {
  description = "acr name"
  type        = string
  default     = "containerregistery"
}
variable "role_definition_name" {
  description = "The role definition name for the role assignment"
  type        = string
  default     = "AcrPull"
}
variable "vm_nsg" {
  description = "virtual machine netwirk securuty group"
  type        = string
  default     = "vm-nsg"
}




