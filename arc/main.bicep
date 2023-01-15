//     MDC-Quickstart (Arc)
//     v-2.0
//     *See README file for usage information
//     *This bicep template will start MDC & Guest Config billing
//     *For best outcomes, locate all MDC resources in the same Azure Region as the Log Analytics Workspace

//Scope
targetScope = 'subscription'

//Parameters
param loganalyticsregion string
param mgmtresourcgroup string
param roledefinitionId string
param loganalyticsrid string
param vminsightsdcrname string

//Variables
var miresourcgroup = string(mgmtresourcgroup)

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
    mgmtresourcgroup:mgmtresourcgroup
    
  }
}

module mdcautomanage './automanage.bicep' = {
  name: 'MDCAutomanage'
  scope:resourceGroup(miresourcgroup)
  params:{
    loganalyticsregion: loganalyticsregion
  }
  dependsOn: [
    mdcroleassignment
  ]
}

module mdcmanagedidentity './managedid.bicep' = {
  name: 'MDCUserManagedIdentity'
  scope:resourceGroup(miresourcgroup)
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

module mdcdcr './dcr.bicep' = {
  name: 'MDCDataCollectionRule'
  scope:resourceGroup(miresourcgroup)
  params:{
    loganalyticsregion: loganalyticsregion
    loganalyticsrid: loganalyticsrid
  }
  dependsOn: [
    mdcroleassignment
  ]
}

module mdcazpolicy './policy.bicep' = {
  name: 'MDCAzurePolicy'
  scope:subscription()
  params:{
    loganalyticsregion: loganalyticsregion
    azmanagedidentity: mdcmanagedidentity.outputs.mirid
    mgmtresourcgroup: mgmtresourcgroup
    muasminame:mdcmanagedidentity.outputs.mirname
    loganalyticsrid:loganalyticsrid
    vminsightsdcrname: vminsightsdcrname
    mdcdcr01id: mdcdcr.outputs.mdcdcrid01

  }
  dependsOn: [
    mdcroleassignment
  ]
}

module mdccusazpolicy './custompolicy.bicep' = {
  name: 'MDCCUSAzurePolicy'
  scope:subscription()
  params:{
    loganalyticsregion:loganalyticsregion
    azmanagedidentity:mdcmanagedidentity.outputs.mirid
  }
  dependsOn: [
    mdcroleassignment
  ]
}


