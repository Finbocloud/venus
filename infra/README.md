# Azure Infrastructure Documentation

## Code Changes and Fixes

### 1. Kubernetes Configuration (kubernetes.tf)
- Fixed Kubernetes version compatibility from 1.27.3 to 1.30.9
- Changed auto_scaling_enabled to enable_auto_scaling
- Updated orchestrator_version to match kubernetes_version

### 2. Container Registry (acr.tf)
- Updated ACR name to be globally unique using: ${local.owner}${local.environment}acr
- Set Premium SKU for advanced features

### 3. Network Security Group (nsg.tf)
Enabled ports:
- 22 (SSH)
- 9000 (SonarQube)
- 3000 (Grafana)

## Access Information

### VM Access

### Services URLs
- SonarQube: http://51.140.187.31:9000
  - Username: admin
  - Password: admin
- Grafana: http://51.140.187.31:3000
  - Username: admin
  - Password: admin

### Docker Commands

```bash
# Check containers
docker ps

# Restart if needed
docker restart sonarqube postgres grafana

# Check logs
docker logs sonarqube
docker logs grafana
```

## Important Notes
1. Change default passwords for SonarQube and Grafana
2. Keep SSH key secure (~/.ssh/azure_terraform_key)
3. All services are running in Docker containers
4. AKS cluster is running version 1.30.9

## Troubleshooting
If services are not accessible:
1. Check NSG rules
2. Verify Docker containers are running
3. Check service logs using docker logs