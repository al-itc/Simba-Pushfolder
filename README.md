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

If you have issues, please dm me on my email address or raise an issue on Github.
