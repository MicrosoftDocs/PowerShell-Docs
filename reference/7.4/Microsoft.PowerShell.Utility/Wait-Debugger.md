---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 09/03/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/wait-debugger?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Wait-Debugger
---

# Wait-Debugger

## SYNOPSIS
Stops a script in the debugger before running the next statement in the script.

## SYNTAX

```
Wait-Debugger [<CommonParameters>]
```

## DESCRIPTION

Stops the PowerShell script execution engine at the point immediately after the `Wait-Debugger`
cmdlet and waits for a debugger to be attached.

> [!CAUTION]
> Make sure you remove the `Wait-Debugger` lines after you are done. A running script appears to be
> hung when it's stopped at a `Wait-Debugger`.

For more information about debugging in PowerShell, see
[about_Debuggers](/powershell/module/microsoft.powershell.core/about/about_debuggers).

## EXAMPLES

### Example 1: Insert breakpoint for debugging

The file `dbgtest.ps1` contains a function `Test-Condition`. The `Wait-Debugger` command was
inserted in the function to stop the script execution at that point. When you run the function, the
script stops at the `Wait-Debugger` line and enters the command-line debugger. The `l` command lists
the script lines, and you can use other debugger commands to inspect the script state.

```powershell
function Test-Condition {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Name,
        [string]$Message = "Hello, $Name!"
    )

    if ($Name -eq $env:USERNAME) {
        Write-Output "$Message"
    } else {
        # Remove after debugging
        Wait-Debugger

        Write-Output "$Name is not the current user."
    }
}
```

```
PS D:\> Test-Condition Fred
Entering debug mode. Use h or ? for help.

At D:\temp\test\dbgtest.ps1:13 char:9
+         Wait-Debugger
+         ~~~~~~~~~~~~~
[DBG]: PS D:\>> l

    8:
    9:      if ($Name -eq $env:USERNAME) {
   10:          Write-Output "$Message"
   11:      } else {
   12:          # Remove after debugging
   13:*         Wait-Debugger
   14:
   15:          Write-Output "$Name is not the current user."
   16:      }
   17:  }

[DBG]: PS D:\>> $env:USERNAME
User01
[DBG]: PS D:\>> exit
PS D:\>
```

Notice that output from the `l` shows that the script execution is stopped at the `Wait-Debugger` on
line 13.

### Example 2: Insert breakpoint for debugging a DSC resource

In this example, the `Wait-Debugger` command was inserted in the `CopyFile` method of a DSC
resource. This is similar to using `Enable-RunspaceDebug -BreakAll` in a DSC resource but breaks at
a specific point in the script.
```
[DscResource()]
class FileResource
{
    [DscProperty(Key)]
    [string] $Path

    [DscProperty(Mandatory)]
    [Ensure] $Ensure

    [DscProperty(Mandatory)]
    [string] $SourcePath

    [DscProperty(NotConfigurable)]
    [Nullable[datetime]] $CreationTime


    [void] Set() {
        $fileExists = $this.TestFilePath($this.Path)
        if ($this.ensure -eq [Ensure]::Present) {
            if (! $fileExists) {
               $this.CopyFile()
            }
        } else {
            if ($fileExists) {
                Write-Verbose -Message "Deleting the file $($this.Path)"
                Remove-Item -LiteralPath $this.Path -Force
            }
        }
    }

    [bool] Test() {
        $present = Test-Path -LiteralPath $this.Path
        if ($this.Ensure -eq [Ensure]::Present) {
            return $present
        } else {
            return (! $present)
        }
    }

    [FileResource] Get() {
        $present = Test-Path -Path $this.Path
        if ($present) {
            $file = Get-ChildItem -LiteralPath $this.Path
            $this.CreationTime = $file.CreationTime
            $this.Ensure = [Ensure]::Present
        } else {
            $this.CreationTime = $null
            $this.Ensure = [Ensure]::Absent
        }
        return $this
    }

    [void] CopyFile() {
        # Testing only - Remove before deployment!
        Wait-Debugger

        if (! (Test-Path -LiteralPath $this.SourcePath)) {
            throw "SourcePath $($this.SourcePath) is not found."
        }
        if (Test-Path -LiteralPath $this.Path -PathType Container) {
            throw "Path $($this.Path) is a directory path"
        }
        Write-Verbose "Copying $($this.SourcePath) to $($this.Path)"
        Copy-Item -LiteralPath $this.SourcePath -Destination $this.Path -Force
    }
}
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

## RELATED LINKS

[Enable-DscDebug](/powershell/module/PSDesiredStateConfiguration/Enable-DscDebug)

[about_Debuggers](/powershell/module/microsoft.powershell.core/about/about_debuggers)
