function Get-ComputerInfo {
    [CmdletBinding()]
    param (
        [string[]] $computerName,

        [string] $errorLog
    )
    
    begin {
        Write-Output "The error log is $errorLog"
    }
    
    process {
        foreach ($computer in $computerName) {
        Write-Output "The computer name is $computer"
        $comp = Get-WmiObject -ClassName Win32_ComputerSystem -ComputerName $computer
        $bios = Get-WmiObject -ClassName Win32_BIOS -ComputerName $computer
        $os = Get-WmiObject -ClassName Win32_OperatingSystem -ComputerName $computer

        switch ($comp.AdminPasswordStatus) {
            1 { $adminpw = 'Disabled' }
            2 { $adminpw = 'Enabled' }
            3 { $adminpw = 'NA' }
            default { $adminpw = 'Unknown' }
        }

        $props = @{'ComputerName'=$computer;
                'WorkGroup'=$comp.WorkGroup;
                'AdminPasswordStatus'=$adminpw;
                'Model'=$comp.Model;
                'Manufacturer'=$comp.Manufacturer;
                'SerialNumber'=$bios.SerialNumber;
                'OSVersion'=$os.Version;
                'ServicePack'=$os.ServicePackMajorVersion
                }

        $obj = New-Object -TypeName psobject -Property $props
        Write-Output $obj
        }
    }
    
    end {
        
    }
}

Get-ComputerInfo -computerName localhost -errorLog C:\OfflineComputers.txt