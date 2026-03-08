@description('Name of the Dev Center')
param name string

@description('Azure region')
param location string

@description('Resource tags')
param tags object = {}

resource devCenter 'Microsoft.DevCenter/devcenters@2024-02-01' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
}

@description('The resource ID of the Dev Center')
output id string = devCenter.id

@description('The name of the Dev Center')
output name string = devCenter.name

@description('The principal ID of the system-assigned managed identity')
output principalId string = devCenter.identity.principalId
