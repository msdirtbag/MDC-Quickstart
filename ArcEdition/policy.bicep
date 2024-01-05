//Scope
targetScope = 'managementGroup'

//Variables

//Parameters
param loganalyticsregion string
param azmanagedidentity string
param mgmtresourcegroup string
param loganalyticsrid string
param loganalyticsworkspaceid string
param muasminame string
param commondcrid string
param linuxdcrid string
param fimid string
param vmiid string

//Resources

//MDC Azure Policy

resource Policy1 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'ConfigureUpdatesArc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure periodic checking for missing system updates on azure Arc-enabled servers'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/bfea026e-043f-4ff4-9d1b-bf301ca7ff46'
  }
}

resource Policy2 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Configure_MDE_Win_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Deploy Microsoft Defender for Endpoint agent on Windows Azure Arc machines'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/37c043a6-6d64-656d-6465-b362dfeb354a'
  }
}

resource Policy3 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Configure_MDE_Lin_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Deploy Microsoft Defender for Endpoint agent on Linux hybrid machines'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/4eb909e7-6d64-656d-6465-2eeb297a1625'
  }
}

resource Policy4 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Configure_SQL_Ext_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    parameters: {
      workspaceRegion: {
        value: loganalyticsregion
      }
      userWorkspaceResourceId: {
        value: loganalyticsrid
      }
    }
    displayName: 'Configure Arc-enabled SQL Servers to automatically install Microsoft Defender for SQL and DCR with a user-defined LA workspace'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/63d03cbd-47fd-4ee1-8a1c-9ddf07303de0'
  }
}

resource Policy5 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'DCR_Windows_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Windows Arc machines to be associated with a Data Collection Rule or a Data Collection Endpoint'
    parameters: {
      dcrResourceId:{
        value: commondcrid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/c24c537f-2516-4c2f-aac5-2cd26baa3d26'
  }
}

resource Policy6 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'FIM_DCR_Windows_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Windows Arc-enabled machines to be associated with a Data Collection Rule for ChangeTracking and Inventory'
    parameters: {
      dcrResourceId:{
        value: fimid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/ef9fe2ce-a588-4edd-829c-6247069dcfdb'
  }
}

resource Policy7 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'DCR_Linux_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Linux Arc machines to be associated with a Data Collection Rule or a Data Collection Endpoint'
    parameters: {
      dcrResourceId:{
        value: linuxdcrid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/d5c37ce1-5f52-4523-b949-f19bf945b73a'
  }
}

resource Policy8 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'FIM_DCR_Linux_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Linux Arc-enabled machines to be associated with a Data Collection Rule for ChangeTracking and Inventory'
    parameters: {
      dcrResourceId:{
        value: fimid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/09a1f130-7697-42bc-8d84-8a9ea17e5192'
  }
}

resource Policy9 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'AMA_Windows_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Windows Arc-enabled machines to run Azure Monitor Agent'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/94f686d6-9a24-4e19-91f1-de937dc171a4'
  }
}

resource Policy10 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'AMA_Linux_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Linux Arc-enabled machines to run Azure Monitor Agent'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/845857af-0333-4c5d-bbbc-6076697da122'
  }
}

resource Policy11 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'VMI_DCR_Linux_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Linux Arc machines to be associated with a Data Collection Rule or a Data Collection Endpoint'
    parameters: {
      dcrResourceId:{
        value: vmiid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/d5c37ce1-5f52-4523-b949-f19bf945b73a'
  }
}

resource Policy12 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'VMI_DCR_Windows_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Windows Arc machines to be associated with a Data Collection Rule or a Data Collection Endpoint'
    parameters: {
      dcrResourceId:{
        value: vmiid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/ef9fe2ce-a588-4edd-829c-6247069dcfdb'
  }
}

resource Policy13 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'ASA_Linux_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure supported Linux Arc machines to automatically install the Azure Security agent'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/2f47ec78-4301-4655-b78e-b29377030cdc'
  }
}

resource Policy14 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'ASA_Windows_Arc'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure supported Windows Arc machines to automatically install the Azure Security agent'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/d01f3018-de9f-4d75-8dae-d12c1875da9f'
  }
}
