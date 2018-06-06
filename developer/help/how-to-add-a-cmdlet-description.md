---
title: "How to Add a Cmdlet Description | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 47af9d57-bd63-4596-816a-0b717418476b
caps.latest.revision: 10
---
# How to Add a Cmdlet Description
This section describes how to add content that is displayed in the DESCRIPTION section of the cmdlet Help. In the Help file, this content is added to the Command node for each cmdlet.

> [!NOTE]
>  For a complete view of a Help file, open one of the dll-Help.xml files located in the Windows PowerShell installation directory. For example, the Microsoft.PowerShell.Commands.Management.dll-Help.xml file contains content for several of the Windows PowerShell cmdlets.

### To Add a Description

1.  Open the cmdlet Help file and locate the Command node for the cmdlet you are documenting. If you are adding a new cmdlet you will need to create a new Command node. Your Help file will contain a Command node for each cmdlet that you are providing Help content for. Here is an example of a blank Command node.

    ```
    <command:command>
    </command:command>
    ```

2.  Within the Command node, locate the Details node and add a Description node as shown below. Only one Details node is allowed, and it should immediately follow the Details node.

    ```
    <command:command>
      <command:details> </command:details>
      <maml:description>
      </maml:description>
    </command:command>
    ```

3.  Within the Description node, add a \<maml:para> tag that contains the description of the cmdlet.

     The description of the cmdlet consists of two or three full sentences within a single paragraph that briefly list everything that the cmdlet can do. It begins with "The \<cmdlet-name> cmdlet..." If the cmdlet can get multiple objects or take multiple inputs, use plural nouns in the description.

    ```
    <command:command>
      <command:details> </command:details>
      <maml:description>
        <maml:para>Cmdlet description...</maml:para>
      </maml:description>
    </command:command>
    ```

 Here are some things to remember about the detailed description of a cmdlet.

-   Begin by explaining the basic features of the cmdlet in more detail. In many cases, you can explain the terms used in the cmdlet name and illustrate unfamiliar concepts with an example. For example, if the cmdlet appends data to a file, explain that it adds data to the end of an existing file.

-   To find all of the features of the cmdlet, review the parameter list. Describe the primary function of the cmdlet, and then include other functions and features. For example, if the main function of the cmdlet is to change one property, but the cmdlet can change all of the properties, say so in the detailed description. If the cmdlet parameters let the users solicit information in different ways, explain it.

-   Include information on ways that users can use the cmdlet, in addition to the obvious uses. For example, you can use the object that the Get-Host cmdlet retrieves to change the color of text in the Windows PowerShell command window.

     Example:  "The Get-Acl cmdlet gets objects that represent the security descriptor of a file or resource. The security descriptor contains the access control lists (ACLs) of the resource. The ACL specifies the permissions that users and user groups have to access the resource."

-   The detailed description should describe the cmdlet, but it should not describe concepts that the cmdlet uses. Place concept definitions in Additional Notes.

## See Also
 [Windows PowerShell SDK](../windows-powershell-reference.md)
