# Create a package that will audit and apply the configuration (Set)
New-GuestConfigurationPackage `
  -Name 'MDC_Quickstart_Active' `
  -Configuration './localhost.mof' `
  -Type AuditAndSet `
  -Force