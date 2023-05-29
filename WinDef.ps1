<#
    Enables Windows Defender
#>

Add-WindowsCapability -Online -Name "Windows-Defender"

Set-MpPreference -DisableArchiveScanning $false -DisableBehaviorMonitoring $false -DisableRealtimeMonitoring $false -DisableRemovableDriveScanning $false -SubmitSamplesConsent 2

Get-Service WinDefend