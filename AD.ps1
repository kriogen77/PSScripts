Add-WindowsFeature AD-Domain-Services -IncludeManagementTools

$domainName = Read-Host "Enter your domain name"
Install-ADDSForest -DomainName $domainName -InstallDNS