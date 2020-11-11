---
ms.date: 09/13/2016
ms.topic: reference
title: How to Create a Formatting File (.format.ps1xml)
description: How to Create a Formatting File (.format.ps1xml)
---
# How to Create a Formatting File (.format.ps1xml)

This topic describes how to create a formatting file (.format.ps1xml).

> [!NOTE]
> You can also create a formatting file by making a copy of one of the files provided by Windows PowerShell. If you make a copy of an existing file, delete the existing digital signature, and add your own signature to the new file.

### To create a .format.ps1xml file.

1. Create a text file (.txt) using a text editor such as Notepad.

2. Copy the following lines into the formatting file.

   ```xml
   <?xml version="1.0" encoding="utf-8" ?>
   <Configuration>
   <ViewDefinitions>
   </ViewDefinitions>
   </Configuration>
   ```

   - The `<Configuration></Configuration>` tags define the root `Configuration` node. All additional XML tags will be enclosed within this node.

   - The `<ViewDefinitions></ViewDefinitions>` tags define the `ViewDefinitions` node. All views are defined within this node.

3. Save the file to the Windows PowerShell installation folder, to your module folder, or to a subfolder of the module folder. Use the following name format when you save the file:  `MyFile.format.ps1xml`. Formatting files must use the `.format.ps1xml` extension.

   You are now ready to add views to the formatting file. There is no limit to the number of views that can be defined in a formatting file. You can add a single view for each object, multiple views for the same object, or a single view that is used by multiple objects.

## See Also

[Writing a Windows PowerShell Formatting and Types File](./writing-a-powershell-formatting-file.md)
