Function New-Drives {

    Param()

    New-PSDrive -Name AppData -PSProvider FileSystem -Root $env:Appdata

    # Need to set the scope to Global for the drive to remain once the function has run.
    New-PSDrive -Name Temp -PSProvider FileSystem -Root $env:TEMP -Scope global

    $mydocs = Join-Path -Path $env:userprofile -ChildPath Documents

    New-PSDrive -Name Docs -PSProvider FileSystem -Root $mydocs

}

New-Drives

    DIR temp: | measure-object –property length -sum
