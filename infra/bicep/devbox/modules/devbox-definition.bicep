@description('Name of the Dev Center')
param devCenterName string

@description('Azure region')
param location string

@description('DevBox definition name')
param name string

@description('Gallery image reference ID')
param imageReferenceId string

@description('Compute SKU')
param sku string

@description('OS storage type')
param osStorageType string

resource devCenter 'Microsoft.DevCenter/devcenters@2024-02-01' existing = {
  name: devCenterName
}

resource devboxDefinition 'Microsoft.DevCenter/devcenters/devboxdefinitions@2024-02-01' = {
  parent: devCenter
  name: name
  location: location
  properties: {
    imageReference: {
      id: '${devCenter.id}/galleries/default/images/${imageReferenceId}'
    }
    sku: {
      name: sku
    }
    osStorageType: osStorageType
  }
}

@description('The resource ID of the DevBox definition')
output id string = devboxDefinition.id

@description('The name of the DevBox definition')
output name string = devboxDefinition.name
