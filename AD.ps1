<#
    .DESCRIPTION
    Installs Active Directory feature.

    .HOW TO USE
    Chhose your domain name and set up first domain in the forest.
#>

Add-WindowsFeature AD-Domain-Services -IncludeManagementTools

$domainName = Read-Host "Enter your domain name"
Install-ADDSForest -DomainName $domainName -InstallDNS