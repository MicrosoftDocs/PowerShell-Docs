---
description: How to invoke a PSCmdlet from within a PSCmdlet
ms.date: 10/06/2022
ms.topic: reference
title: How to invoke a PSCmdlet from within a PSCmdlet
---
# How to invoke a PSCmdlet from within a PSCmdlet

This example shows how to invoke a **PSCmdlet** from within another **PSCmdlet**. In this example,
the new PSCmdlet `Get-ClipboardReverse` calls `Get-Clipboard` to get the contents of the clipboard.
The `Get-ClipboardReverse` reverses the order of the characters and returns the reversed string.

> [!NOTE]
> The **PSCmdlet** class differs from the **Cmdlet** class. **PSCmdlet** implementations use
> runspace context information so you must invoke another cmdlet using the PowerShell pipeline API.
> In **Cmdlet** implementations you can call the cmdlet's .NET API directly. For an example, see
> [How to invoke a Cmdlet from within a Cmdlet][03].

## To invoke a cmdlet from within a PSCmdlet

1. Ensure that the assembly that defines the cmdlet to be invoked is referenced and that the
   appropriate `using` statement is added. In this example, the following namespaces are added.

    ```csharp
    using System.Management.Automation;   // PowerShell assembly.
    using System.Text;
    ```

1. To invoke a **PSCmdlet** from within another **PSCmdlet** you must use the Pipeline API to
   construct a new pipeline and add the cmdlet to be invoked. Call the
   [System.Management.Automation.PowerShell.Invoke\<T>()][01] method to invoke the pipeline

    ```csharp
    var ps = PowerShell.Create();
    ps.AddCommand("Get-Clipboard").AddParameter("Raw");
    var output = ps.Invoke<string>();
    ```

## Example

In this example, the new `Get-ClipboardReverse` cmdlet is derived from the **PSCmdlet** class. To
call another cmdlet from within this class you must build a PowerShell pipeline with the command and
parameters you want to execute, then invoke the pipeline.

```csharp
using System;
using System.Management.Automation;   // PowerShell assembly.
using System.Text;

namespace ClipboardReverse
{
    [Cmdlet(VerbsCommon.Get,"ClipboardReverse")]
    [OutputType(typeof(string))]
    public class ClipboardReverse : PSCmdlet
    {
        protected override void EndProcessing()
        {
            var ps = PowerShell.Create();
            ps.AddCommand("Get-Clipboard").AddParameter("Raw");
            var output = ps.Invoke<string>();
            if (ps.HadErrors)
            {
                WriteError(new ErrorRecord(ps.Streams.Error[0].Exception,
                           "Get-Clipboard Error", ErrorCategory.NotSpecified, null));
            }
            else
            {
                var sb = new StringBuilder();
                foreach (var text in output)
                {
                    sb.Append(text);
                }

                var reversed = sb.ToString().ToCharArray();
                Array.Reverse(reversed);
                WriteObject(new string(reversed));
            }
        }
    }
}
```

## See Also

[Writing a Windows PowerShell Cmdlet][02]

<!-- link references -->
[01]: /dotnet/api/system.management.automation.powershell.invoke#system-management-automation-powershell-invoke-1
[02]: ./writing-a-windows-powershell-cmdlet.md
[03]: ./how-to-invoke-a-cmdlet-from-within-a-cmdlet.md
