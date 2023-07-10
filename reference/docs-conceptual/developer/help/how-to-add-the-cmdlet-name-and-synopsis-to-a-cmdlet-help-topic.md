---
description: How to add the cmdlet name and synopsis to a cmdlet help topic
ms.date: 07/10/2023
ms.topic: reference
title: How to add the cmdlet name and synopsis to a cmdlet help topic
---
# How to add the cmdlet name and synopsis to a cmdlet help topic

[!INCLUDE [use-platyps](../../../includes/use-platyps.md)]

This section describes how to add content that's displayed in the **NAME** and **SYNOPSIS** sections
of the cmdlet help. In the Help file, this content is added to the Command node for each cmdlet.

> [!NOTE]
> For a complete view of a Help file, open one of the `dll-Help.xml` files located in the PowerShell
> installation directory. For example, the `Microsoft.PowerShell.Commands.Management.dll-Help.xml`
> file contains content for several of the PowerShell cmdlets.

## To add the cmdlet name and a synopsis

- The cmdlet Help can display two descriptions for the cmdlet. The first description is a short
  description that's referred to as the synopsis. The second description is a more detailed
  description that's discussed in [Adding the Detailed Description to a Cmdlet Help Topic][02]. Both
  these descriptions should be written as a single paragraph.

- In the synopsis don't repeat the cmdlet name. Informing the user that the `Get-Server` cmdlet gets
  a server is brief, but not informative. Instead, use synonyms and add details to the description.

  Example: "Gets an object that represents a local or remote computer."

- Use simple verbs like "get", "create", and "change" in the synopsis. Avoid using "set" because it
  is vague, and fancy words such as "modify."

  Example: "Gets information about the Authenticode signature in a file."

- Write in active voice. For example, "Use the TimeSpan object..." is much clearer than "the
  TimeSpan object can be used to..."

- Avoid the verb "display" when describing cmdlets that get objects. Although Windows PowerShell
  displays cmdlet data, it's important to introduce users to the concept that the cmdlet returns
  .NET Framework objects whose data may not be displayed. If you emphasize the display, the user
  might not realize that the cmdlet may have returned many other useful properties and methods that
  aren't displayed.

## See also

[Windows PowerShell SDK][01]

<!-- link references -->
[01]: ../windows-powershell-reference.md
[02]: ./how-to-add-a-cmdlet-description.md
