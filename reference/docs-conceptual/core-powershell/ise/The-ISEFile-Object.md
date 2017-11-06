---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  The ISEFile Object
ms.assetid:  1c6d91f3-c556-42a2-a017-79b6b7b4b7db
---

# The ISEFile Object
  An **ISEFile** object represents a file in Windows PowerShell® Integrated Scripting Environment (ISE). It is an instance of the Microsoft.PowerShell.Host.ISE.ISEFile class. This topic lists its member methods and member properties. The **$psISE.CurrentFile** and the files in the Files collection in a PowerShell tab are all instances of the Microsoft.PowerShell.Host.ISE.ISEFile class.

## Methods

### Save\( \[saveEncoding\] \)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Saves the file to disk.

 **\[saveEncoding\]** - optional [System.Text.Encoding](http://msdn.microsoft.com/library/system.text.encoding.aspx)
 An optional character encoding parameter to be used for the saved file. The default value is **UTF8**.

 **Exceptions**
 -   **System.IO.IOException**: The file could not be saved.

```
# Save the file using the default encoding (UTF8)
$psIse.CurrentFile.Save()

# Save the file as ASCII.
$psIse.CurrentFile.Save( [System.Text.Encoding]::ASCII )

# Gets the current encoding.
$myfile=$psIse.CurrentFile
$myfile.Encoding

```

### SaveAs\(filename, \[saveEncoding\]\)
  Supported in Windows PowerShell ISE 2.0 and later. 

 Saves the file with the specified file name and encoding.

 **filename** - String
 The name to be used to save the file.

 **\[saveEncoding\]** - optional [System.Text.Encoding](http://msdn.microsoft.com/library/system.text.encoding.aspx)
 An optional character encoding parameter to be used for the saved file. The default value is **UTF8**.

 **Exceptions**
 -   **System.ArgumentNullException**: The **filename** parameter is null.

- **System.ArgumentException**: The **filename** parameter is empty.

- **System.IO.IOException**: The file could not be saved.

```
# Save the file with a full path and name. 
$fullpath = "c:\temp\newname.txt"
$psIse.CurrentFile.SaveAs($fullPath) 
# Save the file with a full path and name and explicitly as UTF8. 
$psIse.CurrentFile.SaveAs( $fullPath, [System.Text.Encoding]::UTF8 )

```

## Properties

### DisplayName
  Supported in Windows PowerShell ISE 2.0 and later.

 The read-only property that gets the string that contains the display name of this file. The name is shown on the **File** tab at the top of the editor. The presence of an asterisk \(\*\) at the end of the name indicates that the file has changes that have not been saved.

```
# Shows the display name of the file.
$psIse.CurrentFile.DisplayName

```

### Editor
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-only property that gets the [editor object](The-ISEEditor-Object.md) that is used for the specified file.

```
# Gets the editor and the text.
$psIse.CurrentFile.Editor.Text

```

### Encoding
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-only property that gets the original file encoding. This is a **System.Text.Encoding** object.

```
# Shows the encoding for the file. 
$psIse.CurrentFile.Encoding

```

### FullPath
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-only property that gets the string that specifies the full path of the opened file.

```
# Shows the full path for the file. 
$psIse.CurrentFile.FullPath

```

### IsSaved
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-only Boolean property that returns **$true** if the file has been saved after it was last modified.

```
# Determines whether the file has been saved since it was last modified.
$myfile=$psIse.CurrentFile
$myfile.IsSaved

```

### IsUntitled
  Supported in Windows PowerShell ISE 2.0 and later. 

 The read-only property that returns **$true** if the file has never been given a title.

```
# Determines whether the file has never been given a title.
$psISE.CurrentFile.IsUntitled
$psISE.CurrentFile.SaveAs("temp.txt")
$psISE.CurrentFile.IsUntitled

```

## See Also
- [The ISEFileCollectionObject](The-ISEFileCollection-Object.md) 
- [The Windows PowerShell ISE Scripting Object Model](The-Windows-PowerShell-ISE-Scripting-Object-Model.md) 
- [Windows PowerShell ISE Object Model Reference](Windows-PowerShell-ISE-Object-Model-Reference.md)
- [The ISE Object Model Hierarchy](The-ISE-Object-Model-Hierarchy.md)
