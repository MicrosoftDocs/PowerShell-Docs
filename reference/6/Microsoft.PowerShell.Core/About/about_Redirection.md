---
ms.date:  12/01/2017
schema:  2.0.0
locale:  en-us
keywords: PowerShell,cmdlet
title:  about_Redirection
---

# About Redirection

## SHORT DESCRIPTION

Explains how to redirect output from PowerShell to text files.

## LONG DESCRIPTION

By default, PowerShell sends its command output to the PowerShell console.
However, you can direct the output to a text file, and you can redirect error
output to the regular output stream.

You can use the following methods to redirect output:

- Use the `Out-File` cmdlet, which sends command output to a text file.
  Typically, you use the `Out-File` cmdlet when you need to use its parameters,
  such as the **Encoding**, **Force**, **Width**, or **NoClobber** parameters.

- Use the Tee-Object cmdlet, which sends command output to a text file and
  then sends it to the pipeline.

- Use the PowerShell redirection operators.

### POWERSHELL REDIRECTION OPERATORS

The redirection operators enable you to send particular types of output to
files and to the success output stream.

The PowerShell redirection operators use the following characters to represent
each output type:

```
*   All output
1   Success output
2   Errors
3   Warning messages
4   Verbose output
5   Debug messages
```

NOTE: The All (\*), Warning (3), Verbose (4) and Debug (5) redirection
operators were introduced in PowerShell 3.0. They do not work in earlier
versions of PowerShell.

The PowerShell redirection operators are as follows.

```
Operator  Description               Example
--------  ----------------------    ------------------------------
>         Sends output to the       Get-Process > Process.txt
          specified file.

>>        Appends the output to     dir *.ps1 >> Scripts.txt
          the contents of the
          specified file.

2>        Sends errors to the       Get-Process none 2> Errors.txt
          specified file.

2>>       Appends errors to         Get-Process none 2>> Save-Errors.txt
          the contents of the
          specified file.

2>&1      Sends errors (2) and      Get-Process none, Powershell 2>&1
          success output (1)
          to the success
          output stream.

3>        Sends warnings to the     Write-Warning "Test!" 3> Warnings.txt
          specified file.

3>>       Appends warnings to       Write-Warning "Test!" 3>> Warnings.txt
          the contents of the
          specified file.

3>&1      Sends warnings (3) and    function Test-Warning
          success output (1)        {  Get-Process PowerShell;
          to the success               Write-Warning "Test!" }
          output stream.            Test-Warning 3>&1

4>        Sends verbose output to   Import-Module * -Verbose 4> Verbose.txt
          the specified file.

4>>       Appends verbose output    Import-Module * -Verbose 4>> Verbose.txt
          to the contents of the
          specified file.

4>&1      Sends verbose output (4)  Import-Module * -Verbose 4>&1
          and success output (1)
          to the success output
          stream.

5>        Sends debug messages to   Write-Debug "Starting" 5> Debug.txt
          the specified file.

5>>       Appends debug messages    Write-Debug "Saving" 5>> Debug.txt
          to the contents of the
          specified file.

5>&1      Sends debug messages (5)  function Test-Debug
          and success output (1)    { Get-Process PowerShell
          to the success output       Write-Debug "PS" }
          stream.                   Test-Debug 5>&1

*>        Sends all output types    function Test-Output
          to the specified file.    { Get-Process PowerShell, none
                                      Write-Warning "Test!"
*>>       Appends all output types    Write-Verbose "Test Verbose"
          to the contents of the      Write-Debug "Test Debug" }
          specified file.
                                    Test-Output *> Test-Output.txt
*>&1      Sends all output types    Test-Output *>> Test-Output.txt
          (*) to the success        Test-Output *>&1
          output stream.
```

The syntax of the redirection operators is as follows:

```
<input> <operator> [<path>\]<file>
```

If the specified file already exists, the redirection operators that do not
append data (> and n>) overwrite the current contents of the file without
warning. However, if the file is a read-only, hidden, or system file, the
redirection fails. The append redirection operators (>> and n>>) do not write
to a read-only file, but they append content to a system or hidden file.

To force the redirection of content to a read-only, hidden, or system file,
use the Out-File cmdlet with its Force parameter. When you are writing to
files, the redirection operators use Unicode encoding. If the file has a
different encoding, the output might not be formatted correctly. To redirect
content to non-Unicode files, use the Out-File cmdlet with its Encoding
parameter.

## SEE ALSO

Out-File

Tee-Object

[about_Operators](about_Operators.md)

[about_Command_Syntax](about_Command_Syntax.md)

[about_Path_Syntax](about_Path_Syntax.md)