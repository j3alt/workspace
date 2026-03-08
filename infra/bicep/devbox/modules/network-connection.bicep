@description('Name of the network connection')
param name string

@description('Azure region')
param location string

@description('Resource tags')
param tags object = {}

@description('Name of the Dev Center to attach to')
param devCenterName string

resource networkConnection 'Microsoft.DevCenter/networkConnections@2024-02-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    domainJoinType: 'None'
    networkingResourceGroupName: '${resourceGroup().name}-ni-${name}'
  }
}

resource devCenter 'Microsoft.DevCenter/devcenters@2024-02-01' existing = {
  name: devCenterName
}

resource attachedNetwork 'Microsoft.DevCenter/devcenters/attachednetworks@2024-02-01' = {
  parent: devCenter
  name: name
  properties: {
    networkConnectionId: networkConnection.id
  }
}

@description('The resource ID of the network connection')
output id string = networkConnection.id

@description('The name of the network connection')
output name string = networkConnection.name

@description('The name of the attached network')
output attachedNetworkName string = attachedNetwork.name
