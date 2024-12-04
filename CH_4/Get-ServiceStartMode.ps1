function Get-ServiceStartMode {
    param (
        [string] $computerName='localhost',
        [string] $StartMode='Auto',
        [string] $State='Running'
    )

    $filter = "StartMode='$StartMode' AND State='$State'"

    Get-CimInstance -ClassName Win32_Service -Filter $filter
}
Get-ServiceStartMode -computerName 5CG1409C7L
Get-ServiceStartMode -StartMode 'Auto' -State 'Stopped'
Get-ServiceStartMode -StartMode 'Disabled'