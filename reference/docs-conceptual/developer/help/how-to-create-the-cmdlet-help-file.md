---
ms.date: 09/13/2016
ms.topic: reference
title: How to Create the Cmdlet Help File
description: How to Create the Cmdlet Help File
---
# How to Create the Cmdlet Help File

This section describes how to create a valid XML file that contains content for Windows PowerShell
cmdlet Help topics. This section discusses how to name the Help file, how to add the appropriate XML
headers, and how to add nodes that will contain the different sections of the cmdlet Help content.

> [!NOTE]
> For a complete view of a Help file, open one of the `dll-Help.xml` files located in the Windows
> PowerShell installation directory. For example, the
> `Microsoft.PowerShell.Commands.Management.dll-Help.xml` file contains content for several of the
> PowerShell cmdlets.

### How to Create a Cmdlet Help File

1. Create a text file and save it using UTF8 encoding. The filename must have the following format
   so that Windows PowerShell can detect it as a cmdlet Help file.

   `<PSSnapInAssemblyName>.dll-Help.xml`

1. Add the following XML headers to the text file. Be aware that the file will be validated against
   the Microsoft Assistance Markup Language (MAML) schema. Currently, PowerShell does not provide
   any tools to validate the file.

   `<?xml version="1.0" encoding="utf-8" ?> <helpItems xmlns="http://msh" schema="maml">`

1. Add a **Command** node to the cmdlet Help file for each cmdlet in the assembly. Each node within the
   **Command** node relates to the different sections of the cmdlet Help topic.

   The following table lists the XML element for each node, followed by a descriptions of each node.

   |           Node           |                                                                                                     Description                                                                                                     |
   | ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
   | `<details>`              | Adds content for the NAME and SYNOPSIS sections of the cmdlet Help topic. For more information, see [How to Add the Cmdlet Name and Synopsis](./how-to-add-the-cmdlet-name-and-synopsis-to-a-cmdlet-help-topic.md). |
   | `<maml:description>`     | Adds content for the DESCRIPTION section of the cmdlet Help topic. For more information, see [How to Add the Detailed Description to a Cmdlet Help Topic](./how-to-add-a-cmdlet-description.md).                    |
   | `<command:syntax>`       | Adds content for the SYNTAX section of the cmdlet Help topic. For more information, see [How to Add Syntax to a Cmdlet Help Topic](./how-to-add-syntax-to-a-cmdlet-help-topic.md).                                  |
   | `<command:parameters>`   | Adds content for the PARAMETERS section of the cmdlet Help topic. For more information, see [How to Add Parameters to a Cmdlet Help Topic](./how-to-add-parameter-information.md).                                  |
   | `<command:inputTypes>`   | Adds content for the INPUTS section of the cmdlet Help topic. For more information, see [How to Add Input Types to a Cmdlet Help Topic](./how-to-add-input-types-to-a-cmdlet-help-topic.md).                        |
   | `<command:returnValues>` | Adds content for the OUTPUTS section of the cmdlet Help topic. For more information, see [How to Add Return Values to a Cmdlet Help Topic](./how-to-add-return-values-to-a-cmdlet-help-topic.md).                   |
   | `<maml:alertset>`        | Adds content for the NOTES section of the cmdlet Help topic. For more information, see [How to add Notes to a Cmdlet Help Topic](./how-to-add-notes-to-a-cmdlet-help-topic.md).                                      |
   | `<command:examples>`     | Adds content for the EXAMPLES section of the cmdlet Help topic. For more information, see [How to Add Examples to a Cmdlet Help Topic](./how-to-add-examples-to-a-cmdlet-help-topic.md).                            |
   | `<maml:relatedLinks>`    | Adds content for the RELATED LINKS section of the cmdlet Help topic. For more information, see [How to Add Related Links to a Cmdlet Help Topic](./how-to-add-related-links-to-a-cmdlet-help-topic.md).             |

## Example

 Here is an example of a **Command** node that includes the nodes for the various sections of the
 cmdlet Help topic.

```xml
<command:command
  xmlns:maml="http://schemas.microsoft.com/maml/2004/10"
  xmlns:command="http://schemas.microsoft.com/maml/dev/command/2004/10"
  xmlns:dev="http://schemas.microsoft.com/maml/dev/2004/10">
  <command:details>
    <!--Add name an synopsis here-->
  </command:details>
  <maml:description>
    <!--Add detailed description here-->
  </maml:description>
  <command:syntax>
    <!--Add syntax information here-->
  </command:syntax>
  <command:parameters>
    <!--Add parameter information here-->
  </command:parameters>
  <command:inputTypes>
    <!--Add input type information here-->
  </command:inputTypes>
  <command:returnValues>
    <!--Add return value information here-->
  </command:returnValues>
  <maml:alertSet>
    <!--Add Note information here-->
  </maml:alertSet>
  <command:examples>
    <!--Add cmdlet examples here-->
  </command:examples>
  <maml:relatedLinks>
    <!--Add links to related content here-->
  </maml:relatedLinks>
</command:command>
```

## See Also

 [How to Add the Cmdlet Name and Synopsis](./how-to-add-the-cmdlet-name-and-synopsis-to-a-cmdlet-help-topic.md)

 [How to Add the Detailed Description to a Cmdlet Help Topic](./how-to-add-a-cmdlet-description.md)

 [How to Add Syntax to a Cmdlet Help Topic](./how-to-add-syntax-to-a-cmdlet-help-topic.md)

 [How to Add Parameters to a Cmdlet Help Topic](./how-to-add-parameter-information.md)

 [How to Add Input Types to a Cmdlet Help Topic](./how-to-add-input-types-to-a-cmdlet-help-topic.md)

 [How to Add Return Values to a Cmdlet Help Topic](./how-to-add-return-values-to-a-cmdlet-help-topic.md)

 [How to add Notes to a Cmdlet Help Topic](./how-to-add-notes-to-a-cmdlet-help-topic.md)

 [How to Add Examples to a Cmdlet Help Topic](./how-to-add-examples-to-a-cmdlet-help-topic.md)

 [How to Add Related Links to a Cmdlet Help Topic](./how-to-add-related-links-to-a-cmdlet-help-topic.md)

 [Windows PowerShell SDK](../windows-powershell-reference.md)
