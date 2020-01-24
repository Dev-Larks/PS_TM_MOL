function Get-SystemInfo {
    [CmdletBinding()]
    param (
        [string[]] $computerName,

        [string] $errorLog
    )
    
    BEGIN {
        
    }
    
    PROCESS {
        foreach ($computer in $computername) {
            $os = Get-Wmiobject -ClassName Win32_OperatingSystem -ComputerName $computer
            $comp = Get-WmiObject -ClassName Win32_ComputerSystem -ComputerName $computer
            $bios = Get-WmiObject -ClassName Win32_BIOS -ComputerName $computer

            $props = @{ 'ComputerName'=$computer;
                        'OSVersion'=$os.Version;
                        'SPVersion'=$os.ServicePackMajorVersion;
                        'BIOSSerial'=$bios.SerialNumber;
                        'Manufacturer'=$comp.Manufacturer;
                        'Model'=$comp.Model
                    }

            $obj = New-Object -TypeName psobject -Property $props

            Write-Output $obj
        }
    }
    
    END {
        
    }
}

Get-SystemInfo -computerName localhost, localhost -errorLog C:\retry.txt
#Get-SystemInfo Four x.txt