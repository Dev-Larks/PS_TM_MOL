function Get-CoreSystemInfo {
    [CmdletBinding()]
    param (
        [string[]] $ComputerName,

        [string] $ErrorLog
    )
    
    BEGIN {

    }
    
    PROCESS {
        foreach ($computer in $ComputerName) {

            $comp = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computer
            $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computer

            $props = @{'Model'=$comp.Model;
                       'ComputerName'=$comp.Name;
                       'Manufacturer'=$comp.Manufacturer;
                       'OSVersion'=$os.Version;
                       'LastBootTime'=$os.LastBootUpTime}

            $obj = New-Object -TypeName psobject -Property $props

            Write-Output $obj
        }
    }
    
    END {
        
    }
}

Get-CoreSystemInfo -ComputerName localhost, localhost -ErrorLog "C:\Temp\OfflineSystems.txt"