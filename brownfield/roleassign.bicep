//Scope
targetScope = 'subscription'
//Variables

//Parameters
param principalId string 
param roleDefinitionId string

//Resources
resource roleAssignSub 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(principalId, roleDefinitionId, subscription().id)
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}
