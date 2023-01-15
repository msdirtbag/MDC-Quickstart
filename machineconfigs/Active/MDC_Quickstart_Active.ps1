configuration MDC_Quickstart_Active
{
    $ASRRULES = @("D4F940AB-401B-4EFC-AADC-AD5F3C50688A","5BEB7EFE-FD9A-4556-801D-275E5FFC04CC", "92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B", "3B576869-A4EC-4529-8536-B80A7769E899", "75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84", "D3E037E1-3EB8-44C8-A917-57927947596D", "BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550", "01443614-cd74-433a-b99e-2ecdc07bfc25", "c1db55ab-c21a-4637-bb3f-a12568109d35", "9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2", "d1e49aac-8f56-4280-b9ba-993a6d77406c", "b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4", "26190899-1602-49e8-8b27-eb1d0a1ce869", "7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c", "e6db77e5-3df2-4cf1-b95a-636979351e5b", "56a863a9-875e-4185-98a7-b882c64b5ce5")
    $ASRACTIONS = @("Enabled","Enabled", "Enabled", "Enabled", "Enabled", "Enabled", "Enabled", "Enabled", "Enabled", "Enabled", "AuditMode", "Enabled", "Enabled", "Enabled", "Enabled", "Enabled")
    Install-Module -Name WindowsDefender
    Import-Module -Name WindowsDefender
    Import-Module -Name ConfigDefender
    Import-DscResource -ModuleName 'WindowsDefender'
    node localhost
    {
        WindowsDefender Active
        {
        IsSingleInstance = 'yes'
        RealTimeScanDirection = 'Both'
        CheckForSignaturesBeforeRunningScan = $true
        CloudBlockLevel = 'HighPlus'
        MAPSReporting = 'Advanced'
        DisableBehaviorMonitoring = $false
        DisableIntrusionPreventionSystem = $false
        DisableIOAVProtection = $false
        DisableRealtimeMonitoring = $false
        DisableScriptScanning = $false
        DisableArchiveScanning = $false
        DisableScanningNetworkFiles = $true
        DisableBlockAtFirstSeen = $false
        SubmitSamplesConsent = 'Always'
        EnableNetworkProtection = 'Enabled'
        AttackSurfaceReductionRules_Ids = $ASRRULES
        AttackSurfaceReductionRules_Actions = $ASRACTIONS
        }   
    }
}

MDC_Quickstart_Active -OutputPath '.\'

