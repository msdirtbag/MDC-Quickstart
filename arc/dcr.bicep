//Scope
targetScope = 'resourceGroup'
//Variables

//Parameters
param loganalyticsregion string
param loganalyticsrid string

//Resources
resource mdcdcr01 'Microsoft.Insights/dataCollectionRules@2021-09-01-preview' = {
  name: 'MDC-DCR-FIM'
  location: loganalyticsregion
  properties: {
    description: 'Data collection rule for Defender for Clouds File Integrity Monitoring solution.'
    dataSources: {
      extensions: [
        {
          streams: [
            'Microsoft-ConfigurationChange'
          ]
          extensionName: 'ChangeTracking-Linux'
          extensionSettings: {
          }
          name: 'CTDataSource-Linux'
        }
        {
          streams: [
            'Microsoft-ConfigurationChange'
          ]
          extensionName: 'ChangeTracking-Windows'
          extensionSettings: {
          }
          name: 'CTDataSource-Windows'
        }
      ]
    }
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: loganalyticsrid
          name: 'centrallaworkspace'
        }
      ]
    }
    dataFlows: [
      {
        streams: [
          'Microsoft-ConfigurationChange'
        ]
        destinations: [
          'centrallaworkspace'
        ]
      }
    ]
  }
}

output mdcdcrid01 string = mdcdcr01.id
