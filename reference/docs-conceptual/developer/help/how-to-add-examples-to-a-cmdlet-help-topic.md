---
description: How to add examples to a cmdlet help topic
ms.date: 07/10/2023
ms.topic: reference
title: How to add examples to a cmdlet help topic
---
# How to add examples to a cmdlet help topic

[!INCLUDE [use-platyps](../../../includes/use-platyps.md)]

## Things to know about examples in cmdlet help

- List all of the parameter names in the command, even when the parameter names are optional. This
  helps the user to interpret the command easily.

- Avoid aliases and partial parameter names, even though they work in PowerShell.

- In the example description, explain the rational for the construction of the command. Explain why
  you chose particular parameters and values, and how you use variables.

- If the command uses expressions, explain them in detail.

- If the command uses properties and methods of objects, especially properties that don't appear in
  the default display, use the example as an opportunity tell the user about the object.

## Help Views that Display Examples

Examples appear only in the Detailed and Full views of cmdlet Help.

## Adding an examples node

The following XML shows how to add an **Examples** node that contains a single **Example** node. Add
additional example nodes for each examples you want to include in the topic.

```xml
<command:examples>
  <command:example>
  </command:example>
</command:examples>
```

## Adding an example title

The following XML shows how to add a **title** for the example. The **title** is used to set the
example apart from other examples. PowerShell uses a standard header that includes a sequential
example number.

```xml
<command:examples>
  <command:example>
    <maml:title>----------  EXAMPLE 1  ----------</maml:title>
  </command:example>
</command:examples>
```

## Adding preceding characters

The following XML shows how to add characters, such as the Windows PowerShell prompt, that are
displayed immediately before the example command (without any intervening spaces). PowerShell uses
the Windows PowerShell prompt: `C:\PS>`.

```xml
<command:examples>
  <command:example>
    <maml:title>----------  EXAMPLE 1  ----------</maml:title>
    <maml:introduction>
      <maml:para>C:\PS></maml:para>
    </maml:introduction>
</command:example>
</command:examples>
```

## Adding the command

The following XML shows how to add the actual command of the example. When adding the command, type
the entire name (do not use alias) of cmdlets and parameters. Also, use lowercase characters
whenever possible.

```xml
<command:examples>
  <command:example>
    <maml:title>----------  EXAMPLE 1  ----------</maml:title>
    <maml:introduction>
      <maml:para>C:\PS></maml:para>
    </maml:introduction>
    <dev:code> command </dev:code>
</command:example>
</command:examples>
```

## Adding a Description

The following XML shows how to add a description for the example. PowerShell uses a single set of
`<maml:para>` tags for the description, even though multiple `<maml:para>` tags can be used.

```xml
<command:examples>
  <command:example>
    <maml:title>----------  EXAMPLE 1  ----------</maml:title>
    <maml:introduction>
      <maml:para>C:\PS></maml:para>
    </maml:introduction>
    <dev:code> command </dev:code>
    <dev:remarks>
      <maml:para> command description </maml:para>
    </dev:remarks>
</command:example>
</command:examples>
```

## Adding example output

The following XML shows how to add the output of the command. The command results information is
optional, but in some cases it's helpful to demonstrate the effect of using specific parameters.
PowerShell uses two sets of blank `<maml:para>` tags to separate the command output from the
command.

```xml
<command:examples>
  <command:example>
    <maml:title>----------  EXAMPLE 1  ----------</maml:title>
    <maml:introduction>
      <maml:para>C:\PS></maml:para>
    </maml:introduction>
    <dev:code> command </dev:code>
    <dev:remarks>
      <maml:para> command description </maml:para>
      <maml:para></maml:para>
      <maml:para></maml:para>
      <maml:para> command output </maml:para>
</dev:remarks>
</command:example>
</command:examples>
```
