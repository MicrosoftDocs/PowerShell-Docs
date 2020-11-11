---
ms.date: 09/13/2016
ms.topic: reference
title: Writing Help for PowerShell Cmdlets
description: Writing Help for PowerShell Cmdlets
---
# Writing Help for PowerShell Cmdlets

PowerShell cmdlets can be useful, but unless your Help topics clearly explain what the cmdlet does
and how to use it, the cmdlet may not get used or, even worse, it might frustrate users. The
XML-based cmdlet Help file format enhances consistency, but great help requires much more.

If you have never written cmdlet Help, review the following guidelines. The XML schema required to
author the cmdlet Help topic is described in the following section. Start with
[Creating the Cmdlet Help File](./how-to-create-the-cmdlet-help-file.md). That topic includes a
description of the top-level XML nodes.

## Writing Guidelines for Cmdlet Help

### Write well

Nothing replaces a well-written topic. If you are not a professional writer, find a writer or editor
to help you. Another alternative is to copy your Help text into Microsoft Word and use the grammar
and spelling checks to improve your work.

### Write simply

Use simple words and phrases. Avoid jargon. Consider that many readers are equipped only with a
foreign-language dictionary and your Help topic.

### Write consistently

Help for related cmdlets should be similar (for example, get-x and set-x). Use the standard
descriptions for standard parameters, like **Force** and **InputObject**. (Copy them from Help for
the core cmdlets.) Use standard terms. For example, use "parameter", not "argument", and use
"cmdlet" not "command" or "command-let."

### Start the synopsis with a verb

The synopsis field informs the user what the cmdlet does, not what it is or how it works. Verbs
create a task-based statement that informs users if this cmdlet meets their requirements. Use simple
verbs like "get", "create", and "change." Avoid "set", which can be vague and fancy words like
"modify".

### Focus on objects

Most "get" cmdlets display something, but their primary function is to get an object. In your Help,
focus on the object, so that users understand that the default display is one of many, and that they
can use the methods and properties of the object that you retrieved for them in different ways.

### Write detailed descriptions

Briefly list everything that the cmdlet can do in the detailed description. If the main function is
to change one property, but the cmdlet can change all properties, list this in the detailed
description.

### Use conventional syntax

Use the standard Backus-Naur format which is common for Windows and UNIX command-line Help.

### Use Microsoft .NET types for parameter values

The placeholders for parameter values (in the syntax and parameter descriptions) show the .NET
Framework types of the objects that the parameter will accept. The PowerShell team developed this
convention to help teach users about the .NET Framework.

### Write complete parameter descriptions

Parameter descriptions must inform users of two things: what the parameter does (its effect) and
what they must type for the parameter values.

### Write practical examples

The examples should show how to use all of the parameters, but the most important thing is to show
how to use the cmdlet in real-world tasks. Start with a simple example and write increasingly
complex examples. In the final example, show how to use the cmdlet in a pipeline.

### Use the Notes field

Use the Notes field to explain concepts that users need to understand the cmdlet. You can also use
notes to help users avoid common errors. Avoid URLs as they change. Instead, provide users terms to
search for.

### Test your Help

Test the Help just like you test your code. Have friends and colleagues read your Help content and
provide feedback. You can also solicit feedback from newsgroups.

## See Also

 [How to Create the Cmdlet Help File](./how-to-create-the-cmdlet-help-file.md)

 [How to Add the Cmdlet Name and Synopsis to a Cmdlet Help Topic](./how-to-add-the-cmdlet-name-and-synopsis-to-a-cmdlet-help-topic.md)

 [How to Add the Detailed Description to a Cmdlet Help Topic](./how-to-add-a-cmdlet-description.md)

 [How to Add Syntax to a Cmdlet Help Topic](./how-to-add-syntax-to-a-cmdlet-help-topic.md)

 [How to Add Parameters to a Cmdlet Help Topic](./how-to-add-parameter-information.md)

 [How to add Input Types to a Cmdlet Help Topic](./how-to-add-input-types-to-a-cmdlet-help-topic.md)

 [How to Add Return Values to a Cmdlet Help Topic](./how-to-add-return-values-to-a-cmdlet-help-topic.md)

 [How to Add Notes to a Cmdlet Help Topic](./how-to-add-notes-to-a-cmdlet-help-topic.md)

 [How to Add Examples to a Cmdlet Help Topic](./how-to-add-examples-to-a-cmdlet-help-topic.md)

 [How to Add Related Links to a Cmdlet Help Topic](./how-to-add-related-links-to-a-cmdlet-help-topic.md)

 [Windows PowerShell SDK](../windows-powershell-reference.md)
