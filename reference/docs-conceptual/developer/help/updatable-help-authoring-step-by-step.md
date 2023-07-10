---
description: Updatable Help Authoring - Step-by-Step
ms.date: 07/10/2023
ms.topic: reference
title: Updatable Help Authoring - Step-by-Step
---
# Updatable Help Authoring: Step-by-Step

This article documents the steps required to publish Updatable Help.

## Authoring Updatable Help: Step-by-Step

Updatable Help is designed for end-users, but it also provides significant benefits to module
authors and help writers, including the ability to add content, fix errors, deliver in multiple UI
cultures, and respond to user comments and requests, long after the module has shipped. This topic
explains how you package and upload help files so that users can download and install them using the
[Update-Help][06] and [Save-Help][05] cmdlets.

The following steps provide an overview of the process of supporting Updatable Help.

### Step 1: Find an internet site for your help files

The first step in creating updatable help is to find an internet location for your module's help
files. Actually, you can use two different locations. You can keep your module's help information
file (HelpInfo XML - described below) at one internet location and the help content files (CAB and
ZIP) at another internet location. All help content files for a module must be in the same location.
You can place help content files for different modules in the same location.

### Step 2: Add a HelpInfoURI key to your module manifest

Add a **HelpInfoURI** key to your module manifest. The value of the key is the Uniform Resource
Identifier (URI) of the location of the HelpInfo XML information file for your module. For security,
the address must begin with `http:` or `https:`. The URI should specify an internet location for the
HelpInfo XML file. Don't include the HelpInfo XML filename.

For example:

```powershell
@{
    RootModule = TestModule.psm1
    ModuleVersion = '2.0'
    HelpInfoURI = 'https://go.microsoft.com/fwlink/?LinkID=0123'
}
```

> [!NOTE]
> The **HelpInfoURI** must end with a forward slash (`/`) character or redirect to a location that
> ends with a forward slash (`/`).

### Step 3: Create a HelpInfo XML file

The HelpInfo XML information file contains the URI of the internet location of your help files and
the version numbers of the newest help files for your module in each supported UI culture. Every
PowerShell module has one HelpInfo XML file. When you update your help files, you must update the
HelpInfo XML file. For more information, see [How to Create a HelpInfo XML File][01].

### Step 4: Create CAB and ZIP files

PowerShell on Windows expects the help content files a module to be stored in a CAB file. PowerShell
on Linux or macOS expects the help content files a module to be stored in a ZIP file. If your module
runs across multiple platforms you must create both formats.

Use a tool, such as `MakeCab.exe`, to create a CAB file that contains the help files for your
module. Create a separate CAB file for the help files in each supported UI culture. For more
information, see [How to Prepare Updatable Help CAB Files][02].

You can use the [Compress-Archive][04] cmdlet to create a ZIP file.

### Step 5: Upload your files

To publish new or updated help files, upload the help content files to the internet location
specified by the **HelpContentUri** element in the HelpInfo XML file. Then, upload the HelpInfo XML
file to the internet location specified by the value of the **HelpInfoUri** key in the module
manifest.

## Using PlatyPS to create help content

**PlatyPS** is a PowerShell module designed to help you create Help content for your modules. You
author the help content in Markdown files. **PlatyPS** can create Markdown templates for your
cmdlet, convert the Markdown files to the XML help format (MAML), create HelpInfo XML files, and
package the MAML help content into CAB and ZIP files.

For more information, see [Create XML-based help using PlatyPS][03].

<!-- link references -->
[01]: ./how-to-create-a-helpinfo-xml-file.md
[02]: ./how-to-prepare-updatable-help-cab-files.md
[03]: /powershell/utility-modules/platyps/create-help-using-platyps
[04]: xref:Microsoft.PowerShell.Archive.Compress-Archive
[05]: xref:Microsoft.PowerShell.Core.Save-Help
[06]: xref:Microsoft.PowerShell.Core.Update-Help
