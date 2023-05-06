Install-Module -Name PSWindowsUpdate
Get-WindowsUpdate

$condition = Read-Host "Enter '1' to install all updates or enter '2' to install specific update(s)"

if ($condition -eq '1')
{
    Install-WindowsUpdate -AcceptAll
}
elseif ($condition -eq '2')
{
    $kbArticleID = Read-Host "Which update should be installed? (Provide KB identifier)"
    Install-WindowsUpdate -KBArticleID $kbArticleID
}