Install-WindowsFeature -Name File-Services

New-Item -ItemType Directory -Path C:\Shares\IT
New-Item -ItemType Directory -Path C:\Shares\Sales
New-Item -ItemType Directory -Path C:\Shares\Marketing

New-SmbShare -Name "IT Shares" -Path C:\Shares\IT -FullAccess "IT Administrators" -ReadAccess "IT Support"
New-SmbShare -Name "Sales Shares" -Path C:\Shares\Sales -FullAccess "Inside Sales" -NoAccess "Outside Sales"
New-SmbShare -Name "Marketing Shares" -Path C:\Shares\Marketing -FullAccess "Digital Marketing" -ChangeAccess "Offline Marketing"

$ITSharesAcl = Get-Acl "C:\Shares\IT"
$ITSharesAr = New-Object System.Security.AccessControl.FileSystemAccessRule("IT Administrators","FullControl","Allow")
$ITSharesAcl.SetAccessRule($ITSharesAr)

$ITSReadAr = New-Object System.Security.AccessControl.FileSystemAccessRule("IT Support","ReadAndExecute","Allow")
$ITSharesAcl.SetAccessRule($ITSReadAr)

Set-Acl "C:\Shares\IT" $ITSharesAcl

$SalesSharesAcl = Get-Acl "C:\Shares\Sales"
$InsideSalesAr = New-Object System.Security.AccessControl.FileSystemAccessRule("Inside Sales","FullControl","Allow")
$SalesSharesAcl.SetAccessRule($InsideSalesAr)

$OutsideSalesAr = New-Object System.Security.AccessControl.FileSystemAccessRule("Outside Sales","ReadAndExecute","Deny")
$SalesSharesAcl.SetAccessRule($OutsideSalesAr)

Set-Acl "C:\Shares\Sales" $SalesSharesAcl

$MarketingSharesAcl = Get-Acl "C:\Shares\Marketing"
$DigitalMarketingAr = New-Object System.Security.AccessControl.FileSystemAccessRule("Digital Marketing","FullControl","Allow")
$MarketingSharesAcl.SetAccessRule($DigitalMarketingAr)

$OfflineMarketingAr = New-Object System.Security.AccessControl.FileSystemAccessRule("Offline Marketing","Modify","Allow")
$MarketingSharesAcl.SetAccessRule($OfflineMarketingAr)

Set-Acl "C:\Shares\Marketing" $MarketingSharesAcl

$SharesAcl = Get-Acl "C:\Shares"
$ITAdminAr = New-Object System.Security.AccessControl.FileSystemAccessRule("IT Administrators","FullControl","Allow")
$SharesAcl.SetAccessRule($ITAdminAr)

Set-Acl "C:\Shares" $SharesAcl