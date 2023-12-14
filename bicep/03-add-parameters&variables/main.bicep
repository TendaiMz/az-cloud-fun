param location string = resourceGroup().location
param storageAccountName string = 'demoApp${uniqueString(resourceGroup().id)}'
param appserviceAppName string = 'demoApp-${uniqueString(resourceGroup().id)}'

@allowed([
  'nonprod'
  'prod'
])
param deploymentEnvironment string

var storageAccSkuName = deploymentEnvironment == 'prod' ? 'Standard_GRS': 'Standard_LRS'
var appServicePlanSku = deploymentEnvironment == 'prod' ? 'P2v3':'F1'

var appServicePlanName = 'demoApp-service-plan'

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku:{
    name: storageAccSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
name: appServicePlanName
location: location
sku: {
  name: appServicePlanSku
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-09-01' = {
  name: appserviceAppName
  location:location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
