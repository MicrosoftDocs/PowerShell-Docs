---
ms.date: 09/13/2016
ms.topic: reference
title: Updatable Help Authoring - Step-by-Step
description: Updatable Help Authoring - Step-by-Step
---
# Updatable Help Authoring: Step-by-Step

This documents lists the steps in the process of authoring Updatable Help.

## Authoring Updatable Help: Step-by-Step

Updatable Help is designed for end-users, but it also provides significant benefits to module
authors and help writers, including the ability to add content, fix errors, deliver in multiple UI
cultures, and respond to user comments and requests, long after the module has shipped. This topic
explains how you package and upload help files so that users can download and install them by using
the [Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) and
[Save-Help](/powershell/module/Microsoft.PowerShell.Core/Save-Help) cmdlets.

The following steps provide an overview of the process of supporting Updatable Help.

### Step 1: Find an internet site for your help files

The first step in creating updatable help is to find an internet location for your module's help
files. Actually, you can use two different locations. You can keep your module's help information
file (HelpInfo XML - described below) at one internet location and the help content CAB files at
another internet location. All help content CAB files for a module must be in the same location. You
can place help content CAB files for different modules in the same location.

### Step 2: Add a HelpInfoURI key to your module manifest

Add a **HelpInfoURI** key to your module manifest. The value of the key is the Uniform Resource
Identifier (URI) of the location of the HelpInfo XML information file for your module. For security,
the address must begin with "http" or "https". The URI should specify an internet location, but must
not include the HelpInfo XML filename.

For example:

```powershell

@{
RootModule = TestModule.psm1
ModuleVersion = '2.0'
HelpInfoURI = 'https://go.microsoft.com/fwlink/?LinkID=0123'
}
```

### Step 3: Create a HelpInfo XML file

The HelpInfo XML information file contains the URI of the internet location of your help files and
the version numbers of the newest help files for your module in each supported UI culture. Every
Windows PowerShell module has one HelpInfo XML file. When you update your help files, you edit or
replace the HelpInfo XML file; you do not add another one. For more information, see
[How to Create a HelpInfo XML File](./how-to-create-a-helpinfo-xml-file.md).

### Step 4: Create CAB files

Use a tool that creates cabinet (`.cab`) files, such as `MakeCab.exe`, to create a CAB file that
contains the help files for your module. Create a separate CAB file for the help files in each
supported UI culture. For more information, see
[How to Prepare Updatable Help CAB Files](./how-to-prepare-updatable-help-cab-files.md).

### Step 5: Upload your files

To publish new or updated help files, upload the CAB files to the internet location that is
specified by the **HelpContentUri** element in the HelpInfo XML file. Then, upload the HelpInfo XML
file to the internet location that is specified by the value of the **HelpInfoUri** key in the
module manifest.
