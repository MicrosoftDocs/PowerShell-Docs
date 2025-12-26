---
description: How to Create a Formatting File (Format.ps1xml)
ms.date: 12/26/2025
title: How to Create a Formatting File (Format.ps1xml)
---
# How to Create a Formatting File (Format.ps1xml)

This topic describes how to create a formatting file (`Format.ps1xml`).

> [!NOTE]
> You can also create a formatting file by making a copy of one of the files provided by Windows
> PowerShell. To protect the users of your `Format.ps1xml` file, sign the file using a digital
> signature. For more information, see [about_Signing][01].

## Create a Format.ps1xml file

1. Open a new text file using a text editor such as Visual Studio Code.

1. Copy the following lines into the formatting file.

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <Configuration>
   <ViewDefinitions>
   </ViewDefinitions>
   </Configuration>
   ```

   - The `<Configuration></Configuration>` tags define the root `Configuration` node. All additional
     XML tags will be enclosed within this node.

   - The `<ViewDefinitions></ViewDefinitions>` tags define the `ViewDefinitions` node. All views are
     defined within this node.

1. Save the file to a folder of your choice. If you are writing a module, save the file to a
   subfolder of the module folder. Use the following name format when you save the file:
   `MyFile.Format.ps1xml`. Formatting files must use the `.ps1xml` extension.

   You are now ready to add views to the formatting file. There is no limit to the number of views
   that can be defined in a formatting file. You can add a single view for each object, multiple
   views for the same object, or a single view that is used by multiple objects.

## See also

- [Writing a Windows PowerShell Formatting and Types File][02]

<!-- link references -->
[01]: /powershell/module/microsoft.powershell.core/about/about_signing.md
[02]: (./writing-a-powershell-formatting-file.md)
