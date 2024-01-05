//Scope
targetScope = 'resourceGroup'
//Variables

//Parameters
param loganalyticsregion string

//Resources
//Azure Policy Remeditation Task User Managed Identity
resource mdcmanagedidentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: 'umi-mdc-azpolicy-arc'
  location: loganalyticsregion
}

output miresourcepid string = mdcmanagedidentity.properties.principalId
output mirid string = mdcmanagedidentity.id
output mirname string = mdcmanagedidentity.name








