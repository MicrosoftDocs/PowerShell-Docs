---
ms.date: 03/22/2012
ms.topic: reference
title: Updatable Help Overview
description: Updatable Help Overview
---
# Updatable Help Overview

This document provides a basic introduction to the design and operation of the PowerShell Updatable
Help feature. It is designed for module authors and others who deliver Windows PowerShell help
topics to users.

## Introduction

PowerShell help topics are an integral part of the PowerShell experience. Like PowerShell modules,
help topics are continually updated and improved by the authors and by the contributions of the
community of PowerShell users.

The *Updatable Help* feature, introduced in Windows PowerShell 3.0, ensures that users have the
newest versions of help topics at the command prompt, even for built-in PowerShell commands, without
downloading new modules or running Windows Update. Updatable Help makes updating simple by providing
cmdlets that download the newest versions of help topics from the internet and install them in the
correct subdirectories on the user's local computer. Even users who are behind firewalls can use the
new cmdlets to get updated help from an internal file share.

Updatable Help is fully supported by all Windows PowerShell modules in Windows 8 and Windows Server
2012, and its features are available to all Windows PowerShell module authors. Updatable Help
supports only XML-based help files. It does not support comment-based help.

Updatable Help includes the following features.

- The [Update-Help](/powershell/module/Microsoft.PowerShell.Core/Update-Help) cmdlet, which
  determines whether users have the newest help files for a module and, if not, downloads the newest
  help files from the internet, unpacks them, and installs them in the correct module subdirectories
  on the user's computer. Users can use the
  [Get-Help](/powershell/module/Microsoft.PowerShell.Core/Get-Help) cmdlet to view the
  newly-installed help topics immediately. They do not need to restart PowerShell.

- The [Save-Help](/powershell/module/Microsoft.PowerShell.Core/Save-Help) cmdlet, which downloads
  the newest help files from the internet and saves them in a file system directory. Users can use
  the `Update-Help` cmdlet to get help files from the file system directory, and unpack and install
  them in the module subdirectories on the user's computer. The `Save-Help` cmdlet is designed for
  users who have limited or no internet access and for enterprises who prefer to limit internet
  access.

- **Help for a Module**. Help files for a module are managed and delivered as a unit, so users can
  get all of the help files for the modules they use. Updatable help is supported only for modules,
  not for Windows PowerShell snap-ins.

- **Version support**. Updatable Help uses standard four-position (N1.N2.N3.N4) version numbers.
  Updatable Help downloads help files when the version number of the help files on the user's
  computer (or in the `Save-Help` directory) is lower than the version number of the help files at
  the internet location.

- **Multi-language support**. Updatable Help supports module help files in multiple UI cultures.
  Updatable Help filenames include standard language codes, such as "en-US" and "ja-JP", and the
  `Update-Help` and `Save-Help` cmdlets place the help files into language-specific subdirectories
  of the module directory.

- **Auto-generated help**. The [Get-Help](/powershell/module/Microsoft.PowerShell.Core/Get-Help)
  cmdlet displays basic help for commands that do not have help files. The auto-generated help
  includes the command syntax and aliases, and instructions for using online help and Updatable
  Help.

- **Enhanced Online help**. Easy access to online help no longer requires help files. The **Online**
  parameter of the `Get-Help` cmdlet now gets the URL of an online help topic from the value of the
  **HelpUri** property of any command, if it cannot find the online help URL in a help file. You can
  populate the **HelpUri** property by adding a **HelpUri** attribute to the code of cmdlets,
  functions, and CIM commands, or by using the **.Link** comment-based help directive in workflows
  and scripts.

  To make our help files updatable, the Windows PowerShell modules in Windows 8 and Windows Server
  vNext do not come with help files. Users can use Updatable Help to install help files and update
  them. Authors of other modules can include help files in modules or omit them. Support for
  Updatable Help is optional, but recommended.
