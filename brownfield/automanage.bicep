//Scope
targetScope = 'resourceGroup'
//Variables

//Parameters
param loganalyticsregion string

//Resources
resource mdcautomanagewindows 'Microsoft.Automanage/configurationProfiles@2022-05-04' = {
  name: 'mdc-automanage-windows-vm'
  location: loganalyticsregion
  properties: {
    configuration: {
      'Antimalware/Enable': 'true'
      'Antimalware/EnableRealTimeProtection': 'true'
      'AzureSecurityCenter/Enable': 'true'
      'WindowsAdminCenter/Enable': 'true'
    }
  }
}

