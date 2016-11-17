---
title:   Catalog cmdlets
ms.date:  2016-07-13
keywords:  PowerShell, DSC, WMF
description:  
ms.topic:  article
author:  keithb
manager:  carolz
ms.prod:  powershell
ms.technology: WMF
---
# Catalog Cmdlets  

We have added two new cmdlets in [Microsoft.Powershell.Secuity](https://technet.microsoft.com/en-us/library/hh847877.aspx) module to generate and validate windows catalog files.  

## New-FileCatalog 
--------------------------------

`New-FileCatalog` creates a windows catalog file for set of folders and files. A catalog file contains hashes for all files in specified paths. Users can distribute the set of folders along with 
corresponding the catalog file that represents those folders. A catalog file can be used by the recipient of content to validate whether any changes were made to the folders after 
the catalog was created.    

```PowerShell
New-FileCatalog [-CatalogFilePath] <string> [[-Path] <string[]>] [-CatalogVersion <int>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
We support creating catalog version 1 and 2. Version 1 uses SHA1 hashing algorithm to create file hashes and version 2 uses SHA256. Catalog version 2 is not supported on 
*Windows Server 2008 R2* and *Windows 7*. It is recommended to use catalog version 2 if using platforms *Windows 8*, *Windows Server 2012* and above.  

To use this command on an existing module, specify the CatalogFilePath and Path variables to match the location of the module manifest. In the example below, the module manifest is in 
C:\Program Files\Windows PowerShell\Modules\Pester. 

![](../images/NewFileCatalog.jpg)

This creates the catalog file. 

![](../images/CatalogFile1.jpg)  

![](../images/CatalogFile2.jpg) 

To verify the integrity of a catalog file (Pester.cat in above exmaple) it should be signed using the [Set-AuthenticodeSignature](https://technet.microsoft.com/library/hh849819.aspx) cmdlet.   


## Test-FileCatalog 
--------------------------------

`Test-FileCatalog` validates the catalog representing a set of folders. 

```PowerShell
Test-FileCatalog [-CatalogFilePath] <string> [[-Path] <string[]>] [-Detailed] [-FilesToSkip <string[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

![](../images/TestFileCatalog.jpg)

This cmdlet compares the hashes of all files and their relative paths found in the catalog file with ones saved to disk. If it detects any mismatch between file hashes and paths it returns
a status of `ValidationFailed`. 
Users can retrieve all this information using the `Detailed` switch. The signing status of the catalog is displayed as the `Signature` field, which is same as 
calling the [Get-AuthenticodeSignature](https://technet.microsoft.com/en-us/library/hh849805.aspx) cmdlet on the catalog file. 
Users can also skip any file during validation by using the `FilesToSkip` parameter. 
