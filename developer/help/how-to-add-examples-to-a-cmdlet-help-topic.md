---
title: "How to Add Examples to a Cmdlet Help Topic | Microsoft Docs"
ms.custom: ""
ms.date: "09/12/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 8f723b21-8f95-4981-8b6e-4f07c22d601a
caps.latest.revision: 5
---
# How to Add Examples to a Cmdlet Help Topic
This section describes how to add examples to a Windows PowerShell® cmdlet Help topic.

 Topics in this section include the following:

-   [Things to Know about Examples in Cmdlet Help](#aboutcmdleexamples)

-   [Help Views that Display Examples](#viewexamples)

-   [Adding an Examples Node](#addexamplenode)

-   [Adding Preceding Characters](#addprecedingchareacters)

-   [Adding the Command](#addcommand)

-   [Adding a Description](#adddescription)

-   [Adding Example Output](#addoutput)

##  <a name="aboutcmdlethelp"></a> Things to Know about Examples in Cmdlet Help
 Examples might be the most important element of the cmdlet Help topic. Many users skip the narrative sections of the topic (the cmdlet name, synopsis, syntax, detailed description, and parameters) and read only the examples. For that reason, it is very important to provide a wide range of examples.

 The first example in the topic should be the simplest. It should show the effect of using the cmdlet with only its required parameters. Subsequent examples can be increasingly complex, with the final example including several commands in a pipeline.

 Whenever possible, show the use of all parameters in your set of examples. Users who cannot understand the parameter description can deduce the effect of the parameter and the construction of its values from the examples.

 The best examples are instructive, not clever. Do not use aliases, shortcuts, or customize the example for a very specific scenario. Here are some quidelines for creating instructive examples.

-   List all of the parameter names in the command, even when the parameter names are optional. This helps the user to interpret the command easily.

-   Avoid aliases and partial parameter names, even though they work in Windows PowerShell®.

-   In the example description, explain the rational for the construction of the command. Explain why you chose particular parameters and values, and how you use variables.

-   If the command uses expressions, explain them in detail.

-   If the command uses properties and methods of objects, especially properties that do not appear in the default display, use the example as an opportunity tell the user about the object.

##  <a name="viewexamples"></a> Help Views that Display Examples
 Examples appear only in the Detailed and Full views of cmdlet Help.

##  <a name="addexamplenode"></a> Adding an Examples Node
 The following XML shows how to add an Examples node that contains a single Example node. Add additional example nodes for each examples you want to include in the topic.

```
<command:examples>
  <command:example>
  </command:example>
</command:examples>
```

##  <a name="addtitle"></a> Adding an Example Title
 The following XML shows how to add a title for the example. The title is used to set the example apart from other examples. Windows PowerShell® uses a standard header that includes a sequential example number.

```
<command:examples>
  <command:example>
    <maml:title>----------  EXAMPLE 1  ----------</maml:title>
  </command:example>
</command:examples>
```

##  <a name="addprecedingcharacters"></a> Adding Preceding Characters
 The following XML shows how to add characters, such as the Windows PowerShell prompt, that are displayed immediately before the example command (without any intervening spaces). Windows PowerShell® uses the Windows PowerShell prompt: C:\PS>.

```
<command:examples>
  <command:example>
    <maml:title>----------  EXAMPLE 1  ----------</maml:title>
    <maml:Introduction>
      <maml:paragraph>C:PS></maml:paragraph>
    </maml:Introduction>
</command:example>
</command:examples>
```

##  <a name="addcommand"></a> Adding the Command
 The following XML shows how to add the actual command of the example. When adding the command, type the entire name (do not use alias) of cmdlets and parameters. Also, use lowercase characters whenever possible.

```
<command:examples>
  <command:example>
    <maml:title>----------  EXAMPLE 1  ----------</maml:title>
    <maml:Introduction>
      <maml:paragraph>C:PS></maml:paragraph>
    </maml:Introduction>
    <dev:code> command </dev:code>
</command:example>
</command:examples>
```

##  <a name="adddescription"></a> Adding a Description
 The following XML shows how to add a description for the example. Windows PowerShell® uses a single set of \<maml:para> tags for the description, even though multiple \<maml:para> tags can be used.

```
<command:examples>
  <command:example>
    <maml:title>----------  EXAMPLE 1  ----------</maml:title>
    <maml:Introduction>
      <maml:paragraph>C:PS></maml:paragraph>
    </maml:Introduction>
    <dev:code> command </dev:code>
    <dev:remarks>
      <maml:para> command description </maml:para>
    </dev:remarks>
</command:example>
</command:examples>
```

##  <a name="addoutput"></a> Adding Example Output
 The following XML shows how to add the output of the command. The command results information is optional, but in some cases it is helpful to demonstrate the effect of using specific parameters. Windows PowerShell® uses two sets of blank \<maml:para> tags to separate the command output from the command.

```
<command:examples>
  <command:example>
    <maml:title>----------  EXAMPLE 1  ----------</maml:title>
    <maml:Introduction>
      <maml:paragraph>C:PS></maml:paragraph>
    </maml:Introduction>
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
