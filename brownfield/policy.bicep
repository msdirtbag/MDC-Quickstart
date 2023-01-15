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
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/1ec9c2c2-6d64-656d-6465-3ec3309b8579'
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
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/d30025d0-6d64-656d-6465-67688881b632'
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
  name: 'Adaptive network hardening recommendations should be applied'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  properties: {
    displayName: 'Adaptive network hardening recommendations should be applied'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/08e6af2d-db70-460a-bfe9-d5bd474ba9d6'
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
  name: 'Configure SQL Server extension on Servers'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure SQL Server extension on Servers'
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

resource Policy14 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Adaptive application controls should be enabled'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Adaptive application controls should be enabled'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/47a6b606-51aa-4496-8bb7-64b11cf66adc'
  }
}

resource Policy15 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Configure Windows Server Automanage'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Windows Server Automanage'
    parameters: {
      configurationProfile: {
        value: 'mdc-automanage-windows-vm'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/b025cfb4-3702-47c2-9110-87fe0cfcc99b'
  }
}

resource Policy16 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Deploy prerequisites to enable Guest Configuration policies'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Deploy prerequisites to enable Guest Configuration policies'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policySetDefinitions/2b0ce52e-301c-4221-ab38-1601e2b4cee3'
  }
}
