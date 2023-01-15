//Scope
targetScope = 'subscription'

//Parameters
param azmanagedidentity string
param loganalyticsregion string

//Variables
var configure_machine_configurations_on_windows_servers = json(loadTextContent('./Configure_Machine_Configurations_on_Windows_Servers.json'))
var configure_mdc_automanage_on_windows_arc_servers = json(loadTextContent('./Configure_MDC_Automanage_on_Windows_Arc_Servers.json'))
var configure_windows_admin_center_on_windows_arc_servers = json(loadTextContent('./Configure_Windows_Admin_Center_on_Windows_Arc_Servers.json'))

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
        value:'true'
      }
    }
    policyDefinitionId: policy1.id
  }
}

resource policy2 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'configure_mdc_automanage_on_windows_arc_servers'
  properties: configure_mdc_automanage_on_windows_arc_servers.properties
}

resource policy2as 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: 'Configure MDC Automanage on Windows Arc Servers'
  location: loganalyticsregion
  scope: subscription()
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    description: 'This policy will link devices to the mdc-automanage-windows-arc custom configuration profile for MDE-Quickstart'
    displayName: 'Configure MDC Automanage on Windows Arc Servers'
    parameters: {
      configurationProfile: {
        value: 'mdc-automanage-windows-arc'
      }
    }
    policyDefinitionId: policy2.id
  }
}

resource policy3 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'configure_windows_admin_center_on_windows_arc_servers'
  properties: configure_windows_admin_center_on_windows_arc_servers.properties
}

resource policy3as 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: 'Configure Windows Admin Center on Windows Arc Servers'
  location: loganalyticsregion
  scope: subscription()
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    description: 'This policy will install the Windows Admin Center Extension for MDE-Quickstart'
    displayName: 'Configure Windows Admin Center on Windows Arc Servers'
    parameters: {
    }
    policyDefinitionId: policy3.id
  }
}








