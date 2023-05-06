# Set the path to the CSV file
$csvFilePath = "C:\users_a.csv"

# Set the distinguished name of the Inside Sales group
$insideSalesGroupDN = "CN=Inside Sales,OU=Sales,OU=London,OU=Company LTD,DC=test,DC=local"

# Set the distinguished name of the Outside Sales group
$outsideSalesGroupDN = "CN=Outside Sales,OU=Sales,OU=London,OU=Company LTD,DC=test,DC=local"

# Import the CSV file and loop through each row
Import-Csv $csvFilePath | ForEach-Object {
    # Set the properties for the new user
    $firstName = $_.FirstName
    $lastName = $_.LastName
    $username = $_.Username
    $password = $_.Password
    $group = $_.Group

    # Determine which group the user should be added to
    if ($group -eq "Inside Sales") {
        $groupDN = $insideSalesGroupDN
    } elseif ($group -eq "Outside Sales") {
        $groupDN = $outsideSalesGroupDN
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
               -Path "OU=Sales,OU=London,OU=Company LTD,DC=test,DC=local" `
               -ChangePasswordAtLogon $false

    # Add the new user to the appropriate group
    Add-ADGroupMember -Identity $groupDN -Members $username
}