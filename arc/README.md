# MDC-Quickstart (Arc)

## Usage
### STEP 1
1. Execute (PowerShell) Azure Cloud Shell

a. Set Client Environment Parameters

```
set-variable -name SUBSCRIPTION_GUID "XXXXXXX-XXXX-4aa7-XXXX-XXXXXXXXXXXX" -option constant
set-variable -name BICEP_FILE "main.bicep" -option constant
set-variable -name PARAMETER_FILE "main.parameters.json" -option constant

az account set --subscription ${SUBSCRIPTION_GUID} --verbose

```
### STEP 2
1. (PowerShell) Azure Cloud Shell

a. Deploy Policy Set

```
az deployment sub create --name ${SUBSCRIPTION_GUID} --template-file ${BICEP_FILE} --parameters ${PARAMETER_FILE} --location EastUS

```
