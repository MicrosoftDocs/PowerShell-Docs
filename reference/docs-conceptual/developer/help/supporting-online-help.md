---
ms.date: 09/13/2016
ms.topic: reference
title: Supporting Online Help
description: Supporting Online Help
---
# Supporting Online Help

Beginning in PowerShell 3.0, there are two ways to support the `Get-Help` Online feature for
PowerShell commands. This topic explains how to implement this feature for different command types.

## About Online Help

Online help has always been a vital part of PowerShell. Although the `Get-Help` cmdlet displays help
topics at the command prompt, many users prefer the experience of reading online, including
color-coding, hyperlinks, and sharing ideas in Community Content and wiki-based documents. Most
importantly, before the advent of Updatable Help, online help provided the most up-to-date version
of the help files.

With the advent of Updatable Help in PowerShell 3.0, online help still plays a vital role. In
addition to the flexible user experience, online help provides help to users who do not or cannot
use Updatable Help to download help topics.

## How Get-Help -Online Works

To help users find the online help topics for commands, the `Get-Help` command has an Online
parameter that opens the online version of help topic for a command in the user's default internet
browser.

For example, the following command opens the online help topic for the `Invoke-Command` cmdlet.

```powershell
Get-Help Invoke-Command -Online
```

To implement `Get-Help -Online`, the `Get-Help` cmdlet looks for a Uniform Resource Identifier (URI)
for the online version help topic in the following locations.

- The first link in the **Related Links** section of the help topic for the command. The help topic
  must be installed on the user's computer. This feature was introduced in PowerShell 2.0.

- The **HelpUri** property of any command. The **HelpUri** property is accessible even when the help
  topic for the command is not installed on the user's computer. This feature was introduced in
  PowerShell 3.0.

  `Get-Help` looks for a URI in the first entry in the **Related Links** section before getting the
  **HelpUri** property value. If the property value is incorrect or has changed, you can override it
  by entering a different value in the first related link. However, the first related link works
  only when the help topics are installed on the user's computer.

## Adding a URI to the first related link of a command help topic

You can support `Get-Help -Online` for any command by adding a valid URI to the first entry in the
**Related Links** section of the XML-based help topic for the command. This option is valid only in
XML-based help topics and works only when the help topic is installed on the user's computer. When
the help topic is installed and the URI is populated, this value takes precedence over the
**HelpUri** property of the command.

To support this feature, the URI must appear in the `maml:uri` element under the first
`maml:relatedLinks/maml:navigationLink` element in the `maml:relatedLinks` element.

The following XML shows the correct placement of the URI. The `Online version:` text in the
`maml:linkText` element is a best practice, but it is not required.

```xml
<maml:relatedLinks>
    <maml:navigationLink>
        <maml:linkText>Online version:</maml:linkText>
        <maml:uri>https://go.microsoft.com/fwlink/?LinkID=113279</maml:uri>
    </maml:navigationLink>
    <maml:navigationLink>
        <maml:linkText>about_History</maml:linkText>
        <maml:uri/>
    </maml:navigationLink>
</maml:relatedLinks>
```

## Adding the HelpUri property to a command

This section shows how to add the HelpUri property to commands of different types.

### Adding a HelpUri Property to a Cmdlet

For cmdlets written in C#, add a **HelpUri** attribute to the **Cmdlet** class. The value of the
attribute must be a URI that begins with `http` or `https`.

The following code shows the **HelpUri** attribute of the `Get-History` cmdlet class.

```csharp
[Cmdlet(VerbsCommon.Get, "History", HelpUri = "https://go.microsoft.com/fwlink/?LinkID=001122")]
```

### Adding a HelpUri Property to an Advanced Function

For advanced functions, add a **HelpUri** property to the **CmdletBinding** attribute. The value of
the property must be a URI that begins with "http" or "https".

The following code shows the **HelpUri** attribute of the `New-Calendar` function

```powershell
function New-Calendar {
    [CmdletBinding(SupportsShouldProcess=$true,
    HelpURI="https://go.microsoft.com/fwlink/?LinkID=01122")]
```

### Adding a HelpUri Attribute to a CIM Command

For CIM commands, add a **HelpUri** attribute to the **CmdletMetadata** element in the CDXML file.
The value of the attribute must be a URI that begins with `http` or `https`.

The following code shows the HelpUri attribute of the `Start-Debug` CIM command

```xml
<CmdletMetadata Verb="Debug" HelpUri="https://go.microsoft.com/fwlink/?LinkID=001122"/>
```

### Adding a HelpUri Attribute to a Workflow

For workflows that are written in the PowerShell language, add an **.ExternalHelp** comment
directive to the workflow code. The value of the directive must be a URI that begins with `http` or
`https`.

> [!NOTE]
> The HelpUri property is not supported for XAML-based workflows in PowerShell.

The following code shows the .ExternalHelp directive in a workflow file.

```powershell
# .ExternalHelp "https://go.microsoft.com/fwlink/?LinkID=138338"
```
