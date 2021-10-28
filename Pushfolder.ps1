<# 
Version: 1.1
Author: Andreas Landry (a.landry@allaround-it.de)
Script: Pushfolder.ps1

Release notes:
Version 1.1: Original published version. 

The script is provided "AS IS" with no warranties.

Requirements:
- Windows Powershell
- definition of the folders
- Existing Folders (Variables)
- no elevation required

Description:
This Script renames specific files from subfolders of a source folder and adds prefixes to the files (Subfoldername). The renamed files will get moved to one Target folder. A logfile is created.

HowTo:
- create and define folders (Variables)
- add or remove file extensions appropriate to your requirements (file types)
- Include the script into task scheduler to have it executed automatically. Create the scheduled task to be run as Administrator.
- All subfolders in the defined Push root folder will be processed.
- new folders in the Push root folders are included automatically
#>

# Variables
$prf = 'd:\pushfolder' # Push root folder
$tf = 'D:\SBCache\Transfer\' # Target folder
$lfp = 'D:\Logs\' # Logfile Path
$filetype = '.pdf', '.doc', '.docx', '.xls', '.xlsx', '.jpg', '.jpeg', '.png', '.bmp' # file types

# Check folders
Try {
    if (-Not (Test-Path $prf)) {
        Throw "Push root folder nicht gefunden. Bitte vor der Ausführung dieses Skripts alle notwendigen Ordner anlegen."
    }
}
Catch {
    Write-Warning -message "Ein Fehler ist aufgetreten"
    $_
    break
}

Try {
    if (-Not (Test-Path $tf)) {
        Throw "Target folder nicht gefunden. Bitte vor der Ausführung dieses Skripts alle notwendigen Ordner anlegen."
    }
}
Catch {
    Write-Warning -message "Ein Fehler ist aufgetreten"
    $_
    break
}

Try {
    if (-Not (Test-Path $lfp)) {
        Throw "Logfile folder nicht gefunden. Bitte vor der Ausführung dieses Skripts alle notwendigen Ordner anlegen."
    }
}
Catch {
    Write-Warning -message "Ein Fehler ist aufgetreten"
    $_
    break
}

# Transcript
Start-Transcript -Append -Path -UseMinimalHeader $lfp\pushfolder.log

# file renaming
$foldernames = Get-ChildItem -Path $prf -Recurse -Directory -Force -ErrorAction SilentlyContinue | Select-Object FullName, name
foreach ($row in $foldernames)
{
$Items = get-childitem -File -Path $row.fullname | Where-Object {$_.extension -in $filetype}
Write-Host $row.fullname " includes:" $Items
$items | Rename-Item -NewName { $row.name + $_.Name } -Verbose -Force
}

# file move with filter
$filenames = Get-ChildItem -Path $prf -Recurse -file -Force -ErrorAction SilentlyContinue | Select-Object fullname, Name
foreach ($customer in $filenames)
{
$cnr = Split-Path $customer.fullname -Parent | Split-Path -Leaf #store folder name in variable by cutting it off the full path
Move-Item -Path $customer.fullname -Include $cnr* -Destination $tf -verbose -force -ErrorAction SilentlyContinue
}

Stop-Transcript