---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Remove-Item for FileSystem
---

# Remove-Item for FileSystem
Deletes files and folders.  
  
## Syntax  
  
```  
Remove-Item [-Stream <string>] [<CommonParameters>]  
  
```  
  
## Description  
 In file system drives, the [Remove-Item](../../../Microsoft.PowerShell.Management/Remove-Item.md) cmdlet deletes files and folders.  
  
 If you use the Stream dynamic parameter, it deletes the specified alternate data stream, but does not delete the file.  
  
 Note: This custom cmdlet help file explains how the [Remove-Item](../../../Microsoft.PowerShell.Management/Remove-Item.md) cmdlet works in a file system drive. For information about the [Remove-Item](../../../Microsoft.PowerShell.Management/Remove-Item.md) cmdlet in all drives, type "[Get-Help](../../Get-Help.md)[Remove-Item](../../../Microsoft.PowerShell.Management/Remove-Item.md) -Path $null" or see [Remove-Item](../../../Microsoft.PowerShell.Management/Remove-Item.md) at http://go.microsoft.com/fwlink/?LinkID=113373.  
  
## Parameters  
  
### -Stream <string\>  
 Deletes the specified alternate data stream from a file, but does not delete the file. Enter the stream name. Wildcards are supported. This parameter is not valid on folders.  
  
 Stream is a dynamic parameter that the FileSystem provider adds to the [Remove-Item](../../../Microsoft.PowerShell.Management/Remove-Item.md) cmdlet. This parameter works only in file system drives.  
  
 You can use the [Remove-Item](../../../Microsoft.PowerShell.Management/Remove-Item.md) cmdlet to delete an alternate data stream. However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet. If you verify that a downloaded file is safe, use the Unblock-File cmdlet.  
  
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
C:\PS>Get-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier  
  
   FileName: \\C:\Test\Copy-Script.ps1  
  
Stream                   Length  
------                   ------  
Zone.Identifier              26  
  
C:\PS>Remove-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier  
  
C:\PS>Get-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier  
  
get-item : Could not open alternate data stream 'Zone.Identifier' of file 'C:\Test\Copy-Script.ps1'.  
At line:1 char:1  
+ get-item 'C:\Test\Copy-Script.ps1' -Stream Zone.Identifier  
+ [!INCLUDE[]()][!INCLUDE[]()][!INCLUDE[]()][!INCLUDE[]()][!INCLUDE[]()]~~  
    + CategoryInfo          : ObjectNotFound: (C:\Test\Copy-Script.ps1:String) [Get-Item], FileNotFoundE  
   xception  
    + FullyQualifiedErrorId : AlternateDataStreamNotFound,Microsoft.PowerShell.Commands.GetItemCommand  
  
C:\PS>Get-Item C:\Test\Copy-Script.ps1  
  
    Directory: C:\Test  
  
Mode                LastWriteTime     Length Name  
----                -------------     ------ ----  
-a---          8/4/2011  11:15 AM       9436 Copy-Script.ps1  
  
Description  
-----------  
This example shows how to use the Stream dynamic parameter of the Remove-Item cmdlet to delete an alternate data stream. The stream parameter is introduced in Windows PowerShell 3.0.  
  
The first command uses the Stream dynamic parameter of the Get-Item cmdlet to get the Zone.Identifier stream of the Copy-Script.ps1 file.   
  
The second command uses the Stream dynamic parameter of the Remove-Item cmdlet to remove the Zone.Identifier stream of the file.  
  
The third command uses the Stream dynamic parameter of the Get-Item cmdlet to verify that the Zone.Identifier stream is deleted.  
  
The fourth command Get-Item cmdlet without the Stream parameter to verify that the file is not deleted.  
  
```  
  
## Example 2  
  
```  
C:\PS>Remove-Item C:\Test\*.*  
  
Description  
-----------  
This command deletes all of the files with names that include a dot (.) from the C:\Test directory. Because the command specifies a dot, the command does not delete directories or files with no file name extension.  
  
```  
  
## Example 3  
  
```  
C:\PS>Remove-Item * -Include *.doc -Exclude *1*  
  
Description  
-----------  
This command deletes from the current directory all files with a .doc file name extension and a name that does not include "1". It uses the wildcard character (*) to specify the contents of the current directory. It uses the Include and Exclude parameters to specify the files to delete.  
  
```  
  
## Example 4  
  
```  
C:\PS>Remove-Item -Path C:\Test\hidden-RO-file.txt -Force  
  
Description  
-----------  
This command deletes a file that is both hidden and read-only. It uses the Path parameter to specify the file. It uses the Force parameter to give permission to delete it. Without Force, you cannot delete read-only or hidden files.  
  
```  
  
## Example 5  
  
```  
C:\PS>Get-ChildItem * -Include *.csv -Recurse | Remove-Item  
  
Description  
-----------  
This command deletes all of the CSV files in the current directory and all subdirectories recursively.  
  
Because the Recurse parameter in this cmdlet is faulty, the command uses the Get-Childitem cmdlet to get the desired files, and it uses the pipeline operator to pass them to the Remove-Item cmdlet.  
  
In the Get-ChildItem command, the Path parameter has a value of *, which represents the contents of the current directory. It uses the Include parameter to specify the CSV file type, and it uses the Recurse parameter to make the retrieval recursive.  
  
If you try to specify the file type in the path, such as "-path *.csv", the cmdlet interprets the subject of the search to be a file that has no child items, and Recurse fails.  
  
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

