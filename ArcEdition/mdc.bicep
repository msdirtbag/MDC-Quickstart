//Scope
targetScope = 'subscription'

//Variables

//Parameters
param loganalyticsrid string

//Resources
resource cspmplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'CloudPosture'
  properties: {
    pricingTier: 'Standard'
    extensions: [
      {
        name: 'AgentlessVmScanning'
        isEnabled: 'True'
      }
      {
        name: 'AgentlessDiscoveryForKubernetes'
        isEnabled: 'True'
      }
      {
        name: 'SensitiveDataDiscovery'
        isEnabled: 'True'
      }
      {
        name: 'ContainerRegistriesVulnerabilityAssessments'
        isEnabled: 'True'
      }
      {
        name: 'EntraPermissionsManagement'
        isEnabled: 'True'
      }
    ]
  }
}

resource serversplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'VirtualMachines'
  properties: {
    pricingTier: 'Standard'
    subPlan: 'P2'
    extensions: [
      {
        name: 'AgentlessVmScanning'
        isEnabled: 'True'
      }
      {
        name: 'MdeDesignatedSubscription'
        isEnabled: 'False'
      }
    ]
  }
  dependsOn: [
    cspmplan
  ]
}

resource sqlvmplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'SqlServerVirtualMachines'
  properties: {
    pricingTier: 'Standard'
    extensions: [
    ]
  }
  dependsOn: [
    serversplan
  ]
}

resource sqlplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'SqlServers'
  properties: {
    pricingTier: 'Standard'
  }
  dependsOn: [
    sqlvmplan
  ]
}

resource cosmosplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'CosmosDbs'
  properties: {
    pricingTier: 'Standard'
  }
  dependsOn: [
    sqlplan
  ]
}

resource osdbplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'OpenSourceRelationalDatabases'
  properties: {
    pricingTier: 'Standard'
  }
  dependsOn: [
    cosmosplan
  ]
}

resource apiplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'Api'
  properties: {
    pricingTier: 'Standard'
  }
  dependsOn: [
    osdbplan
  ]
}

resource appservplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'AppServices'
  properties: {
    pricingTier: 'Standard'
  }
  dependsOn: [
    apiplan
  ]
}

resource kvplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'KeyVaults'
  properties: {
    pricingTier: 'Standard'
    subPlan: 'PerKeyVault'
  }
  dependsOn: [
    appservplan
  ]
}

resource storageplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'StorageAccounts'
  properties: {
    pricingTier: 'Standard'
    extensions: [
      {
        name: 'OnUploadMalwareScanning'
        isEnabled: 'True'
      }
      {
        name: 'SensitiveDataDiscovery'
        isEnabled: 'True'
      }
    ]
    subPlan: 'DefenderForStorageV2'
  }
  dependsOn: [
    kvplan
  ]
}

resource armplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'Arm'
  properties: {
    pricingTier: 'Standard'
    subPlan: 'PerSubscription'
  }
  dependsOn: [
    storageplan
  ]
}

resource containersplan 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'Containers'
  properties: {
    pricingTier: 'Standard'
    extensions: [
      {
      name: 'ContainerRegistriesVulnerabilityAssessments'
      isEnabled: 'True'
      }
      {
        name: 'AgentlessDiscoveryForKubernetes'
        isEnabled: 'True'
      }
    ]
  }
  dependsOn: [
    armplan
  ]
}

resource defendervulnerabilitymanagement 'Microsoft.Security/serverVulnerabilityAssessmentsSettings@2022-01-01-preview' = {
  name: 'AzureServersSetting'
  kind: 'AzureServersSetting'
  dependsOn: [
    cspmplan
    serversplan
  ]
  properties: {
    selectedProvider: 'MdeTvm'
  }
}

resource autoprovisioning 'Microsoft.Security/autoProvisioningSettings@2017-08-01-preview' = {
  name: 'default'
  dependsOn: [
    serversplan
  ]
  properties: {
    autoProvision: 'Off'
  }
}

resource mdcla 'Microsoft.Security/workspaceSettings@2017-08-01-preview' = {
  name: 'default'
  properties: {
    scope: subscription().id
    workspaceId: loganalyticsrid
  }
}

