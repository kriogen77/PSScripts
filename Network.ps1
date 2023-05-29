<#
    .DESCRIPTION
    Disables DHCP and changes the IP address to static.

    .HOW TO USE
    Enter your or your organization's network data and prepare server for job in the network
#>


Set-NetIPInterface -InterfaceAlias "Ethernet" -Dhcp Disabled

Write-Host "Please below assign your network parameters"
$ipAdrress = Read-Host "Enter IP address"
$interfaceIndex = Read-Host "Enter interface index"
$prefixLength = Read-Host "Enter prefix length"
$defaultGateway = Read-Host "Enter default gateway"

New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress $ipAdrress -PrefixLength $prefixLength -DefaultGateway $defaultGateway
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses ("8.8.8.8","8.8.4.4")

$computerName = Read-Host "Please provide new computer name"
Rename-Computer -NewName $computerName
