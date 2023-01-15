//Scope
targetScope = 'resourceGroup'
//Variables

//Parameters
param loganalyticsregion string

//Resources
//Azure Policy Remeditation Task User Managed Identity (Subscribtion Contributor)
resource mdcmanagedidentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' = {
  name: 'mdc-azpolicy'
  location: loganalyticsregion
}

output miresourcepid string = mdcmanagedidentity.properties.principalId
output mirid string = mdcmanagedidentity.id
output mirname string = mdcmanagedidentity.name








