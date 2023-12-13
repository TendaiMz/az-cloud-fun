@description('Specifies the location for resources.')
param location string = 'Australia East'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'tyndostorage'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties:  {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: 'tyndo-app-service-plan'
  location: location
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01'= {
name: 'tyndo-app-launch'
location: location
properties: {
  serverFarmId: appServicePlan.id
  httpsOnly: true
}
}
