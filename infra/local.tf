locals {
    owner = var.owner
    environment = var.environment
    tags = {
        environment = var.environment
        owner = var.owner
        managed-by = "terraform"
    }
}