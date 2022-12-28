//Scope
targetScope = 'subscription'
//Variables
var machinename = 'machineName'
//Parameters
param loganalyticsregion string
param azmanagedidentity string
param mgmtresourcgroup string
param loganalyticsrid string
param muasminame string
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
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/d01f3018-de9f-4d75-8dae-d12c1875da9f'
  }
}

resource Policy5 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
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
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/2f47ec78-4301-4655-b78e-b29377030cdc'
  }
}

resource Policy6 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
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

resource Policy7 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
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

resource Policy8 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
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

resource Policy9 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'Auditing on SQL server should be enabled'
  #disable-next-line no-loc-expr-outside-params
  location: deployment().location
  properties: {
    displayName: 'Auditing on SQL server should be enabled'
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/a6fb4358-5bf4-4ad7-ba82-2cd2f41ce5e9'
  }
}

resource Policy10 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
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

resource configuremdcautomanage 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Configure Automanage Windows Arc Servers'
  properties: {
    displayName: 'Configure Automanage Windows Arc Servers'
    description: 'Azure Automanage enrolls, configures, and monitors virtual machines with best practice as defined in the Microsoft Cloud Adoption Framework for Azure. Use this policy to apply Automanage with your own customized Configuration Profile to your selected scope.'
    policyType: 'Custom'
    mode: 'Indexed'
    metadata: {
      category: 'Automanage'
      version: '1.5.0'
    }
    parameters: {
      configurationProfile: {
        type: 'string'
        defaultValue: 'mdc-automanage-windows-arc'
        metadata: {
          displayName: 'Configuration profile'
          description: 'The management services provided are based on your own settings from your custom Configuration Profile.'
          strongType: 'Microsoft.Automanage/configurationProfiles'
        }
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.HybridCompute/machines'
          }
          {
            field: 'Microsoft.HybridCompute/machines/osName'
            equals: 'windows*'
          }
        ]
      }
      then: {
        effect: 'deployIfNotExists'
        details: {
          type: 'Microsoft.Automanage/configurationProfileAssignments'
          roleDefinitionIds: [
            '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
          ]
          existenceCondition: {
            field: 'Microsoft.Automanage/configurationProfileAssignments/configurationProfile'
            equals: 'mdc-automanage-windows-arc'
          }
          deployment: {
            properties: {
              mode: 'incremental'
              template: {
                '$schema': 'http://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
                contentVersion: '1.0.0.0'
                parameters: {
                  machineName: {
                    type: 'string'
                  }
                  configurationProfile: {
                    type: 'string'
                  }
                }
                resources: [
                  {
                    name: [concat (machinename, '/Microsoft.Automanage/', 'default')]
                    type: 'Microsoft.HybridCompute/machines/providers/configurationProfileAssignments'
                    apiVersion: '2022-05-04'
                    properties: {
                      configurationProfile: 'mdc-automanage-windows-arc'
                    }
                  }
                ]
              }
            }
          }
        }
      }
    }
  }
}
