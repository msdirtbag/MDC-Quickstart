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

resource mdcautomanagewindows 'Microsoft.Automanage/configurationProfiles@2022-05-04' = {
  name: 'mdc-automanage-windows-vm'
  location: loganalyticsregion
  properties: {
    configuration: {
      'Antimalware/Enable': 'true'
      'Antimalware/EnableRealTimeProtection': 'true'
      'Antimalware/RunScheduledScan': 'false'
      'AzureSecurityCenter/Enable': true
    }
  }
}







