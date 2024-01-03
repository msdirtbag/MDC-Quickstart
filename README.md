# MDC-Quickstart 3.0

This project is designed to assist IT teams to rapidly deploy the Defender for Cloud CNAPP.


👉 What does it do?

🔻 By design, this deployment leverages the Tenant Root Managment Group to deploy to all Subscriptions in the Azure tenant.

🔻 Provide the Subscription ID's in a Array that you wish to target. This can be done manually or programatically via Azure CLI/PowerShell.


## Included Content:

-Enables All Defender for Cloud Plans 

-Configures Change Tracking

-File Integrity Monitoring

-STIG Guest Assignments (Audit-only)

-Defender for SQL IaaS Agent

-Azure Monitor VM Insights

-Security Event Data Collection Rules for Windows & Linux

-Update Management Center (Audit-only)

-AKS Policy & Defender Extension + Azure Diagnostic Logs (minimal configuration)

-Automated Onboarding via Azure Policy Remediation Tasks


## Programing Notes:

-No warranties expressed or implied. If something breaks or you get a unexpected Azure bill, it's on you. 

-This project does not target Arc resource types but this will enable Defender CSPM and you will be billed for AWS/GCP resource types that are connected via AWS/GCP Connector. If the in-scope Subscriptions include Arc resources, MDC will still bill you for those resources. 

-This project should not deploy agents to AWS/GCP Virtual Machines/Containers.

-The ChangeTracking solution must be installed on the Log Analytics Workspace prior to deployment. 

-Defender for Endpoint needs Endpoint Security Policies for Attack Surface Reduction Rules, Windows Firewall, Antivirus, and EDR to achieve the best security outcomes. Leverage the security.microsoft.com portal to configure these policies. (https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/manage-security-policies?view=o365-worldwide#create-an-endpoint-security-policy)

## Deployment Guides:

Deployment process

1-Clone/Download the MDC-Quickstart repo.

2-Update the main.bicepparam file to include your information.

3-Choose your deployment method:

- VS Code: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-vscode
- Azure CLI: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-cli
- Azure PowerShell: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-powershell
- Azure Cloud Shell: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-cloud-shell
- GitHub Actions: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions
