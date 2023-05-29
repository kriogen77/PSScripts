<#
    Create user's structure in Active Directory.
#>

$numOUs = Read-Host "How many OUs do you want to create?"

for ($i = 1; $i -le $numOUs; $i++) {
    $name = Read-Host "Enter the name for OU #$i"
    $parentPath = Read-Host "Enter the parent path for OU #$i (e.g. 'OU=ParentOU,DC=test,DC=local')"
    New-ADOrganizationalUnit -Name $name -Path $parentPath
}

$numGroups = Read-Host "How many groups do you want to create?"

for ($i = 1; $i -le $numGroups; $i++) {
    $name = Read-Host "Enter the name for group #$i"
    $scope = Read-Host "Enter the scope for group #$i (Universal, Global, or DomainLocal)"
    $category = Read-Host "Enter the category for group #$i (Security or Distribution)"
    $parentOU = Read-Host "Enter the parent OU for group #$i (e.g. 'OU=ParentOU,DC=test,DC=local')"
    New-ADGroup -Name $name -GroupScope $scope -GroupCategory $category -Path $parentOU
}