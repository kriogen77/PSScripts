$csvFilePath = "C:\users_b.csv"

$digitalMarketingGroupDN = "CN=Digital Marketing,OU=Marketing,OU=London,OU=Company LTD,DC=test,DC=local"

$offlineMarketingGroupDN = "CN=Offline Marketing,OU=Marketing,OU=London,OU=Company LTD,DC=test,DC=local"

Import-Csv $csvFilePath | ForEach-Object {
    $firstName = $_.FirstName
    $lastName = $_.LastName
    $username = $_.Username
    $password = $_.Password
    $group = $_.Group

    if ($group -eq "Digital Marketing") {
        $groupDN = $digitalMarketingGroupDN
    } elseif ($group -eq "Offline Marketing") {
        $groupDN = $offlineMarketingGroupDN
    } else {
        Write-Warning "Unknown group '$group'. User '$username' will not be added to a group."
        return
    }

    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
    New-ADUser -Name "$firstName $lastName" `
               -GivenName $firstName `
               -Surname $lastName `
               -SamAccountName $username `
               -AccountPassword $securePassword `
               -Enabled $true `
               -Path "OU=Marketing,OU=London,OU=Company LTD,DC=test,DC=local" `
               -ChangePasswordAtLogon $false

    Add-ADGroupMember -Identity $groupDN -Members $username
}