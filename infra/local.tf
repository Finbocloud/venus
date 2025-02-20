locals {
    owner = var.owner
    environment = var.environment
    tags = {
        environment = "dev"
        owner = "DevOps"
        managed-by = "terraform"
    }
}