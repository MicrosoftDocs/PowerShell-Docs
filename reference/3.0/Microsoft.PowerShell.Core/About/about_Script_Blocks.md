---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Script_Blocks
---

# About Script Blocks

## SHORT DESCRIPTION

Defines what a script block is and explains how to use script blocks in
the Windows PowerShell programming language.

## LONG DESCRIPTION

In the Windows PowerShell programming language, a script block is a
collection of statements or expressions that can be used as a single unit.
A script block can accept arguments and return values.

Syntactically, a script block is a statement list in braces, as shown in
the following syntax:

```
{<statement list>}
```

A script block returns the output of all the commands in the script block,
either as a single object or as an array.

Like functions, a script block can include parameters. Use the Param
keyword to assign named parameters, as shown in the following syntax:

```
{
Param([type]$Parameter1 [,[type]$Parameter2])
<statement list>
}
```

In a script block, unlike a function, you cannot specify parameters outside
the braces.

Like functions, script blocks can include the DynamicParam, Begin, Process,
and End keywords. For more information, see [about_Functions](about_Functions.md)
and [about_Functions_Advanced](about_Functions_Advanced.md).

## Using Script Blocks

A script block is an instance of a Microsoft .NET Framework type
(System.Management.Automation.ScriptBlock). Commands can have script
block parameter values. For example, the `Invoke-Command` cmdlet has a
**ScriptBlock** parameter that takes a script block value, as shown in this
example:

```powershell
PS C:\> Invoke-Command -ScriptBlock { Get-Process }

Handles  NPM(K)    PM(K)     WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----     ----- -----   ------     -- -----------
999          28    39100     45020   262    15.88   1844 communicator
721          28    32696     36536   222    20.84   4028 explorer
. . .
```

The script block that is used as a value can be more complicated, as
shown in the following example:

```powershell
PS C:\> Invoke-Command -ScriptBlock { Param($uu = "Parameter");
"$uu assigned." }
Parameter assigned.
```

The script block in the preceding example uses the Param keyword to
create a parameter that has a default value. The following example uses
the **Args** parameter of the `Invoke-Command` cmdlet to assign a different
value to the parameter:

```powershell
PS C:\> Invoke-Command -ScriptBlock { Param($uu = "Parameter");
"$uu assigned."} -Args "Other value"
Other value assigned.
```

You can assign a script block to a variable, as shown in the following
example:

```powershell
$a = { Param($uu = "Parameter"); "$uu assigned." }
```

You can use the variable with a cmdlet such as `Invoke-Command`, as shown
in the following example:

```powershell
PS C:\> Invoke-Command -ScriptBlock $a -Args "Other value"
Other value assigned.
```

You can run a script block that is assigned to a variable by using the
call operator (&), as shown in the following example:

```powershell
PS C:\> & $a
Parameter assigned.
```

You can also provide a parameter to the script block, as shown in the
following example:

```powershell
PS C:\> & $a "Other value"
Other value assigned.
```

If you want to assign the value that is created by a script block to a
variable, use the call operator to run the script block directly, as
shown in the following example:

```powershell
PS C:\> $a = & { Param($uu = "Parameter"); "$uu assigned." }
PS C:\> $a
Parameter assigned.
```

For more information about the call operator, see [about_Operators](about_Operators.md).

## SEE ALSO

[about_Functions](about_Functions.md)

[about_Functions_Advanced](about_Functions_Advanced.md)

[about_Operators](about_Operators.md)

