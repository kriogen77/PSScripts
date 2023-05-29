<#
    Install DNS Windows feature, configures DNS address, creates DNS zone and replication scope "Forest"
#>

Install-WindowsFeature -Name DNS -IncludeManagementTools

$dnsServerIPAddress = "8.8.8.8"
Set-DnsClientServerAddress -InterfaceIndex 5 -ServerAddresses $dnsServerIPAddress

Add-DnsServerPrimaryZone -Name "test.local" -ReplicationScope "Forest"

Add-DnsServerResourceRecordA -Name "bachelorserver" -ZoneName "test.local" -IPv4Address "192.168.87.132"