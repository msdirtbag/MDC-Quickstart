//Scope
targetScope = 'subscription'
//Variables

//Parameters
param loganalyticsregion string
param azmanagedidentity string
param mgmtresourcgroup string
param loganalyticsrid string
param muasminame string
param vminsightsdcrname string
param mdcdcr01id string
//Resources
//MDC Azure Policy
resource Policy1'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Prevent MMA Windows'
  properties: {
    displayName: 'Prevent MMA Windows'
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/df441472-4dae-4e4e-87b9-9205ba46be16'
  }
}

resource Policy2 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Prevent MMA Linux'
  properties: {
    displayName: 'Prevent MMA Linux'
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/bd58d393-162c-4134-bcd6-a6a5484a37a1'
  }
}

resource Policy3 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Configure periodic checking for missing system updates'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure periodic checking for missing system updates'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/bfea026e-043f-4ff4-9d1b-bf301ca7ff46'
  }
}

resource Policy4 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Configure Microsoft Defender for Endpoint Windows'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Microsoft Defender for Endpoint Windows'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/37c043a6-6d64-656d-6465-b362dfeb354a'
  }
}

resource Policy5 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Configure Microsoft Defender for Endpoint Linux'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Microsoft Defender for Endpoint Linux'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/4eb909e7-6d64-656d-6465-2eeb297a1625'
  }
}

resource Policy6 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Configure Microsoft Defender for Cloud AMA'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Microsoft Defender for Cloud AMA'
    parameters: {
      workspaceRegion: {
        value: loganalyticsregion
      }
      userWorkspaceResourceId:{
        value: loganalyticsrid
      }
      bringYourOwnUserAssignedManagedIdentity:{
        value: true
      }
      userAssignedManagedIdentityName:{
        value: muasminame
      }
      userAssignedManagedIdentityResourceGroup:{
        value: mgmtresourcgroup
      }

    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policySetDefinitions/500ab3a2-f1bd-4a5a-8e47-3e09d9a294c3'
  }
}

resource Policy7 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Auditing on SQL server should be enabled'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  properties: {
    displayName: 'Auditing on SQL server should be enabled'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/a6fb4358-5bf4-4ad7-ba82-2cd2f41ce5e9'
  }
}

resource Policy8 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Adaptive application controls should be enabled'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  properties: {
    displayName: 'Adaptive application controls should be enabled'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/47a6b606-51aa-4496-8bb7-64b11cf66adc'
  }
}

resource Policy9 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Enable ChangeTracking and Inventory'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Enable ChangeTracking and Inventory'
    parameters:{
      dcrResourceId: {
        value:mdcdcr01id
      }
    }  
    policyDefinitionId: '/providers/Microsoft.Authorization/policySetDefinitions/53448c70-089b-4f52-8f38-89196d7f2de1'
  }
}

resource Policy10 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Enable Azure Monitor for VMs'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Enable Azure Monitor for VMs'
    parameters:{
      enableProcessesAndDependencies: {
        value:true
      }
      dataCollectionRuleName: {
        value:vminsightsdcrname
      }
      logAnalyticsWorkspace:{
        value:loganalyticsrid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policySetDefinitions/59e9c3eb-d8df-473b-8059-23fd38ddd0f0'
  }
}

resource Policy11'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Configure SQL Server extension on Arc Servers'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure SQL Server extension on Arc Servers'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/fd2d1a6e-6d95-4df2-ad00-504bf0273406'
  }
}

resource Policy12'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Audit STIG Requirements for Windows'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  properties: {
    displayName: 'Audit STIG Requirements for Windows'
    parameters:{
      IncludeArcMachines: {
        value:'true'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/50c52fc9-cb21-4d99-9031-d6a0c613361c'
  }
}

resource Policy13'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Audit STIG Requirements for Linux'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  properties: {
    displayName: 'Audit STIG Requirements for Linux'
    parameters:{
      IncludeArcMachines: {
        value:'true'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/50c52fc9-cb21-4d99-9031-d6a0c613361c'
  }
}
