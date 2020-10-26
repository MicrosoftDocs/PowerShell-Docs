---
ms.date: 09/12/2016
ms.topic: reference
title: How to Add Parameter Information
description: How to Add Parameter Information
---
# How to Add Parameter Information

This section describes how to add content that is displayed in the **PARAMETERS** section of the
cmdlet Help topic. The **PARAMETERS** section of the Help topic lists each of the parameters of the
cmdlet and provides a detailed description of each parameter.

The content of the **PARAMETERS** section should be consistent with the content of the **SYNTAX**
section of the Help topic. It is the responsibility of the Help author to make sure that both the
**Syntax** and **Parameters** node contain similar XML elements.

> [!NOTE]
> For a complete view of a Help file, open one of the `dll-Help.xml` files located in the PowerShell
> installation directory. For example, the `Microsoft.PowerShell.Commands.Management.dll-Help.xml`
> file contains content for several of the PowerShell cmdlets.

### To Add Parameters

1. Open the cmdlet Help file and locate the Command node for the cmdlet you are documenting. If you
   are adding a new cmdlet you will need to create a new Command node. Your Help file will contain a
   Command node for each cmdlet that you are providing Help content for. Here is an example of a
   blank Command node.

    ```xml
    <command:command>
    </command:command>
    ```

1. Within the Command node, locate the Description node and add a Parameters node as shown below.
   Only one Parameters node is allowed, and it should immediately follow the Syntax node.

    ```xml
    <command:command>
      <command:details></command:details>
      <maml:description></maml:description>
      <command:syntax></command:syntax>
      <command:parameters>
      </command:Parameters>
    </command:command>
    ```

1. Within the Parameters node, add a **Parameter** node for each parameter of the cmdlet as shown below.

   In this example, a **Parameter** node is added for three parameters.

    ```xml
    <command:parameters>
      <command:parameter></command:parameter>
      <command:parameter></command:parameter>
      <command:parameter></command:parameter>
    </command:Parameters>
    ```

   Because these are the same XML tags that are used in the Syntax node, and because the parameters
   specified here must match the parameters specified by the Syntax node, you can copy the Parameter
   nodes from the Syntax node and paste them into the Parameters node. However, be sure to copy only
   one instance of a Parameter node, even if the parameter is specified in multiple parameter sets
   in the syntax.

1. For each Parameter node, set the attribute values that define the characteristics of each
   parameter. These attributes include the following: required, globbing, pipelineinput, and
   position.

    ```xml
    <command:parameters>
      <command:parameter required="true" globbing="true"
               pipelineInput="false" position="named">
      </command:parameter>
      <command:parameter required="false" globbing="false"
               pipelineInput="false" position="named">
      </command:parameter>
      <command:parameter required="false" globbing="false"
               pipelineInput="false" position="named" ></command:parameter>
    </command:Parameters>
    ```

1. For each Parameter node, add the name of the parameter. Here is an example of the parameter name
   added to the Parameter node.

    ```xml
    <command:parameters>
      <command:parameter required="true" globbing="true"
               pipelineInput="false" position="named">
        <maml:name> Add parameter name...  </maml:name>
      </command:parameter>
    </command:Parameters>
    ```

1. For each **Parameter** node, add the description of the parameter. Here is an example of the
   parameter description added to the **Parameter** node.

    ```xml
    <command:parameters>
      <command:parameter required="true" globbing="true"
               pipelineInput="false" position="named">
        <maml:name> Add parameter name...  </maml:name>
        <maml:description>
          <maml:para> Add parameter description... </maml:para>
        </maml:description>
      </command:parameter>
    </command:parameters>
    ```

1. For each **Parameter** node, add the .NET type of the parameter. The parameter type is displayed
   along with the parameter name.

   Here is an example of the parameter .NET type added to the **Parameter** node.

    ```xml
    <command:parameters>
      <command:parameter required="true" globbing="true"
               pipelineInput="false" position="named">
        <maml:name> Add parameter name...  </maml:name>
        <maml:description>
          <maml:para> Add parameter description... </maml:para>
        </maml:description>
        <dev:type> Add .NET Framework type... </dev:type>
      </command:parameter>
    </command:parameters>
    ```

1. For each **Parameter** node, add the default value of the parameter. The following sentence is added
   to the parameter description when the content is displayed: **DefaultValue** is the default.

   Here is an example of the parameter default value is added to the **Parameter** node.

    ```xml
    <command:parameters>
      <command:parameter required="true" globbing="true"
               pipelineInput="false" position="named">
        <maml:name> Add parameter name...  </maml:name>
        <maml:description>
          <maml:para> Add parameter description... </maml:para>
        </maml:description>
        <dev:type> Add .NET Framework type... </dev:type>
        <dev:defaultvalue> Add default value...</dev:defaultvalue>
      </command:parameter>
    </command:parameters>
    ```

1. For each Parameter that has multiple values, add a possible values node.

   Here is an example of the of a possible values node that defines two possible values for the
   parameter

    ```xml
    <dev:possiblevalues>
      <dev:possiblevalue>
        <dev:value>Unknown</dev:value>
        <maml:description>
          <maml:para></maml:para>
        </maml:description>
      </dev:possiblevalue>
      <dev:possiblevalue>
        <dev:value>String</dev:value>
        <maml:description>
          <maml:para></maml:para>
        </maml:description>
      </dev:possibleValue>
    </dev:possiblevalues>
    ```

Here are some things to remember when adding parameters.

- The attributes of the parameter are not displayed in all views of the cmdlet Help topic. However,
  they are displayed in a table following the parameter description when the user asks for the
  **Full** (`Get-Help <cmdletname> -full`) or **Parameter** (`Get-Help <cmdletname> -parameter`)
  view of the topic.

- The parameter description is one of the most important parts of a cmdlet Help topic. The
  description should be brief, as well as thorough. Also, remember that if the parameter description
  becomes too long, such as when two parameters interact with each other, you can add more content
  in the NOTES section of the cmdlet Help topic.

  The parameter description provides two types of information.

- What the cmdlet does when the parameter is used.

- What a legal value is for the parameter.

- Because the parameter values are expressed as .NET objects, users need more information about
  these values than they would in a traditional command-line Help. Tell the user what type of data
  the parameter is designed to accept, and include examples.

The default value of the parameter is the value that is used if the parameter is not specified on
the command line. Note that the default value is optional, and is not needed for some parameters,
such as required parameters. However, you should specify a default value for most optional
parameters.

The default value helps the user to understand the effect of not using the parameter. Describe the
default value very specifically, such as the "Current directory" or the "PowerShell installation
directory (`$PSHOME`)" for an optional path. You can also write a sentence that describes the
default, such as the following sentence used for the **PassThru** parameter: "If PassThru is not
specified, the cmdlet does not pass objects down the pipeline." Also, because the value is displayed
opposite the field name **Default value**, you do not need to include the term "default value" in
the entry.

The default value of the parameter is not displayed in all views of the cmdlet Help topic. However,
it is displayed in a table (along with the parameter attributes) following the parameter description
when the user asks for the **Full** (`Get-Help <cmdletname> -full`) or **Parameter** (`Get-Help
<cmdletname> -parameter`) view of the topic.

The following XML shows a pair of `<dev:defaultValue>` tags added to the `<command:parameter>` node.
Notice that the default value follows immediately after the closing `</command:parameterValue>` tag
(when the parameter value is specified) or the closing `</maml:description>` tag of the parameter
description. name.

```xml
<command:parameters>
  <command:parameter required="true" globbing="true"
           pipelineInput="false" position="named">
    <maml:name> Parameter name </maml:name>
    <maml:description>
      <maml:para> Parameter Description </maml:para>
    </maml:description>
    <command:parameterValue required="true">
      Value
    </command:parameterValue>
    <dev:defaultValue> Default parameter value </dev:defaultValue>
  </command:parameter>
</command:parameters>
```

Add Values for Enumerated Types

If the parameter has multiple values or values of an enumerated type, you can use an optional
\<dev:possibleValues> node. This node allows you to specify a name and description for multiple
values.

Be aware that the descriptions of the enumerated values do not appear in any of the default Help
views displayed by the `Get-Help` cmdlet, but other Help viewers may display this content in their
views.

The following XML shows a `<dev:possibleValues>` node with two values specified.

```xml
<command:parameters>
  <command:parameter required="true" globbing="true"
           pipelineInput="false" position="named">
    <maml:name> Parameter name </maml:name>
    <maml:description>
      <maml:para> Parameter Description </maml:para>
    </maml:description>
    <command:parameterValue required="true">
      Value
    </command:parameterValue>
    <dev:defaultValue> Default parameter value </dev:defaultValue>
    <dev:possibleValues>
      <dev:possibleValue>
        <dev:value> Value 1 </dev:value>
        <maml:description>
          <maml:para> Description 1 </maml:para>
        </maml:description>
      <dev:possibleValue>
      <dev:possibleValue>
        <dev:value> Value 2 </dev:value>
        <maml:description>
          <maml:para> Description 2 </maml:para>
        </maml:description>
      <dev:possibleValue>
    </dev:possibleValues>
  </command:parameter>
</command:parameters>
```
