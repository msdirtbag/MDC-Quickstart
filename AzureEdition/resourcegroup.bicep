//Scope
targetScope = 'subscription'
//Variables

//Parameters
param loganalyticsregion string
param mgmtresourcegroup string

//Resources

resource managmentresourcegroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: mgmtresourcegroup
  location: loganalyticsregion
}


