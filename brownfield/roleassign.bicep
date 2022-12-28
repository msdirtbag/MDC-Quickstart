//Scope
targetScope = 'subscription'
//Variables

//Parameters
param principalId string 
param roledefinitionId string

//Resources
resource roleAssignSub 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(principalId, roledefinitionId, subscription().id)
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roledefinitionId)
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}
