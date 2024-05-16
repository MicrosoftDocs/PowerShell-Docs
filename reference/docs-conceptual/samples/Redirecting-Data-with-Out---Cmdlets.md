---
description: This article shows how to use the cmdlets that manage output in PowerShell.
ms.date: 12/08/2022
title: Redirecting output
---
# Redirecting output

PowerShell provides several cmdlets that let you control data output directly. These cmdlets share
two important characteristics.

First, they generally transform data to some form of text. They do this because they output the data
to system components that require text input. This means they need to represent the objects as text.
Therefore, the text is formatted as you see it in the PowerShell console window.

Second, these cmdlets use the PowerShell verb **Out** because they send information out from
PowerShell to somewhere else.

## Console output

By default, PowerShell sends data to the host window, which is exactly what the `Out-Host`
cmdlet does. The primary use for the `Out-Host` cmdlet is paging. For example, the following command
uses `Out-Host` to page the output of the `Get-Command` cmdlet:

```powershell
Get-Command | Out-Host -Paging
```

The host window display is outside of PowerShell. This is important because when data is sent out of
PowerShell, it's actually removed. You can see this if you try to create a pipeline that pages data
to the host window, and then attempt to format it as a list, as shown here:

```powershell
Get-Process | Out-Host -Paging | Format-List
```

You might expect the command to display pages of process information in list format. Instead, it
displays the default tabular list:

```output
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    101       5     1076       3316    32     0.05   2888 alg
...
    618      18    39348      51108   143   211.20    740 explorer
    257       8     9752      16828    79     3.02   2560 explorer
...
<SPACE> next page; <CR> next line; Q quit
...
```

The `Out-Host` cmdlet sends the data directly to the console, so the `Format-List` command never
receives anything to format.

The correct way to structure this command is to put the `Out-Host` cmdlet at the end of the pipeline
as shown below. This causes the process data to be formatted in a list before being paged and
displayed.

```powershell
Get-Process | Format-List | Out-Host -Paging
```

```Output
Id      : 2888
Handles : 101
CPU     : 0.046875
Name    : alg
...

Id      : 740
Handles : 612
CPU     : 211.703125
Name    : explorer

Id      : 2560
Handles : 257
CPU     : 3.015625
Name    : explorer
...
<SPACE> next page; <CR> next line; Q quit
...
```

This applies to all of the **Out** cmdlets. An **Out** cmdlet should always appear at the end of the
pipeline.

> [!NOTE]
> All the **Out** cmdlets render output as text, using the formatting in effect for the console
> window, including line length limits.

## Discarding output

The `Out-Null` cmdlet is designed to immediately discard any input it receives. This is useful for
discarding unnecessary data that you get as a side-effect of running a command. When type the
following command, you don't get anything back from the command:

```powershell
Get-Command | Out-Null
```

The `Out-Null` cmdlet doesn't discard error output. For example, if you enter the following command,
a message is displayed informing you that PowerShell doesn't recognize `Is-NotACommand`:

```
PS> Get-Command Is-NotACommand | Out-Null
Get-Command : 'Is-NotACommand' isn't recognized as a cmdlet, function, operable program, or script file.
At line:1 char:12
+ Get-Command  <<<< Is-NotACommand | Out-Null
```

## Printing data

> `Out-Printer` is only available on Windows platforms.

You can print data using the `Out-Printer` cmdlet. The `Out-Printer` cmdlet uses your default
printer if you don't provide a printer name. You can use any Windows-based printer by specifying its
display name. There is no need for any kind of printer port mapping or even a real physical printer.
For example, if you have the Microsoft Office document imaging tools installed, you can send the
data to an image file by typing:

```powershell
Get-Command -Name Get-* | Out-Printer -Name 'Microsoft Office Document Image Writer'
```

## Saving data

You can send output to a file instead of the console window using the `Out-File` cmdlet. The
following command line sends a list of processes to the file `C:\temp\processlist.txt`:

```powershell
Get-Process | Out-File -FilePath C:\temp\processlist.txt
```

The results of using the `Out-File` cmdlet may not be what you expect if you are used to traditional
output redirection. To understand its behavior, you must be aware of the context in which the
`Out-File` cmdlet operates.

On Window PowerShell 5.1, the `Out-File` cmdlet creates a Unicode file. Some tools, that expect
ASCII files, don't work correctly with the default output format. You can change the default output
format to ASCII using the **Encoding** parameter:

```powershell
Get-Process | Out-File -FilePath C:\temp\processlist.txt -Encoding ASCII
```

`Out-file` formats file contents to look like console output. This causes the output to be truncated
just as it's in a console window in most circumstances. For example, if you run the following
command:

```powershell
Get-Command | Out-File -FilePath c:\temp\output.txt
```

The output will look like this:

```output
CommandType     Name                            Definition
-----------     ----                            ----------
Cmdlet          Add-Content                     Add-Content [-Path] <String[...
Cmdlet          Add-History                     Add-History [[-InputObject] ...
...
```

To get output that doesn't force line wraps to match the screen width, you can use the **Width**
parameter to specify line width. Because **Width** is a 32-bit integer parameter, the maximum value
it can have is 2147483647. Type the following to set the line width to this maximum value:

```powershell
Get-Command | Out-File -FilePath c:\temp\output.txt -Width 2147483647
```

The `Out-File` cmdlet is most useful when you want to save output as it would have displayed on the
console.
