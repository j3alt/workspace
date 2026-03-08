@description('Name of the project')
param projectName string

@description('Name of the pool')
param name string

@description('Azure region')
param location string

@description('Name of the DevBox definition')
param devBoxDefinitionName string

@description('Name of the attached network connection')
param networkConnectionName string

@description('Local administrator access')
@allowed(['Enabled', 'Disabled'])
param localAdministrator string = 'Enabled'

@description('License type')
param licenseType string = 'Windows_Client'

@description('Single sign-on status')
@allowed(['Enabled', 'Disabled'])
param singleSignOnStatus string = 'Enabled'

@description('Stop on disconnect grace period in minutes')
param stopOnDisconnectGracePeriodMinutes int = 60

resource project 'Microsoft.DevCenter/projects@2024-02-01' existing = {
  name: projectName
}

resource pool 'Microsoft.DevCenter/projects/pools@2024-02-01' = {
  parent: project
  name: name
  location: location
  properties: {
    devBoxDefinitionName: devBoxDefinitionName
    networkConnectionName: networkConnectionName
    licenseType: licenseType
    localAdministrator: localAdministrator
    singleSignOnStatus: singleSignOnStatus
    stopOnDisconnect: {
      status: 'Enabled'
      gracePeriodMinutes: stopOnDisconnectGracePeriodMinutes
    }
  }
}

@description('The resource ID of the pool')
output id string = pool.id

@description('The name of the pool')
output name string = pool.name
