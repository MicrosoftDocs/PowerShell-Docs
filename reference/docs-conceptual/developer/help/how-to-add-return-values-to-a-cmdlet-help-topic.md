---
ms.date: 09/12/2016
ms.topic: reference
title: How to Add Return Values to a Cmdlet Help Topic
description: How to Add Return Values to a Cmdlet Help Topic
---
# How to Add Return Values to a Cmdlet Help Topic

This section describes how to add an OUTPUTS section to a PowerShell cmdlet Help topic. The
**OUTPUTS** section lists the .NET classes of objects that the cmdlet returns or passes down the
pipeline.

There is no limit to the number of classes that you can add to the **OUTPUTS** section. The return
types of a cmdlet are enclosed in a `<command:returnValues>` node, with each class enclosed in a
`<command:returnValue>` element.

If a cmdlet does not generate any output, use this section to indicate that there is no output. For
example, in place of the class name, write **None** and provide a brief explanation. If the cmdlet
generates output conditionally, use this node to explain the conditions and describe the conditional
output.

The schema includes two `<maml:description>` elements in each `<command:returnValue>` element.
However, the `Get-Help` cmdlet displays only the content of the
`<command:returnValue>/<maml:description>` element.

Beginning in PowerShell 3.0, the `Get-Help` cmdlet displays the content of the `<maml:uri>` element.
This element lets you direct users to topics that describe the .NET class.

The following XML shows the `<maml:returnValues>` node.

```xml
<command:returnValues>
  <command:returnValue>
    <dev:type>
      <maml:name> Class Name </maml:name>
      <maml:uri>  URI of a topic that describes the class </maml:uri>
      <maml:description/>
    </dev:type>
    <maml:description>
       <maml:para> Brief description <maml:para>

</maml:description>
  </command: returnValue>
</command: returnValues>
```

The following XML shows an example of using the `<maml:returnValues>` node to document an output
type.

```xml
<command:returnValues>
  <command:returnValue>
    <dev:type>
      <maml:name> System.DateTime </maml:name>
      <maml:uri>  https://docs.microsoft.com/dotnet/api/system.datetime </maml:uri>
      <maml:description/>
    </dev:type>
    <maml:description>
      <maml:para> Get-Date returns a DateTime object. <maml:para>
    </maml:description>
  </command: returnValue>
</command: returnValues>
```
