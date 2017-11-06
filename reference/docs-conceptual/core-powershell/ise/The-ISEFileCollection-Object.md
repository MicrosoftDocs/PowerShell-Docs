---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  The ISEFileCollection Object
ms.assetid:  0f86a427-ea38-4bce-85f8-06c98d30d508
---

# The ISEFileCollection Object
  The **ISEFileCollection** object is a collection of **ISEFile** objects. An example is the $psISE.CurrentPowerShellTab.Files collection.

## Methods

### Add\( \[fullPath\] \)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Creates and returns a new untitled file and adds it to the collection. The **IsUntitled** property of the newly created file is **$true**.

 **\[fullPath\]** - Optional string
 The fully specified path of the file. An exception is generated if you include the **fullPath** parameter and a relative path, or if you use a file name instead of the full path.

```
# Adds a new untitled file to the collection of files in the current PowerShell tab.
$newFile = $psISE.CurrentPowerShellTab.Files.Add()

# Adds a file specified by its full path to the collection of files in the current PowerShell tab.
$psISE.CurrentPowerShellTab.Files.Add("$pshome\Examples\profile.ps1")

```

### Remove\( File, \[Force\] \)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Removes a specified file from the current PowerShell tab.

 **File** - String
 The ISEFile file that you want to remove from the collection. If the file has not been saved, this method throws an exception. Use the **Force** switch parameter to force the removal of an unsaved file.

 **\[Force\]** - optional Boolean
 If set to **$true**, grants permission to remove the file even if it has not been saved after last use. The default is **$false**.

```
# Removes the first opened file from the file collection associated with the current PowerShell tab.
# If the file has not yet been saved, then an exception is generated.
$firstfile = $psISE.CurrentPowerShellTab.Files[0]
$psISE.CurrentPowerShellTab.Files.Remove($firstfile)

# Removes the first opened file from the file collection associated with the current PowerShell tab, even if it has not been saved.
$firstfile = $psISE.CurrentPowerShellTab.Files[0]
$psISE.CurrentPowerShellTab.Files.Remove($firstfile, $true)
```

### SetSelectedFile\( selectedFile \)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Selects the file that is specified by the **selectedFile** parameter.

 **selectedFile** - Microsoft.PowerShell.Host.ISE.ISEFile
 The ISEFile file that you want to select.

```

# Selects the specified file.
$firstfile = $psISE.CurrentPowerShellTab.Files[0]
$psISE.CurrentPowerShellTab.Files.SetSelectedFile($firstfile)

```

## See Also
- [The ISEFile Object](The-ISEFile-Object.md) 
- [The Windows PowerShell ISE Scripting Object Model](The-Windows-PowerShell-ISE-Scripting-Object-Model.md) 
- [Windows PowerShell ISE Object Model Reference](Windows-PowerShell-ISE-Object-Model-Reference.md) 
- [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)
