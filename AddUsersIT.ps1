﻿# Set the path to the CSV file
$csvFilePath = "C:\users.csv"

# Set the distinguished name of the IT Administrators group
$itAdminsGroupDN = "CN=IT Administrators,OU=IT,OU=Riga,OU=Company LTD,DC=test,DC=local"

# Set the distinguished name of the IT Support group
$itSupportGroupDN = "CN=IT Support,OU=IT,OU=Riga,OU=Company LTD,DC=test,DC=local"

# Import the CSV file and loop through each row
Import-Csv $csvFilePath | ForEach-Object {
    # Set the properties for the new user
    $firstName = $_.FirstName
    $lastName = $_.LastName
    $username = $_.Username
    $password = $_.Password
    $group = $_.Group

    # Determine which group the user should be added to
    if ($group -eq "IT Administrators") {
        $groupDN = $itAdminsGroupDN
    } elseif ($group -eq "IT Support") {
        $groupDN = $itSupportGroupDN
    } else {
        Write-Warning "Unknown group '$group'. User '$username' will not be added to a group."
        return
    }

    # Create the new user account in Active Directory
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
    New-ADUser -Name "$firstName $lastName" `
               -GivenName $firstName `
               -Surname $lastName `
               -SamAccountName $username `
               -AccountPassword $securePassword `
               -Enabled $true `
               -Path "OU=IT,OU=Riga,OU=Company LTD,DC=test,DC=local" `
               -ChangePasswordAtLogon $false

    # Add the new user to the appropriate group
    Add-ADGroupMember -Identity $groupDN -Members $username
}