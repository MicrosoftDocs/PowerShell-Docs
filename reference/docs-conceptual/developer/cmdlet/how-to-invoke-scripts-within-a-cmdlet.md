---
description: How to Invoke Scripts Within a Cmdlet
ms.date: 12/05/2023
ms.topic: reference
title: How to Invoke Scripts Within a Cmdlet
---
# How to Invoke Scripts Within a Cmdlet

This example shows how to invoke a script that is supplied to a cmdlet. The script is executed by
the cmdlet, and its results are returned to the cmdlet as a collection of
[System.Management.Automation.PSObject][02] objects.

## To invoke a script block

1. The command verifies that a script block was supplied to the cmdlet. If a script block was
   supplied, the command invokes the script block with its required parameters.

   ```csharp
   if (script != null)
   {
        WriteDebug("Executing script block.");

        // Invoke the script block with the required arguments.
        Collection<PSObject> PSObjects = script.Invoke(
            line,
            simpleMatch,
            caseSensitive
        );
       // more code as needed...
   }
   ```

1. Then, the script iterates through the returned collection of
   [System.Management.Automation.PSObject][02] objects and perform the necessary operations.

   ```csharp
   foreach (PSObject object in PSObjects)
   {
       if (LanguagePrimitives.IsTrue(object))
       {
            result = new MatchInfo();
            result.Line = line;
            result.IgnoreCase = !caseSensitive;
            break;
       }
   }
   ```

## See Also

[Writing a Windows PowerShell Cmdlet][01]

<!-- link references -->
[01]: ./writing-a-windows-powershell-cmdlet.md
[02]: /dotnet/api/System.Management.Automation.PSObject
