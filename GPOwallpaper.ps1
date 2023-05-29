<#
    .DESCRIPTION
    Sets the wallpaper to all company's users

    .HOW TO USE
    Chhose image or photo for background for all users and reboot your workstation 
#>

$ou = "OU=Company LTD,DC=test,DC=local"
$wallpaperPath = "\\WINSRV\Wallpapers\windows_wallpaper.jpg"

$users = Get-ADUser -Filter * -SearchBase $ou

foreach ($user in $users) {
    $registryPath = "HKCU:\Control Panel\Desktop"
    Set-ItemProperty -Path $registryPath -Name Wallpaper -Value $wallpaperPath
}

gpupdate /force
$c = Read-Host "Do you want to restart PC now? (y/n)"
if ($c -eq "y"){
Restart-Computer -ComputerName "WINSRV" -Force
}