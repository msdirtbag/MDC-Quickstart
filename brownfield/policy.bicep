//Scope
targetScope = 'subscription'
//Variables

//Parameters
param loganalyticsregion string
param azmanagedidentity string
param mgmtresourcegroup string
param loganalyticsrid string


//Resources
//MDC Azure Policy
resource Policy1 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
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
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/59efceea-0c96-497e-a4a1-4eb2290dac15'
  }
}

resource Policy2 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Adaptive network hardening recommendations should be applied'
  properties: {
    displayName: 'Adaptive network hardening recommendations should be applied'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/08e6af2d-db70-460a-bfe9-d5bd474ba9d6'
  }
}

resource Policy3 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Configure Azure Security agent Windows'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Azure Security agent Windows'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/1537496a-b1e8-482b-a06a-1cc2415cdc7b'
  }
}

resource Policy4 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Configure Azure Security agent Linux'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Azure Security agent Linux'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/5f8eb305-9c9f-4abe-9bb0-df220d9faba2'
  }
}

resource Policy5 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
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

resource Policy6 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
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

resource Policy7 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'CIS Microsoft Azure Foundations Benchmark v1.4.0'
  properties: {
    displayName: 'BV-CIS Microsoft Azure Foundations Benchmark v1.4.0'
    policyDefinitionId: '/providers/Microsoft.Authorization/policySetDefinitions/c3f5c4d9-9a1d-4a99-85c0-7f93e384d5c5'
  }
}

resource Policy8 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Auditing on SQL server should be enabled'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  properties: {
    displayName: 'Auditing on SQL server should be enabled'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/a6fb4358-5bf4-4ad7-ba82-2cd2f41ce5e9'
  }
}

resource Policy9 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
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

resource Policy10 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
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

resource Policy11 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
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
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policySetDefinitions/c15c5978-ab6e-4599-a1c3-90a7918f5371'
  }
}

resource Policy12 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Configure MDC Data Collection Rule'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure MDC Data Collection Rule'
    parameters: {
      workspaceRegion: {
        value: loganalyticsregion
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policySetDefinitions/9c0aa188-e5fe-4569-8f74-b6e155624d9a'
  }
}

resource Policy13 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Configure Azure Monitor Agent Windows'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Azure Monitor Agent Windows'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policySetDefinitions/637125fd-7c39-4b94-bb0a-d331faf333a9'
  }
}

resource Policy14 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Configure Azure Monitor Agent Linux'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Azure Monitor Agent Linux'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policySetDefinitions/ae8a10e6-19d6-44a3-a02d-a2bdfc707742'
  }
}

resource Policy15 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Assign Built-In User-Assigned Managed Identity to Virtual Machines'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Assign Built-In User-Assigned Managed Identity to Virtual Machines'
    parameters: {
      bringYourOwnUserAssignedManagedIdentity: {
        value: true
      }
      userAssignedIdentityName: {
        value: 'mdc-azpolicy'
      }

      identityResourceGroup: {
        value: mgmtresourcegroup
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policySetDefinitions/d367bd60-64ca-4364-98ea-276775bddd94'
  }
}

resource Policy16'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Prevent MMA Windows'
  properties: {
    displayName: 'Prevent MMA Windows'
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/d2185817-5b7e-473c-aadd-9de6ac11428'
  }
}

resource Policy17 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Prevent MMA Linux'
  properties: {
    displayName: 'Prevent MMA Linux'
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/d4b065e2-fbda-4461-a42c-b0346aeb12a0'
  }
}
