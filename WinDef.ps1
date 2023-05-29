<#
    .DESCRIPTION
    Enables Windows Defender

    .HOW TO USE
    Configure preferences for Windows Defender scans and updates
#>

Add-WindowsCapability -Online -Name "Windows-Defender"

Set-MpPreference -DisableArchiveScanning $false -DisableBehaviorMonitoring $false -DisableRealtimeMonitoring $false -DisableRemovableDriveScanning $false -SubmitSamplesConsent 2

Get-Service WinDefend