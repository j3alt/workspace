using './main.bicep'

param location = 'westus3'
param devCenterName = 'dc-workspace'
param projectName = 'proj-workspace'
param networkConnectionName = 'nc-workspace'
param tags = {
  environment: 'dev'
  managedBy: 'bicep'
}
