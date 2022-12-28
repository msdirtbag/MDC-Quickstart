//Scope
targetScope = 'subscription'
//Variables

//Parameters
param loganalyticsregion string

//Resources
//Deploy Resource Groups for Arc Servers
resource mgmtresourcgroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-arc-prod-mgmgt'
  location: loganalyticsregion
}


