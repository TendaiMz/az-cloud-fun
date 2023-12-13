resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'tyndo-storage'
  location: 'Australia East'
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
  location: 'Australia East'
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01'= {
name: 'tyndo-app-launch'
location: 'Australia East'
properties: {
  serverFarmId: appServicePlan.id
  httpsOnly: true
}
}
