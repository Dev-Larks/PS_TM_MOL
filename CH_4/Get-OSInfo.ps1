function Get-OSInfo {
Param(
    [string] $computerName = 'localhost'
)
    Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computerName
}
Get-OSInfo -computerName 5CG1409C7L