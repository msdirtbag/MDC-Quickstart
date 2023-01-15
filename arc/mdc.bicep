//Scope
targetScope = 'subscription'

//Variables

//Parameters
param vulnerabilityassessmentprovidertype string = 'mdeTvm'

//Resources
resource cspmplan 'Microsoft.Security/pricings@2022-03-01' = {
  name: 'CloudPosture'
  properties: {
    pricingTier: 'Standard'
  }
}

resource serversplan 'Microsoft.Security/pricings@2022-03-01' = {
  name: 'VirtualMachines'
  dependsOn: [
    cspmplan
  ]
  properties: {
    pricingTier: 'Standard'
    subPlan: 'P2'
  }
}

resource dnsplan 'Microsoft.Security/pricings@2022-03-01' = {
  name: 'Dns'
  properties: {
    pricingTier: 'Standard'
  }
}

resource sqlplan 'Microsoft.Security/pricings@2022-03-01' = {
  name: 'SqlServerVirtualMachines'
  properties: {
    pricingTier: 'Standard'
  }
}

#disable-next-line BCP081
resource defendervulnerabilitymanagement 'Microsoft.Security/serverVulnerabilityAssessmentsSettings@2022-01-01-preview' = if (vulnerabilityassessmentprovidertype =~ 'mdeTvm') {
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

#disable-next-line BCP081
resource agentlessscanning 'Microsoft.Security/VmScanners@2022-03-01-preview' = {
  name: 'default'
  dependsOn: [
    cspmplan
    serversplan
  ]
  properties: {
    scanningMode: 'Default'
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
