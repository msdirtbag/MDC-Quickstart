//Scope
targetScope = 'subscription'
//Variables

//Parameters
param loganalyticsregion string
param mgmtresourcgroup string

//Resources
//Deploy Resource Groups for Arc Servers
resource managmentresourcegroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: mgmtresourcgroup
  location: loganalyticsregion
}


