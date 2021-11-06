<# 
Version: 1.1
Author: Andreas Landry (a.landry@allaround-it.de)
Script: Mandantenordner1.1.ps1

Release notes:
Version 1.0: Original published version.
Version 1.1: Added different Folder structure in Push Root Folder

The script is provided "AS IS" with no warranties.

Requirements:
- Windows Powershell
- definition of the folders (Variables)
- Existing Folders (Variables)
- no elevation required

Description:
This Script creates subfolders in the push root folder. The subfolders are made of the mandator-no. plus 5x# and 2x# to support the Simba Importmanager.

HowTo:
- Export mandates from the Simba Client by using "Zentrale Dienste" -> "Datenverwaltung" -> "Stammdatentransfer" -> "Stammdaten exportieren (Mandantenstamm)"
- Save the Export to file named "mandanten.csv" into a folder of your choice
- define the same folder into the variable "$csvpath"
- edit the CSV with Notepad:
1. Convert to UTF8
2. Remove invalid characters for foldernames (like ")
- define $dip and $bup variables to match the one being used in "pushfolder.ps1"
- new folders in the Push root folders are created according to the section "create subfolder (5#,2#)"
- for additional subfolders according the 5# or 2# scheme, please add appropriate lines in the section "create Subfolder"
- run the scipt just once, no need to repeat. If repeated, no existing folders get overwritten
#>

#Variables
$csvpath = 'D:\scripts\mandanten.csv'
$dip = 'D:\pushfolder\Dokumentenimport' # document import path
$bip = 'D:\pushfolder\Belegeimport' # belege import path

# import CSV // create subfolder $bip
$Mandantenliste = Import-Csv -Path $csvpath -Delimiter ';' -Header 'Mandantennummer', 'Mandantenname'
foreach ($mandant in $Mandantenliste) 
            {
            mkdir -Path $bip -Name ($mandant.Mandantenname+ "--" +$mandant.Mandantennummer) -ErrorAction SilentlyContinue
            }
Start-Sleep 2

# create subfolder (5#)
$foldernames = Get-ChildItem -Path $bip -Directory -Force -ErrorAction SilentlyContinue | Select-Object FullName
foreach ($fnentry in $foldernames) 
            {

            $fullpath = $fnentry.Fullname 

 # Extract the 'Mandantennummer' from path

            $conr = $fullpath.Substring($fullpath.LastIndexOf('--'))
            $conr = $conr.TrimStart("--")
    
 # create subfolder $bip

            mkdir -Path $fullpath -Name $conr##### -ErrorAction SilentlyContinue
            mkdir -Path $fullpath -Name $conr#B#### -ErrorAction SilentlyContinue #Barbeleg
            mkdir -Path $fullpath -Name $conr#E#### -ErrorAction SilentlyContinue #Eingangsrechnung
            mkdir -Path $fullpath -Name $conr#A#### -ErrorAction SilentlyContinue #Ausgangsrechnung
            mkdir -Path $fullpath -Name $conr#K#### -ErrorAction SilentlyContinue #Kassenbeleg
            mkdir -Path $fullpath -Name $conr#C#### -ErrorAction SilentlyContinue #Kreditkartenbeleg
            mkdir -Path $fullpath -Name $conr#G#### -ErrorAction SilentlyContinue #EC-Beleg (G für Giro Card)

            }
			
# import CSV // create subfolder $dip
$Mandantenliste = Import-Csv -Path $csvpath -Delimiter ';' -Header 'Mandantennummer', 'Mandantenname'
foreach ($mandant in $Mandantenliste) 
            {
            mkdir -Path $dip -Name ($mandant.Mandantenname+ "--" +$mandant.Mandantennummer) -ErrorAction SilentlyContinue
            }
Start-Sleep 2

# create subfolder (2#)
$foldernames = Get-ChildItem -Path $dip -Directory -Force -ErrorAction SilentlyContinue | Select-Object FullName
foreach ($fnentry in $foldernames) 
            {

            $fullpath = $fnentry.Fullname 

 # Extract the 'Mandantennummer' from path

            $conr = $fullpath.Substring($fullpath.LastIndexOf('--'))
            $conr = $conr.TrimStart("--")
    
 # create subfolder $dip

            mkdir -Path $fullpath -Name $conr## -ErrorAction SilentlyContinue
            
            }