using './main.bicep'

//Parameters 

//Location for MDC operational resources
param mgmtresourcegroup = ''
//Name of the resource group where the MDC operational resources will be deployed. Example: 'rg-mdc-mgmt'
param mgmtsubscription = ''
//Subscription ID where the MDC operational resources will be deployed. Example: '73a5562e-f3e4-435c-97e1-260a238df268'

//Central Log Analytics Workspace (Use your Sentinel LAW if using Microsoft Sentinel)
param loganalyticsregion = ''
//Region where the Log Analytics Workspace is deployed. Example: 'eastus'
param loganalyticsrid = ''
//Resource ID of the Log Analytics Workspace. Example: '/subscriptions/73a5564e-f3e4-415c-97e1-260a258df268/resourcegroups/rg-mdc-mgmt/providers/microsoft.operationalinsights/workspaces/la-mdc-mgmt'
param loganalyticsname = ''
//Name of the Log Analytics Workspace. Example: 'la-mdc-mgmt'
param loganalyticsworkspaceid = ''
//Workspace ID of the Log Analytics Workspace. Example: '0b6544f8-74e0-47b4-b528-38e465c71352'

//Subscription ID's for Deployment
param subscriptionids = [
  ''
  ''
]
