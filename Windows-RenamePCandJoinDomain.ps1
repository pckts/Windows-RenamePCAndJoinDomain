$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -eq $false)
{
    exit
}

$NewComputerName = $null
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$NewComputerName = [Microsoft.VisualBasic.Interaction]::InputBox("Enter new hostname:","Hostname")
if ($NewComputerName.Length -lt 1)
{
    exit
}
else
{
    Rename-Computer -NewName $NewComputerName
}

$AdminAccount = $null
$DomainName = $null
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$AdminAccount = [Microsoft.VisualBasic.Interaction]::InputBox("Enter admin username:","Username")
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$DomainName = [Microsoft.VisualBasic.Interaction]::InputBox("Enter the domain:","Domain")
if ($AdminAccount.Length -lt 1 -or $DomainName.Length -lt 1)
{
    exit
}
else
{
    Add-Computer -DomainCredential $AdminAccount -DomainName $DomainName
}

if ($NewComputerName.Length -lt 1 -and $NewComputerName.Length -lt 1)
{
    Restart-Computer -Timeout 60 -force
}
