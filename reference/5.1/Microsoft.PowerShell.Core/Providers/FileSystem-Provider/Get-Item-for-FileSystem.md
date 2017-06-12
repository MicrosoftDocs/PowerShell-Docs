---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Get-Item for FileSystem
online version:  http://go.microsoft.com/fwlink/?LinkId=821468
---

# Get-Item for FileSystem
Gets files and folders.  

## Syntax  

```  
Get-Item [-Stream <string>] [<CommonParameters>]  

```  

## Description  
 In the file system, the [Get-Item](../../../Microsoft.PowerShell.Management/Get-Item.md) cmdlet gets files and folders.  

 Note: This custom cmdlet help file explains how the [Get-Item](../../../Microsoft.PowerShell.Management/Get-Item.md) cmdlet works in a file system drive. For information about the [Get-Item](../../../Microsoft.PowerShell.Management/Get-Item.md) cmdlet in all drives, type "[Get-Help](../../Get-Help.md)[Get-Item](../../../Microsoft.PowerShell.Management/Get-Item.md) -Path $null" or see [Get-Item](../../../Microsoft.PowerShell.Management/Get-Item.md) at http://go.microsoft.com/fwlink/?LinkID=113319.  

## Parameters  

### -Stream <string\>  
 Gets the specified alternate NTFS file stream from the file. Enter the stream name. Wildcards are supported. To get all streams, use an asterisk (*). This parameter is not valid on folders.  

 Stream is a dynamic parameter that the FileSystem provider adds to the [Get-Item](../../../Microsoft.PowerShell.Management/Get-Item.md) cmdlet. This parameter works only in file system drives.  

 This parameter is introduced in Windows PowerShell 3.0.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value|No alternate file streams|  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### <CommonParameters\>  
 This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -OutBuffer, -OutVariable,  -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../../About/about_CommonParameters.md).  

## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  

|||  
|-|-|  
|Inputs|System.String[ ]<br /><br /> You can pipe a path to the Get-Item cmdlet.|  
|Outputs|System.IO.FileInfo, System.IO.DirectoryInfo, Microsoft.PowerShell.Commands.AlternateStreamData<br /><br /> In the file system, Get-Item returns files and folders. If you use the Stream parameter, it returns AlternateStreamData objects.|  

## Example 1  

```  
C:\PS>Get-Item C:\Users\User01\Downloads\InternetFile.docx -Stream *  

   FileName: C:\Users\User01\Downloads\InternetFile.docx  

Stream                   Length  
------                   ------  
:$DATA                    45056  
Zone.Identifier              26  

Description  
-----------  
This command gets all stream data from a file that was downloaded from the Internet. The Zone.Identifier stream identifies a file that originated on the Internet. The $DATA stream is the default.  

The Stream parameter is introduced in Windows PowerShell 3.0.  

```  

## Example 2  

```  
C:\PS>Get-Item C:\ps-test\* -Stream Zone.Identifier -ErrorAction SilentlyContinue  

   FileName: C:\ps-test\Copy-Script.ps1  

Stream                   Length  
------                   ------  
Zone.Identifier              26  

   FileName: C:\ps-test\Start-ActivityTracker.ps1  

Stream                   Length  
------                   ------  
Zone.Identifier              26  

Description  
-----------  
This command gets Zone.Identifier stream data from all files in the C:\ps-test directory. The command uses the Stream parameter to specify the alternate stream and he ErrorAction parameter with a value of SilentlyContinue to suppress non-terminating errors that are generated when a file has no alternate data streams.   

The Stream parameter is introduced in Windows PowerShell 3.0.  

```  

## Example 3  

```  
C:\PS>Get-Item .  

Directory: C:\  

Mode                LastWriteTime     Length Name  
----                -------------     ------ ----  
d----         7/26/2006  10:01 AM            ps-test  

Description  
-----------  
This command gets the current directory. The dot (.) represents the item at the current location (not its contents).  

```  

## Example 4  

```  
C:\PS>Get-Item *  

Directory: C:\ps-test  

Mode                LastWriteTime     Length Name  
----                -------------     ------ ----  
d----         7/26/2006   9:29 AM            Logs  
d----         7/26/2006   9:26 AM            Recs  
-a---         7/26/2006   9:28 AM         80 date.csv  
-a---         7/26/2006  10:01 AM         30 filenoext  
-a---         7/26/2006   9:30 AM      11472 process.doc  
-a---         7/14/2006  10:47 AM         30 test.txt  

Description  
-----------  
This command gets the current directory of the C: drive. The object that is retrieved represents only the directory, not its contents.  

```  

## Example 5  

```  
C:\PS>Get-Item C:\  

Description  
-----------  
This command gets the items in the C: drive. The wildcard character (*) represents all the items in the container, not just the container.  

In Windows PowerShell, use a single asterisk (*) to get contents, instead of the traditional "*.*". The format is interpreted literally, so "*.*" would not retrieve directories or file names without a dot.  

```  

## Example 6  

```  
C:\PS>(Get-Item C:\Windows).LastAccessTime  

Description  
-----------  
This command gets the LastAccessTime property of the C:\Windows directory. LastAccessTime is just one property of file system directories. To see all of the properties of a directory, type "(Get-Item <directory-name>) | Get-Member".  

```  

## Example 7  

```  
C:\PS>Get-Item C:\Windows\*.* -Exclude w*  

Description  
-----------  
This command gets items in the Windows directory with names that include a dot (.), but do not begin with w*. This command works only when the path includes a wildcard character (*) to specify the contents of the item.  

```  

## See Also  
 [FileSystem Provider](../FileSystem-Provider.md)   
 [Add-Content](../../../Microsoft.PowerShell.Management/Add-Content.md)   
 [Clear-Content](../../../Microsoft.PowerShell.Management/Clear-Content.md)   
 [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md)   
 [Get-ChildItem](../../../Microsoft.PowerShell.Management/Get-ChildItem.md)   
 [Get-Content](../../../Microsoft.PowerShell.Management/Get-Content.md)   
 [Get-Item](../../../Microsoft.PowerShell.Management/Get-Item.md)   
 [Remove-Item](../../../Microsoft.PowerShell.Management/Remove-Item.md)   
 [Set-Content](../../../Microsoft.PowerShell.Management/Set-Content.md)   
 [Test-Path](../../../Microsoft.PowerShell.Management/Test-Path.md)

