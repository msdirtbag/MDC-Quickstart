using './main.bicep'

//Parameters 

//Location for MDC operational resources
param mgmtresourcegroup = 'rg-mdc-arc'
//Name of the resource group where the MDC operational resources will be deployed. Example: 'rg-mdc-mgmt'
param mgmtsubscription = '468e4d0c-d665-47fe-808f-5449ecfa903c'
//Subscription ID where the MDC operational resources will be deployed. Example: '73a5562e-f3e4-435c-97e1-260a238df268'

//Central Log Analytics Workspace (Use your Sentinel LAW if using Microsoft Sentinel)
param loganalyticsregion = 'eastus2'
//Region where the Log Analytics Workspace is deployed. Example: 'eastus'
param loganalyticsrid = '/subscriptions/468e4d0c-d665-47fe-808f-5449ecfa903c/resourcegroups/rg-product-sentinel-prod/providers/microsoft.operationalinsights/workspaces/la-product-sentinelmdc-prod'
//Resource ID of the Log Analytics Workspace. Example: '/subscriptions/73a5564e-f3e4-415c-97e1-260a258df268/resourcegroups/rg-mdc-mgmt/providers/microsoft.operationalinsights/workspaces/la-mdc-mgmt'
param loganalyticsname = 'la-product-sentinelmdc-prod'
//Name of the Log Analytics Workspace. Example: 'la-mdc-mgmt'
param loganalyticsworkspaceid = '870088d5-2010-49b6-b6dc-653685ee04ea'
//Workspace ID of the Log Analytics Workspace. Example: '0b6544f8-74e0-47b4-b528-38e465c71352'

//Subscription ID's for Deployment
param subscriptionids = [
  '468e4d0c-d665-47fe-808f-5449ecfa903c'
]
