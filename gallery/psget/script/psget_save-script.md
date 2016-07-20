# Save-Script

Save-Script cmdlet lets you to review the script file by saving it to a specified location.

## Description

The Save-Script cmdlet saves the specified script.

## Cmdlet syntax

```powershell
Get-Command -Name Save-Script -Module PowerShellGet -Syntax
```
## Cmdlet online help reference

[Save-Script](http://go.microsoft.com/fwlink/?LinkId=619786)

## Example commands

### Example 1: Save a script from a repository
This command saves the latest version of the script Fabrikam-ClientScript from GalleryINT repository to the local folder C:\ScriptSharingDemo

```powershell
Save-Script -Name Fabrikam-ClientScript -Repository GalleryINT -Path C:\ScriptSharingDemo
```

### Example 2: Save a version of a script by piping from the Find-Script cmdlet

The first command finds version 1.5 of Fabrikam-ClientScript from the repository GalleryINT and saves it to the folder C:\ScriptSharingDemo

The second command validates the saved script metadata.

```powershell
Find-Script -Name Fabrikam-ClientScript -Repository GalleryINT -RequiredVersion 1.5 | Save-Script -Path C:\\ScriptSharingDemo
Test-ScriptFileInfo C:\\ScriptSharingDemo\\Fabrikam-ClientScript.ps1

Version Name Author Description
------- ---- ------ -----------
1.5 Fabrikam-ClientScript manikb Description for the Fabrikam-ClientScript script
```
