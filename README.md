# Simba Pushfolder #
Author: Andreas Landry (a.landry@allaround-it.de)

Release notes:
* Version 1.1 - Original published version.
* Version 1.2 - Added differntiation between 'Dokumentenimport' and 'Belegeimport'

The script is provided "AS IS" with no warranties.

## Version 1.2 ##

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

## Version 1.1 ##

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

If you have issues, please dm me on my email address or raise an issue on Github.

--------------------------------------------------

# Mandantenordner #
Author: Andreas Landry (a.landry@allaround-it.de)

Release notes:
* Version 1.0 - Original published version.
* Version 1.1 - Added different Folder structure in Push Root Folder

The script is provided "AS IS" with no warranties.

## Version 1.1 ##

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
- edit the CSV with Notepad++:
1. Convert to UTF8
2. Remove invalid characters for foldernames (like ")
- define $dip and $bup variables to match the one being used in "pushfolder.ps1"
- new folders in the Push root folders are created according to the section "create subfolder (5#,2#)"
- for additional subfolders according the 5# or 2# scheme, please add appropriate lines in the section "create Subfolder"
- run the scipt just once, no need to repeat. If repeated, no existing folders get overwritten
