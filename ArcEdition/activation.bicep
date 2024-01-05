//This bicep deploys the Azure Policy remediation tasks.

//Scope
targetScope = 'resourceGroup'

//Variables

//Parameters
param location string
param sentinelumiid string

//Resources

resource compliancescanscript 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  name: 'deployscript-compliance-mdc-azpolicy'
  location: location
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${sentinelumiid}' : {}
    }
  }
  properties: {
    azPowerShellVersion: '10.3'
    retentionInterval: 'P1D'
    scriptContent: '''
      $TenantRoot = (Get-AzContext).Tenant.Id
      $Subscriptions = Get-AzSubscription
      foreach ($sub in $Subscriptions) {
        Get-AzSubscription -SubscriptionName $sub.Name | Set-AzContext
        Start-AzPolicyComplianceScan -AsJob | Wait-Job
      }
    '''
  }
}

resource remediationscript 'Microsoft.Resources/deploymentScripts@2023-08-01' = {
  name: 'deployscript-remediation-mdc-azpolicy'
  location: location
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${sentinelumiid}' : {}
    }
  }
  properties: {
    azPowerShellVersion: '10.3'
    retentionInterval: 'P1D'
    scriptContent: '''
      $TenantRoot = (Get-AzContext).Tenant.Id
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy1' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/ConfigureUpdatesArc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy2' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/Configure_MDE_Win_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy3' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/Configure_MDE_Lin_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy4' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/Configure_SQL_Ext_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy5' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/DCR_Windows_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy6' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/FIM_DCR_Windows_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy7' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/DCR_Linux_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy8' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/FIM_DCR_Linux_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy9' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/AMA_Windows_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy10' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/AMA_Linux_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy11' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/VMI_DCR_Linux_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy12' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/VMI_DCR_Windows_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy13' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/ASA_Linux_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy14' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/ASA_Windows_Arc -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      '''
  }
  dependsOn: [
    compliancescanscript
  ]
}

//Outputs
