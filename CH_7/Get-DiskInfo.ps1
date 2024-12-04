function Get-DiskInfo {
    [CmdletBinding()]
    param (
        [string[]] $computerName,

        [string] $errorLog
    )
    
    BEGIN {
        Write-Output "The error log is $errorLog"
    }
    
    PROCESS {
        foreach ($computer in $computerName) {
           $disks = Get-WmiObject -Class Win32_Volume -ComputerName $computer -Filter "DriveType = 3"
            foreach ($disk in $disks){
                $size = "{0:N2}" -f ($disk.Capacity/1GB)
                $freespace = "{0:N2}" -f ($disk.Freespace/1GB)

                $props = @{
                    'ComputerName'= $disk.SystemName;
                    'Drive'= $disk.Name;
                    'Capacity' = "$size GB";
                    'FreeSpace' = "$freespace GB"
                }

                $obj = New-Object -TypeName psobject -Property $props
                Write-Output $obj

            }

            Remove-Variable -Name $disks
        }
        
    }
    
    END {
        
    }
}

Get-DiskInfo -computerName localhost, notonline -errorLog C:\DiskErrors.txt
Get-DiskInfo one,two errors.txt