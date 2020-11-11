---
ms.date: 09/13/2016
ms.topic: reference
title: How to Create and Upload CAB Files
description: How to Create and Upload CAB Files
---
# How to Create and Upload CAB Files

This topic explains how to create Updatable Help CAB files and upload them to the location where the
Updatable Help cmdlets can find them.

## How to Create and Upload Updatable Help CAB Files

You can use the Updatable Help feature to deliver new or updated help files for a module in multiple
languages and cultures. An Updatable Help package for a module consists of one HelpInfo XML file and
one or more cabinet (`.CAB`) files. Each CAB file contains help files for the module in one UI
culture. Use the following procedure to create CAB files for Updatable Help.

1. Organize the help files for the module by UI culture. Each Updatable Help CAB file contains the
   help files for one module in one UI culture. You can deliver multiple help CAB files for the
   module, each for a different UI culture.

1. Verify that help files include only the file types permitted for Updatable Help and validate them
   against a help file schema. If the `Update-Help` cmdlet encounters a file that is invalid or is
   not a permitted type, it does not install the invalid file and stops installing files from the
   CAB. For a list of permitted file types, see
   [File Types Permitted in an Updatable Help CAB File](./file-types-permitted-in-an-updatable-help-cab-file.md).

1. Digitally sign the help files. Digital signatures are not required, but they are a best practice.

1. Include all of help files for the module in the UI culture, not only files that are new or have
   changed. If the CAB file is incomplete, users who download help files for the first time or do
   not download every update, will not have all of the module help files.

1. Use a utility that creates cabinet files, such as `MakeCab.exe`. PowerShell does not include
   cmdlets that create CAB files.

1. Name the CAB files. For more information, see
   [How to Name an Updatable Help CAB File](./how-to-name-an-updatable-help-cab-file.md).

1. Upload the CAB files for the module to the location that is specified by the **HelpContentUri**
   element in the HelpInfo XML file for the module. Then upload the HelpInfo XML file to the
   location that is specified by the **HelpInfoUri** key of the module manifest. The
   **HelpContentUri** and **HelpInfoUri** can point to the same location.

> [!CAUTION]
> The value of the **HelpInfoUri** key and the **HelpContentUri** element must begin with `http` or
> `https`. The value must indicate an Internet location and it must not include a filename.
