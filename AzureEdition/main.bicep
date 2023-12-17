//     MDC-Quickstart (AzureEdition)
//     v-3.0.0
//     *See README file for usage information
//     *This bicep template will start Defender for Cloud billing
//     *For best outcomes, locate all MDC resources in the same Azure Region as the Log Analytics Workspace

//Scope
targetScope = 'managementGroup'

//Parameters
param loganalyticsregion string
param loganalyticsrid string
param loganalyticsname string
param loganalyticsworkspaceid string
param mgmtsubscription string
param mgmtresourcegroup string
param subscriptionids array 

//Variables
var managementgroup = tenant().tenantId

//Modules

//This module deploys the MDC Settings to each subscription in the tenant.
module mdcsettings './mdc.bicep' = [for (subscriptionid,i) in subscriptionids: {
  name: 'MDCSettings_${i}'
  scope: subscription(subscriptionid)
  params: {
    loganalyticsrid: loganalyticsrid
  }
}]

//This module deploys the MDC Resource Group.
module mdcresourcegroup './resourcegroup.bicep' = {
  name: 'MDCResourceGroups'
  scope:subscription(mgmtsubscription)
  params:{
    loganalyticsregion: loganalyticsregion
    mgmtresourcegroup: mgmtresourcegroup
    
  }
}

//This module deploys the MDC Managed Identity.
module mdcmanagedidentity './managedid.bicep' = {
  name: 'MDCUserManagedIdentity'
  scope: resourceGroup('${mgmtsubscription}', '${mgmtresourcegroup}')
  params:{
    loganalyticsregion:loganalyticsregion
  }
  dependsOn: [
    mdcresourcegroup
  ]
}

//This module deploys the MDC Role Assignment.
module mdcroleassignment './roleassign.bicep' = {
  name: 'MDCRoleAssignment'
  scope: managementGroup(managementgroup)
  params:{
    principalId:mdcmanagedidentity.outputs.miresourcepid
  }
}

//This module deploys the MDC Data Collection Rules.
module mdcdcr './dcr.bicep' = {
  name: 'MDCDataCollectionRule'
  scope: resourceGroup('${mgmtsubscription}', '${mgmtresourcegroup}')
  params:{
    loganalyticsregion: loganalyticsregion
    loganalyticsrid: loganalyticsrid
    loganalyticsname: loganalyticsname
    mdcumiid: mdcmanagedidentity.outputs.mirid
  }
  dependsOn: [
    mdcroleassignment
  ]
}

//This module deploys the MDC Azure Policies.
module mdcazpolicy './policy.bicep' = {
  name: 'MDCAzurePolicy'
  scope: managementGroup(managementgroup)
  params:{
    loganalyticsworkspaceid: loganalyticsworkspaceid
    loganalyticsregion: loganalyticsregion
    azmanagedidentity: mdcmanagedidentity.outputs.mirid
    mgmtresourcegroup: mgmtresourcegroup
    muasminame: mdcmanagedidentity.outputs.mirname
    loganalyticsrid: loganalyticsrid
    linuxdcrid: mdcdcr.outputs.mdcdcrid03
    commondcrid: mdcdcr.outputs.mdcdcrid02
    fimid: mdcdcr.outputs.mdcdcrid01
    vmiid: mdcdcr.outputs.mdcdcrid04
  }
  dependsOn: [
    mdcroleassignment
  ]
}

//This module deploys the Activation script.
module mdcdeploymentscript './activation.bicep' = {
  name: 'MDCDeploymentScript'
  scope: resourceGroup('${mgmtsubscription}', '${mgmtresourcegroup}')
  params:{
    location: loganalyticsregion
    sentinelumiid: mdcmanagedidentity.outputs.mirid
  }
  dependsOn: [
    mdcmanagedidentity
    mdcdcr
    mdcazpolicy
  ]
}


