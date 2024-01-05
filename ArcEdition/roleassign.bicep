//Scope
targetScope = 'managementGroup'
//Variables
var contributorrole = '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
var monitoringrole = '/providers/Microsoft.Authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa'

//Parameters
param principalId string 

//Resources
resource contributorroleassign 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(principalId, contributorrole, managementGroup().id)
  properties: {
    roleDefinitionId: contributorrole
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}

resource monitoringroleassign 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(principalId, monitoringrole, managementGroup().id)
  properties: {
    roleDefinitionId: monitoringrole
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}
