$ou = "OU=Company LTD,DC=test,DC=local"
$wallpaperPath = "C:\Wallpapers\windows_wallpaper.jpg"

$users = Get-ADUser -Filter * -SearchBase $ou

foreach ($user in $users) {
    $registryPath = "HKCU:\Control Panel\Desktop"
    Set-ItemProperty -Path $registryPath -Name Wallpaper -Value $wallpaperPath
}

gpupdate /force
$c = Read-Host "Do you want to restart PC now?" (y/n)
if ($c -eq "y"){
Restart-Computer -ComputerName "WINSRV22" -Force
}