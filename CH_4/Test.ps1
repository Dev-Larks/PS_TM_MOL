Function Get-DiskInfo {

    Param (
        [string]$computername = 'localhost',
        [int]$MinimumFreePercent = 10
    )

    $disks = Get-CimInstance -Class Win32_Logicaldisk -Filter "Drivetype=3"

    foreach ($disk in $disks) {
        $perFree = ($disk.FreeSpace / $disk.Size) * 100;
    
        if ($perFree -ge $MinimumFreePercent) { 
            $OK = $True 
        } else { 
            $OK = $False 
        }

        $disk | Select DeviceID, VolumeName, Size, FreeSpace, @{Name = "OK"; Expression = { $OK } }
    } # close foreach

} # close function
Get-DiskInfo