---
title: "How to Add the Cmdlet Name and Synopsis to a Cmdlet Help Topic | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 1d0e1eb1-a962-4406-9625-175cfa3364ad
caps.latest.revision: 10
---
# How to Add the Cmdlet Name and Synopsis to a Cmdlet Help Topic
This section describes how to add content that is displayed in the NAME and SYNOPSIS sections of the cmdlet help. In the Help file, this content is added to the Command node for each cmdlet.

> [!NOTE]
>  For a complete view of a Help file, open one of the dll-Help.xml files located in the Windows PowerShell installation directory. For example, the Microsoft.PowerShell.Commands.Management.dll-Help.xml file contains content for several of the Windows PowerShell cmdlets.

### To Add the Cmdlet Name and a Synopsis

1.  Open the cmdlet Help file and locate the Command node for the cmdlet you are documenting. If you are adding a new cmdlet you will need to create a new Command node. Your Help file will contain a Command node for each cmdlet that you are providing Help content for.

     Here is an example of a blank Command node.

    ```
    <command:command>
    </command:command>
    ```

2.  Within the Command node add a Details node.

    ```
    <command:command>
      <command:details>
      <command:details>
    </command:command>
    ```

3.  Within the Details node add the full name of the cmdlet, the cmdlet verb, and the cmdlet noun. A cmdlet name consists of a verb and a noun joined by a hyphen (-). The verb describes the action that the cmdlet performs. The noun describes the resource on which the action is performed. The cmdlet name appears in all default views of cmdlet Help. Here is an example of the Details node.

    ```
    <command:command>
      <command:details>
        <command:name>CmdletName</command:name>
        <command:verb>Verb</command:verb>
        <command:noun>Noun</command:noun>
      <command:details>
    </command:command>
    ```

4.  Add a Description node that contains the synopsis (or short description) of the cmdlet.

     The synopsis of the cmdlet is a very brief description of the cmdlet. It begins with a verb, and informs the user as to what the cmdlet does. It does not include the cmdlet name or how the cmdlet works. The cmdlet synopsis appears in the SYNOPSIS field of all views of cmdlet Help.

     Here is an example of a Details node that contains the Description node. Although the Details node allows multiple paragraphs, it is strongly suggested that the synopsis be limited to a single paragraph.

    ```
    <command:details>
      <command:name>CmdletName</command:name>
      <command:verb>Verb</command:verb>
      <command:noun>Noun</command:noun>
      <maml:description>
        <maml:para>CmdletSynopsis</maml:para>
      <maml:description>
    </command:details>
    ```

 Here are some things to remember when adding the synopsis of a cmdlet.

-   The cmdlet Help can display two descriptions for the cmdlet. The first description is a short description that is referred to as the synopsis. The second description is a more detailed description that is discussed in [Adding the Detailed Description to a Cmdlet Help Topic](./how-to-add-a-cmdlet-description.md). Both these descriptions should be written as a single paragraph.

-   In the synopsis do not repeat the cmdlet name. Informing the user that the Get-Server cmdlet gets a server is brief, but not informative. Instead, use synonyms and add details to the description.

     Example: "Gets an object that represents a local or remote computer."

-   Use simple verbs like "get", "create", and "change" in the synopsis. Avoid using "set" because it is vague, and fancy words such as "modify."

     Example: "Gets information about the Authenticode signature in a file."

-   Write in active voice. For example, "Use the TimeSpan object..." is much clearer than "the TimeSpan object can be used to..."

-   Avoid the verb "display" when describing cmdlets that get objects. Although Windows PowerShell displays cmdlet data, it is important to introduce users to the concept that the cmdlet returns .NET Framework objects whose data may not be displayed. If you emphasize the display, the user might not realize that the cmdlet may have returned many other useful properties and methods that are not displayed.

## See Also
 [Windows PowerShell SDK](../windows-powershell-reference.md)
