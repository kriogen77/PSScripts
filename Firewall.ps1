<#
    .DESCRIPTION
    Creates a firewall rule that it is allowed incoming connections to port number and protocol.

    .HOW TO USE
    Choose port number and protocol to allow connections and
#>


$RuleName = "My Custom Firewall Rule"


$PortNumber = 80


$Protocol = "TCP"


if (Get-NetFirewallRule -DisplayName $RuleName -ErrorAction SilentlyContinue) {
    Write-Host "Firewall Rule already exists."
}
else {

    New-NetFirewallRule -DisplayName $RuleName -Direction Inbound -LocalPort $PortNumber -Protocol $Protocol -Action Allow
    Write-Host "Firewall Rule created successfully."
}


Set-NetFirewallRule -DisplayGroup "Remote Desktop" -Enabled True


Set-NetFirewallRule -DisplayGroup "File and Printer Sharing" -Enabled True