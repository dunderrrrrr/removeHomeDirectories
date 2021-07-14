Param ([switch] $force)

echo "##### SCRIPT START ####"
Get-Date -Format "dddd dd/MM/yyyy HH:mm:ss"
 
$oupath = "OU=Leaver,OU=Mogard_AB,DC=MG,DC=local"

$dirs_path = Get-ADUser -Filter 'enabled -eq $false' -SearchBase $oupath -Properties HomeDirectory, samAccountName | Select HomeDirectory, samAccountName
$dirs_count = $dirs_path.Count

function hardDelete {
    $dirs_path | ForEach-Object {
        if ($_.HomeDirectory.Length -gt 0) {
            
            $pathExists = Test-Path -Path $_.HomeDirectory
            if ($pathExists) {
                echo "Removing: $($_.HomeDirectory) ($($_.samAccountName))"
                Remove-item $_.HomeDirectory -Recurse -Force
            } else {
                echo "Info: Path $($_.HomeDirectory) does not exist ($($_.samAccountName))"
            }
            
        } else {
            echo "Skipping: $($_.samAccountName) is missing homefolder."
        }
    }
}

Write-Output "`nHomedirs found:"
Write-Output $dirs_path | fl
Write-Output "Total path count: $($dirs_count)"

if ($force) {
    hardDelete
} else {
    $confirm = Read-Host -Prompt "`nRemove paths? (y/n)"
    if ($confirm -eq 'yes' -or $confirm -eq 'y' -or $confirm -eq 'Y') {
        hardDelete
    } else {
        echo "No changes made, exiting."
    }
}

Get-Date -Format "`ndddd dd/MM/yyyy HH:mm:ss"
echo "#### SCRIPT END ####"