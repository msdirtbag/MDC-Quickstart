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
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy1' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/ConfigureUpdates -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy2' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/Configure_MDE_Win -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy3' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/Configure_MDE_Lin -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy4' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/Configure_SQL_Ext -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy5' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/Windows_GuestConfig -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy6' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/AMA_Windows -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy7' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/AMA_Linux -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob | Wait-Job
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy8' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/DCR_Windows -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy9' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/DCR_Linux -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy10' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/FIM_DCR_Windows -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy11' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/FIM_DCR_Linux -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy12' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/Deploy_AzPolicyk8 -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy13' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/Deploy_D4Ck8 -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy14' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/ConfigureAKSLogs -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy15' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/Linux_GuestConfig -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy16' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/configure_automan_win -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy17' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/VMI_DCR_Windows -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy18' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/VMI_DCR_Linux -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy19' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/ASA_Linux -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      Start-AzPolicyRemediation -ManagementGroupName $TenantRoot -Name 'Policy20' -PolicyAssignmentId /providers/Microsoft.Management/managementGroups/$TenantRoot/providers/Microsoft.Authorization/policyAssignments/ASA_Windows -ResourceCount 10000 -ParallelDeploymentCount 30 -AsJob
      '''
  }
  dependsOn: [
    compliancescanscript
  ]
}

//Outputs
