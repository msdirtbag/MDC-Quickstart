//Scope
targetScope = 'subscription'

//Variables

//Parameters

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
  name: 'dns'
  properties: {
    pricingTier: 'Standard'
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
