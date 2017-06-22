---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Clear-Content for FileSystem
online version:  http://go.microsoft.com/fwlink/?LinkId=834949
---

# Clear-Content for FileSystem
Deletes the contents of an item, but does not delete the item.  

## Syntax  

```  
Clear-Content [-Stream <string>] [<CommonParameters>]  

```  

## Description  
 In the file system, [Clear-Content](../../../Microsoft.PowerShell.Management/Clear-Content.md) clears the content in a file, but does not delete the file. It has no effect on folders.  

 Note: This custom cmdlet help file explains how the [Clear-Content](../../../Microsoft.PowerShell.Management/Clear-Content.md) cmdlet works in a file system drive. For information about the [Clear-Content](../../../Microsoft.PowerShell.Management/Clear-Content.md) cmdlet in all drives, type "[Get-Help](../../Get-Help.md)[Clear-Content](../../../Microsoft.PowerShell.Management/Clear-Content.md) -Path $null" or see [Clear-Content](../../../Microsoft.PowerShell.Management/Clear-Content.md) at http://go.microsoft.com/fwlink/?LinkID=113282.  

## Parameters  

### -Stream <string\>  
 Deletes the content in the specified alternate data stream, but does not delete the alternate data stream. Enter the stream name. Wildcards are not supported.  

 Stream is a dynamic parameter that the FileSystem provider adds to the [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md) cmdlet. This parameter works only in file system drives.  

 You can use the [Clear-Content](../../../Microsoft.PowerShell.Management/Clear-Content.md) cmdlet to clear the content of an alternate data stream. However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet. If you verify that a downloaded file is safe, use the Unblock-File cmdlet.  

 This parameter is introduced in Windows PowerShell 3.0.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### <CommonParameters\>  
 This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -OutBuffer, -OutVariable,  -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../../About/about_CommonParameters.md).  

## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  

|||  
|-|-|  
|Inputs||  
|Outputs||  

## Example 1  

```  
C:\PS>Get-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier  

[ZoneTransfer]  
ZoneId=3  

C:\PS>Clear-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier  

C:\PS>Get-Content C:\Test\Copy-Script.ps1 -Stream Zone.Identifier  
C:\PS>  

Description  
-----------  
This example shows how the Clear-Content cmdlet clears the content from an alternate data stream while leaving the stream intact.  

The first command uses the Get-Content cmdlet to get the content of the Zone.Identifier stream in the Copy-Script.ps1 file, which was downloaded from the Internet.  

The second command uses the Clear-Content cmdlet to clear the content.   

The third command repeats the first command. It verifies that the content is cleared, but the stream remains. If the stream were deleted, the command would generate an error.  

You can use a method like this one to clear the content of an alternate data stream. However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet. If you verify that a downloaded file is safe, use the Unblock-File cmdlet.  

```  

## Example 2  

```  
C:\PS>Clear-Content ..\SmpUsers\*\init.txt  

Description  
-----------  
This command deletes all of the content from the "init.txt" files in all subdirectories of the SmpUsers directory. The files are not deleted, but they are empty.  

```  

## Example 3  

```  
C:\PS>Clear-Content -Path * -Filter *.log -Force  

Description  
-----------  
This command deletes the contents of all files in the current directory with the ".log" file name extension, including files with the read-only attribute. The asterisk (*) in the path represents all items in the current directory. The Force parameter makes the command effective on read-only files. Using a filter to restrict the command to files with the ".log" file name extension instead of specifying "*.log" in the path makes the operation faster.  

```  

## Example 4  

```  
C:\PS>Clear-Content c:\Temp\* -Include Smp* -Exclude *2* -WhatIf  

Description  
-----------  
This command requests a prediction of what would happen if you submitted the command: "clear-content c:\temp\* -include smp* -exclude *2*". The result lists the files that would be cleared; in this case, files in the Temp directory whose names begin with "Smp", unless the file names include a "2". To execute the command, run it again without the Whatif parameter.  

```  

## See Also  
 [FileSystem Provider](../FileSystem-Provider.md)   
 [Clear-Content](../../../Microsoft.PowerShell.Management/Clear-Content.md)   
 [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md)   
 [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md)   
 [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md)   
 [Get-Item](../../../Microsoft.PowerShell.Management/Get-Item.md)   
 [Remove-Item](../../../Microsoft.PowerShell.Management/Remove-Item.md)   
 [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md)   
 [Test-Path](../../../Microsoft.PowerShell.Management/Test-Path.md)

