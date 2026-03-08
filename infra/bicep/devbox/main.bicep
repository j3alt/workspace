targetScope = 'resourceGroup'

@description('Azure region for all resources')
param location string

@description('Name of the Dev Center')
param devCenterName string

@description('Name of the project')
param projectName string

@description('Name of the network connection')
param networkConnectionName string

@description('Resource tags')
param tags object = {}

// Dev Center with system-assigned managed identity
module devCenter 'modules/dev-center.bicep' = {
  name: 'deploy-dev-center'
  params: {
    name: devCenterName
    location: location
    tags: tags
  }
}

// Microsoft-hosted network connection (no custom vnet)
module networkConnection 'modules/network-connection.bicep' = {
  name: 'deploy-network-connection'
  params: {
    name: networkConnectionName
    location: location
    tags: tags
    devCenterName: devCenter.outputs.name
  }
}

// DevBox definition: Visual Studio 2022 on Windows 11
module devboxDefinition 'modules/devbox-definition.bicep' = {
  name: 'deploy-devbox-definition'
  params: {
    devCenterName: devCenter.outputs.name
    location: location
    name: 'vs-2022-win11'
    imageReferenceId: 'microsoftvisualstudio_visualstudioplustools_vs-2022-ent-general-win11-m365-gen2'
    sku: 'general_i_8c32gb256ssd_v2'
    osStorageType: 'ssd_256gb'
  }
}

// Project linked to Dev Center
module project 'modules/project.bicep' = {
  name: 'deploy-project'
  params: {
    name: projectName
    location: location
    tags: tags
    devCenterId: devCenter.outputs.id
    maxDevBoxesPerUser: 2
  }
}

// Pool referencing definition and network connection
module pool 'modules/pool.bicep' = {
  name: 'deploy-pool'
  params: {
    projectName: project.outputs.name
    name: 'default'
    location: location
    devBoxDefinitionName: devboxDefinition.outputs.name
    networkConnectionName: networkConnection.outputs.attachedNetworkName
    localAdministrator: 'Enabled'
    licenseType: 'Windows_Client'
    singleSignOnStatus: 'Enabled'
    stopOnDisconnectGracePeriodMinutes: 60
  }
}
