# Instructions

### Deploy

```bash
az group create --name demo --location "eastus2"
az container create --resource-group demo --name demo-api --image danielscholl/demoapi --dns-name-label dks-demo --ports 80


az appservice plan create --name demo-plan --resource-group demo --sku S1 --is-linux

az webapp create --resource-group demo --plan demo-plan --name demo-api --multicontainer-config-type compose --multicontainer-config-file docker-compose.yml

```