---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  Test-Path for FileSystem
online version:  http://go.microsoft.com/fwlink/?LinkId=834958
---

# Test-Path for FileSystem
Determines whether all elements of a file or directory path exist.  

## Syntax  

```  
Test-Path [-NewerThan <DateTime>] [-OlderThan <DateTime>] [<CommonParameters>]  

```  

## Description  
 In a file system drive, [Test-Path](../../../Microsoft.PowerShell.Management/Test-Path.md) can tell whether a path is valid, whether all elements of the path exist, or report whether a path leads to a file or a directory. It can also tell whether a file was changed before or after a particular date.  

 Note: This custom cmdlet help file explains how the [Test-Path](../../../Microsoft.PowerShell.Management/Test-Path.md) cmdlet works in a file system drive. For information about the [Test-Path](../../../Microsoft.PowerShell.Management/Test-Path.md) cmdlet in all drives, type "[Get-Help](../../Get-Help.md)[Test-Path](../../../Microsoft.PowerShell.Management/Test-Path.md) -Path $null" or see [Test-Path](../../../Microsoft.PowerShell.Management/Test-Path.md) at http://go.microsoft.com/fwlink/?LinkID=113418.  

## Parameters  

### -OlderThan <DateTime\>  
 Returns "True" when the LastWriteTime value of a file is less than the specified date. Otherwise, it returns "False". Enter a DateTime object, such as one that the [Get-Date](../../../Microsoft.PowerShell.Utility/Get-Date.md) cmdlet returns, or a string that can be converted to a DateTime object, such as "August 10, 2011 2:00 PM".  

 OlderThan is a dynamic parameter that works only on file system paths. It was introduced in Windows PowerShell 3.0.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -NewerThan <DateTime\>  
 Returns "True" when the LastWriteTime value of a file is greater than the specified date. Otherwise, it returns "False". Enter a DateTime object, such as one that the [Get-Date](../../../Microsoft.PowerShell.Utility/Get-Date.md) cmdlet returns, or a string that can be converted to a DateTime object, such as "August 10, 2011 2:00 PM".  

 NewerThan is a dynamic parameter that works only on file system paths. It was introduced in Windows PowerShell 3.0.  

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
|Inputs|System.String<br /><br /> You can pipe a string that contains a path (but not a literal path) to Test-Path.|  
|Outputs|System.Boolean|  

## Example 1  

```  
C:\PS>Test-Path -Path "C:\Documents and Settings\NicoleH"  

Description  
-----------  
This command tells whether all elements in the path exist, that is, the C: directory, the Documents and Settings directory, and the NicoleH directory. If any are missing, the cmdlet returns FALSE. Otherwise, it returns TRUE.  

```  

## Example 2  

```  
C:\PS>Test-Path -Path $profile  

C:\PS>Test-Path -Path $profile -IsValid  

Description  
-----------  
These commands test the path to the Windows PowerShell profile.   

The first command determines whether all elements in the path exist. The second command determines whether the syntax of the path is correct. In this case, the path is FALSE, but the syntax is correct (TRUE). These commands use $profile, the automatic variable that points to the location for the profile, even if the profile does not exist.  

For more information about automatic variables, see about_Automatic_Variables.  

```  

## Example 3  

```  
C:\PS>Test-Path -Path "C:\CAD\Commercial Buildings\*" -Exclude *.dwg  

Description  
-----------  
This command tells whether there are any files in the Commercial Buildings directory other than .dwg files.   

The command uses the Path parameter to specify the path. Because it includes a space, the path is enclosed in quotes. The asterisk at the end of the path indicates the contents of the Commercial Building directory. (With long paths, like this one, type the first few letters of the path, and then use the TAB key to complete the path.)  

The command uses the Exclude parameter to specify files that will be omitted from the evaluation.   

In this case, because the directory contains only .dwg files, the result is FALSE.  

```  

## Example 4  

```  
C:\PS>Test-Path -Path $profile -PathType Leaf  

Description  
-----------  
This command tells whether the path stored in the $profile variable leads to a file. In this case, because the Windows PowerShell profile is a .ps1 file, the cmdlet returns TRUE.  

```  

## Example 5  

```  
C:\PS>Test-Path -Path HKLM:\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell  

TRUE  

C:\PS> Test-Path -Path HKLM:\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell\ExecutionPolicy  
FALSE  

Description  
-----------  
These commands use the Test-Path cmdlet with the Windows PowerShell registry provider.   

The first command tests whether the registry path to the Microsoft.PowerShell registry key is correct on the system. If Windows PowerShell is installed correctly, the cmdlet returns TRUE.  

Test-Path does not work correctly with all Windows PowerShell providers. For example, you can use Test-Path to test the path to a registry key, but if you use it to test the path to a registry entry, it always returns FALSE, even if the registry entry is present.  

```  

## Example 6  

```  
C:\PS>Test-Path $pshome\PowerShell.exe -NewerThan "July 13, 2009"  

Description  
-----------  
This command uses the NewerThan dynamic parameter to determine whether the PowerShell.exe file on the computer is newer than July 13, 2009.   

The NewerThan parameter works only in file system drives.  

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

