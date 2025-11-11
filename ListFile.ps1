param([string]$Mode = "folders", [string]$Path = "./")

& {
    if ($Mode -ne "folders") {
        Write-Host "[ERROR] Please re-run with option 'folders'! (I don't understand '$Mode')" -ForegroundColor Red
        Write-Host "        Ex: .\ListFile.ps1 folders <path>"
        return
    }

    function Get-HumanSize($Bytes) {
        $Units = @(" B", "KiB", "MiB", "GiB", "TiB", "EiB", "PiB")
        $i = 0
        $Size = [double]$Bytes
        while ($Size -ge 1024 -and $i -lt ($Units.Length - 1)) { $Size /= 1024; $i++ }
        if ($Units[$i] -eq " B") { return "{0,5:N0}   {1}" -f $Size, $Units[$i] }
        return "{0,8:N2}{1}" -f $Size, $Units[$i]
    }

    function Get-Percent($Part, $Total) {
        if ($Total -le 0 -or $Part -eq 0) { return "00.00" }
        $Pct = ($Part / $Total) * 100
        if ($Pct -lt 0.01) { return "<1.00" }
        if ($Pct -lt 10) { return "0{0:N2}" -f $Pct }
        return "{0:N2}" -f $Pct
    }

    Clear-Host
    
    try {
        $SearchPath = (Get-Item $Path -ErrorAction Stop).FullName
    } catch {
        Write-Host "[ERROR] Path not found: $Path" -ForegroundColor Red
        return
    }

    Write-Host "FOLDER ($SearchPath) Sizes:"
    Write-Host ("=" * 80)

    # Get all items: folders and files
    $Folders = @(Get-ChildItem $SearchPath -Directory -ErrorAction SilentlyContinue | ForEach-Object {
        $Size = (Get-ChildItem $_.FullName -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
        if ($null -eq $Size) { $Size = 0 }
        [PSCustomObject]@{ Name = $_.Name; Size = [long]$Size; Type = 'Folder' }
    })

    $Files = @(Get-ChildItem $SearchPath -File -ErrorAction SilentlyContinue | ForEach-Object {
        [PSCustomObject]@{ Name = $_.Name; Size = [long]$_.Length; Type = 'File' }
    })

    $AllItems = $Folders + $Files
    if ($AllItems.Count -eq 0) {
        Write-Host "No items found."
        return
    }

    # Total size is the sum of all folders and files
    $TotalSize = [Math]::Max([long]1, [long]($AllItems | Measure-Object -Property Size -Sum).Sum)
    
    # Sort all items for display
    $SortedItems = $AllItems | Sort-Object Size -Descending

    foreach ($Item in $SortedItems) {
        $Human = Get-HumanSize $Item.Size
        $SizeStr = $Item.Size.ToString()
        $Padding = "." * [Math]::Max(0, (14 - $SizeStr.Length))
        $Pct = Get-Percent $Item.Size $TotalSize
        
        $DisplayName = if ($Item.Type -eq 'Folder') { "$($Item.Name)\" } else { $Item.Name }
        Write-Host "($Human   ) | $SizeStr$Padding | $Pct% | $DisplayName"
    }

    Write-Host ("-" * 80)
    $TotalFolderSize = [long]($Folders | Measure-Object -Property Size -Sum).Sum
    $TotalFileSize = [long]($Files | Measure-Object -Property Size -Sum).Sum

    $FolderPct = Get-Percent $TotalFolderSize $TotalSize
    $FilePct = Get-Percent $TotalFileSize $TotalSize
    $HumanFolders = Get-HumanSize $TotalFolderSize
    $HumanFiles = Get-HumanSize $TotalFileSize

    Write-Host "Subfolders : $HumanFolders ($FolderPct%)"
    Write-Host "Files      : $HumanFiles ($FilePct%)"
}
