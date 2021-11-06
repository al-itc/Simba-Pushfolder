<# 
Version: 1.2
Author: Andreas Landry (a.landry@allaround-it.de)
Script: Pushfolder1.2.ps1

Release notes:
Version 1.1: Original published version.
Version 1.2: added differntiation between 'Dokumentenimport' and 'Belegeimport'

The script is provided "AS IS" with no warranties.

Requirements:
- Windows Powershell
- definition of the folders
- Existing Folders (Variables)
- no elevation required

Description:
This Script renames specific files from subfolders of a source folder and adds prefixes to the files (Subfoldername). The renamed files will get moved to Target folders. A logfile is created.

HowTo:
- create and define folders (Variables)
- add or remove file extensions appropriate to your requirements (file types)
- Include the script into task scheduler to have it executed automatically
- All subfolders in the defined Push root folders will be processed.
- new folders in the Push root folders are included automatically
#>

# Variables
$dip = 'd:\pushfolder\Dokumentenimport' # document import path
$bip = 'd:\pushfolder\Belegeimport' # 'Belege' import path
$tf_dip = 'D:\SBCache\Transfer\' # Target folder for 'Dokumentenimport'
$tf_bip = 'D:\SBCache\Transfer\PDFOCR\' # Target folder for 'Belegeimport'
$lfp = 'D:\Logs' # Logfile Path
$filetype5 = '.pdf' # file types for 5x#
$filetype2 = '.pdf', '.doc', '.docx', '.xls', '.xlsx', '.jpg', '.jpeg', '.png', '.bmp' # file types for 2x#

# Check folders
Try {
    if (-Not (Test-Path $dip)) {
        Throw "Dokumentenimport-Ordner nicht gefunden. Bitte vor der Ausführung dieses Skripts alle notwendigen Ordner anlegen."
    }
}
Catch {
    Write-Warning -message "Ein Fehler ist aufgetreten"
    $_
    break
}

Try {
    if (-Not (Test-Path $bip)) {
        Throw "Belegeimport-Ordner nicht gefunden. Bitte vor der Ausführung dieses Skripts alle notwendigen Ordner anlegen."
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
#Start-Transcript -Append -Path -UseMinimalHeader $lfp\pushfolder.log

# file renaming 5x#
$foldernames = Get-ChildItem -Path $bip -Recurse -Directory -Force -ErrorAction SilentlyContinue | Select-Object FullName, name
foreach ($row in $foldernames)
{
$Items = get-childitem -File -Path $row.fullname | Where-Object {$_.extension -in $filetype5}
Write-Host $row.fullname " includes:" $Items
$items | Rename-Item -NewName { $row.name + $_.Name } -Verbose -Force
}

# file move with filter 5x#
$filenames = Get-ChildItem -Path $bip -Recurse -file -Force -ErrorAction SilentlyContinue | Select-Object fullname, Name
foreach ($customer in $filenames)
{
$cnr = Split-Path $customer.fullname -Parent | Split-Path -Leaf
Move-Item -Path $customer.fullname -Include $cnr* -Destination $tf_bip -verbose -force -ErrorAction SilentlyContinue
}

# file renaming 2x#
$foldernames = Get-ChildItem -Path $dip -Recurse -Directory -Force -ErrorAction SilentlyContinue | Select-Object FullName, name
foreach ($row in $foldernames)
{
$Items = get-childitem -File -Path $row.fullname | Where-Object {$_.extension -in $filetype2}
Write-Host $row.fullname " includes:" $Items
$items | Rename-Item -NewName { $row.name + $_.Name } -Verbose -Force
}

# file move with filter 2x#
$filenames = Get-ChildItem -Path $dip -Recurse -file -Force -ErrorAction SilentlyContinue | Select-Object fullname, Name
foreach ($customer in $filenames)
{
$cnr = Split-Path $customer.fullname -Parent | Split-Path -Leaf
Move-Item -Path $customer.fullname -Include $cnr* -Destination $tf_dip -verbose -force -ErrorAction SilentlyContinue
}

#Stop-Transcript