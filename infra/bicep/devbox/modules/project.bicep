@description('Name of the project')
param name string

@description('Azure region')
param location string

@description('Resource tags')
param tags object = {}

@description('Resource ID of the Dev Center')
param devCenterId string

@description('Maximum DevBoxes per user')
param maxDevBoxesPerUser int = 2

resource project 'Microsoft.DevCenter/projects@2024-02-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    devCenterId: devCenterId
    maxDevBoxesPerUser: maxDevBoxesPerUser
  }
}

@description('The resource ID of the project')
output id string = project.id

@description('The name of the project')
output name string = project.name
