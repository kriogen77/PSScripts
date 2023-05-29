<#
    .DESCRIPTION
    Creates shared folders for different departments

    .HOW TO USE
    Access rights can be configured with different FileSystemAccessRule values.
#>

Install-WindowsFeature -Name File-Services

New-Item -ItemType Directory -Path \\WINSRV\Shares\IT
New-Item -ItemType Directory -Path \\WINSRV\Shares\Sales
New-Item -ItemType Directory -Path \\WINSRV\Shares\Marketing

New-SmbShare -Name "IT Shares" -Path C:\Shares\IT -FullAccess "IT Administrators" -ReadAccess "IT Support"
New-SmbShare -Name "Sales Shares" -Path C:\Shares\Sales -FullAccess "Inside Sales" -NoAccess "Outside Sales"
New-SmbShare -Name "Marketing Shares" -Path C:\Shares\Marketing -FullAccess "Digital Marketing" -ChangeAccess "Offline Marketing"

$ITSharesAcl = Get-Acl "\\WINSRV\Shares\IT"
$ITSharesAr = New-Object System.Security.AccessControl.FileSystemAccessRule("IT Administrators","FullControl","ContainerInherit,ObjectInherit","None","Allow")
$ITSharesAcl.SetAccessRule($ITSharesAr)

$ITSReadAr = New-Object System.Security.AccessControl.FileSystemAccessRule("IT Support","ReadAndExecute","Allow")
$ITSharesAcl.SetAccessRule($ITSReadAr)

Set-Acl "C:\Shares\IT" $ITSharesAcl

$SalesSharesAcl = Get-Acl "\\WINSRV\Shares\Sales"
$InsideSalesAr = New-Object System.Security.AccessControl.FileSystemAccessRule("Inside Sales","FullControl","ContainerInherit,ObjectInherit","None","Allow")
$SalesSharesAcl.SetAccessRule($InsideSalesAr)

$OutsideSalesAr = New-Object System.Security.AccessControl.FileSystemAccessRule("Outside Sales","ReadAndExecute","ContainerInherit,ObjectInherit","None","Deny")
$SalesSharesAcl.SetAccessRule($OutsideSalesAr)

Set-Acl "C:\Shares\Sales" $SalesSharesAcl

$MarketingSharesAcl = Get-Acl "\\WINSRV\Shares\Marketing"
$DigitalMarketingAr = New-Object System.Security.AccessControl.FileSystemAccessRule("Digital Marketing","FullControl","ContainerInherit,ObjectInherit","None","Allow")
$MarketingSharesAcl.SetAccessRule($DigitalMarketingAr)

$OfflineMarketingAr = New-Object System.Security.AccessControl.FileSystemAccessRule("Offline Marketing","Modify","ContainerInherit,ObjectInherit","None","Allow")
$MarketingSharesAcl.SetAccessRule($OfflineMarketingAr)

Set-Acl "C:\Shares\Marketing" $MarketingSharesAcl

$SharesAcl = Get-Acl "\\WINSRV\Shares"
$ITAdminAr = New-Object System.Security.AccessControl.FileSystemAccessRule("IT Administrators","FullControl","Allow")
$SharesAcl.SetAccessRule($ITAdminAr)

Set-Acl "C:\Shares" $SharesAcl