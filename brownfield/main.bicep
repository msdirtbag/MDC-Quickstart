//     MDC-Quickstart (Brownfield)
//     v-1.0.0.0
//     *See README file for usage information
//     *This bicep template will start MDC billing
//     *For best outcomes, locate all MDC resources in the same Azure Region as the Log Analytics Workspace

//Scope
targetScope = 'subscription'

//Parameters
param loganalyticsregion string
param mgmtresourcegroup string
param roledefinitionId string
param loganalyticsrid string

//Variables
var miresourcegroup = string(mgmtresourcegroup)


//Modules
module mdcsettings './mdc.bicep' = {
  name: 'MDCSettings'
  scope:subscription()
  params:{
  }
}

module mdcresourcegroups './resourcegroup.bicep' = {
  name: 'MDCResourceGroups'
  scope:subscription()
  params:{
    loganalyticsregion:loganalyticsregion
  }
}

module mdcmanagedidentity './managedid.bicep' = {
  name: 'MDCUserManagedIdentity'
  scope:resourceGroup(miresourcegroup)
  params:{
    loganalyticsregion:loganalyticsregion
  }
  dependsOn: [
    mdcresourcegroups
  ]
}

module mdcroleassignment './roleassign.bicep' = {
  name: 'MDCRoleAssignment'
  scope:subscription()
  params:{
    principalId:mdcmanagedidentity.outputs.miresourcepid
    roledefinitionId:roledefinitionId
  }
  dependsOn: [
    mdcmanagedidentity
  ]
}

module mdcazpolicy './policy.bicep' = {
  name: 'MDCAzurePolicy'
  scope:subscription()
  params:{
    loganalyticsregion: loganalyticsregion
    azmanagedidentity: mdcmanagedidentity.outputs.mirid
    mgmtresourcegroup: mgmtresourcegroup
    loganalyticsrid:loganalyticsrid

  }
  dependsOn: [
    mdcroleassignment
  ]
}


