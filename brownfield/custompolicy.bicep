//Scope
targetScope = 'subscription'

//Parameters
param azmanagedidentity string
param loganalyticsregion string

//Variables
var configure_machine_configurations_on_windows_servers = json(loadTextContent('./Configure_Machine_Configurations_on_Windows_Servers.json'))
var configure_sentinel_dns_extension_on_windows_servers = json(loadTextContent('./Configure_Sentinel_DNS_Extension_on_Windows_Servers.json'))


//Custom Definitions & Assignments
resource policy1 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'configure_machine_configurations_on_windows_servers'
  properties: configure_machine_configurations_on_windows_servers.properties
}

resource policy1as 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: 'Configure Machine Configurations on Windows Servers'
  location: loganalyticsregion
  scope: subscription()
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    description: 'This policy will create Guest Assignments for MDE-Quickstart to configure Windows Defender policy settings'
    displayName: 'Configure Machine Configurations on Windows Servers'
    parameters: {
      IncludeArcMachines: {
        value:'false'
      }
    }
    policyDefinitionId: policy1.id
  }
}

resource policy2 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'configure_sentinel_dns_extension_on_windows_server'
  properties: configure_sentinel_dns_extension_on_windows_servers.properties
}

resource policy2as 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: 'Configure Sentinel DNS Extension on Windows Servers'
  location: loganalyticsregion
  scope: subscription()
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    description: 'This policy will install the Sentinel DNS Extension for MDE-Quickstart'
    displayName: 'Configure Sentinel DNS Extension on Windows Servers'
    parameters: {
    }
    policyDefinitionId: policy2.id
  }
}








