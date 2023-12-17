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
resource Policy1'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Prevent_MMA_Win'
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

resource Policy2 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Prevent_MMA_Lin'
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

resource Policy3 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'ConfigureUpdates'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure periodic checking for missing system updates on azure virtual machines'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/59efceea-0c96-497e-a4a1-4eb2290dac15'
  }
}

resource Policy4 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Configure_MDE_Win'
  location: loganalyticsregion
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

resource Policy5 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Configure_MDE_Lin'
  location: loganalyticsregion
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

resource Policy6 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Configure_SQL_Ext'
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

    }
    displayName: 'Configure SQL Virtual Machines to automatically install Microsoft Defender for SQL'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/ddca0ddc-4e9d-4bbb-92a1-f7c4dd7ef7ce'
  }
}

resource Policy7 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Audit_STIG_Win'
  location: loganalyticsregion
  properties: {
    displayName: 'Audit STIG Requirements for Windows'
    parameters:{
      IncludeArcMachines: {
        value:'false'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/50c52fc9-cb21-4d99-9031-d6a0c613361c'
  }
}

resource Policy8 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Audit_STIG_Lin'
  location: loganalyticsregion
  properties: {
    displayName: 'Audit STIG Requirements for Linux'
    parameters:{
      IncludeArcMachines: {
        value:'false'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/50c52fc9-cb21-4d99-9031-d6a0c613361c'
  }
}

resource Policy9 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Adaptive_App'
  location: loganalyticsregion
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

resource Policy10 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Windows_GuestConfig'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Deploy the Windows Guest Configuration extension to enable Guest Configuration assignments on Windows VMs'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/385f5831-96d4-41db-9a3c-cd3af78aaae6'
  }
}

resource Policy11 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'DCR_Windows'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Windows Virtual Machines to be associated with a Data Collection Rule or a Data Collection Endpoint'
    parameters: {
      dcrResourceId:{
        value: commondcrid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/244efd75-0d92-453c-b9a3-7d73ca36ed52'
  }
}

resource Policy12 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'FIM_DCR_Windows'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Windows Virtual Machines to be associated with a Data Collection Rule or a Data Collection Endpoint'
    parameters: {
      dcrResourceId:{
        value: fimid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/244efd75-0d92-453c-b9a3-7d73ca36ed52'
  }
}

resource Policy13 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'DCR_Linux'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Linux Virtual Machines to be associated with a Data Collection Rule or a Data Collection Endpoint'
    parameters: {
      dcrResourceId:{
        value: linuxdcrid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/58e891b9-ce13-4ac3-86e4-ac3e1f20cb07'
  }
}

resource Policy14 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'FIM_DCR_Linux'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Linux Virtual Machines to be associated with a Data Collection Rule or a Data Collection Endpoint'
    parameters: {
      dcrResourceId:{
        value: linuxdcrid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/58e891b9-ce13-4ac3-86e4-ac3e1f20cb07'
  }
}

resource Policy15 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'AMA_Windows'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Windows virtual machines to run Azure Monitor Agent with user-assigned managed identity-based authentication'
    parameters: {
      bringYourOwnUserAssignedManagedIdentity:{
        value: true
      }
      userAssignedManagedIdentityName:{
        value: muasminame
      }
      userAssignedManagedIdentityResourceGroup:{
        value: mgmtresourcegroup
      }
      scopeToSupportedImages:{
        value: true
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/637125fd-7c39-4b94-bb0a-d331faf333a9'
  }
}

resource Policy16 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'AMA_Linux'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Linux virtual machines to run Azure Monitor Agent with user-assigned managed identity-based authentication'
    parameters: {
      bringYourOwnUserAssignedManagedIdentity:{
        value: true
      }
      userAssignedManagedIdentityName:{
        value: muasminame
      }
      userAssignedManagedIdentityResourceGroup:{
        value: mgmtresourcegroup
      }
      scopeToSupportedImages:{
        value: true
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/ae8a10e6-19d6-44a3-a02d-a2bdfc707742'
  }
}

resource Policy17 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Deploy_AzPolicyk8'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Deploy Azure Policy Add-on to Azure Kubernetes Service clusters'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/a8eff44f-8c92-45c3-a3fb-9880802d67a7'
  }
}

resource Policy18 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Deploy_D4Ck8'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Azure Kubernetes Service clusters to enable Defender profile'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/64def556-fbad-4622-930e-72d1d5589bf5'
  }
}

resource Policy19 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'ConfigureAKSLogs'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure diagnostic settings for Azure Kubernetes Service to Log Analytics workspace'
    parameters: {
      diagnosticsSettingNameToUse: {
        value: 'AKSLogstoMDC'
      }
      logAnalytics: {
        value: loganalyticsrid
      }
      'kube-audit-admin': {
        value: 'True'
      }
      guard: {
        value: 'True'
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/6c66c325-74c8-42fd-a286-a74b0e2939d8'
  }
}

resource Policy20 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'Linux_GuestConfig'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Deploy the Linux Guest Configuration extension to enable Guest Configuration assignments on Linux VMs'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/331e8ea8-378a-410f-a2e5-ae22f38bb0da'
  }
}

resource Policy21 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'VMI_DCR_Linux'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Linux Virtual Machines to be associated with a Data Collection Rule or a Data Collection Endpoint'
    parameters: {
      dcrResourceId:{
        value: vmiid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/58e891b9-ce13-4ac3-86e4-ac3e1f20cb07'
  }
}

resource Policy22 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'VMI_DCR_Windows'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure Windows Virtual Machines to be associated with a Data Collection Rule or a Data Collection Endpoint'
    parameters: {
      dcrResourceId:{
        value: vmiid
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/244efd75-0d92-453c-b9a3-7d73ca36ed52'
  }
}

resource Policy23 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'ASA_Linux'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure supported Linux virtual machines to automatically install the Azure Security agent'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/5f8eb305-9c9f-4abe-9bb0-df220d9faba2'
  }
}

resource Policy24 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'ASA_Windows'
  location: loganalyticsregion
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${azmanagedidentity}': {}
    }
  }
  properties: {
    displayName: 'Configure supported Windows machines to automatically install the Azure Security agent'
    parameters: {
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/1537496a-b1e8-482b-a06a-1cc2415cdc7b'
  }
}
