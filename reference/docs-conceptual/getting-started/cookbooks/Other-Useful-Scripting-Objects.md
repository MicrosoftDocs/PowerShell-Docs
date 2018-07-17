---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Other Useful Scripting Objects
ms.assetid:  4d781196-720b-4ccc-90d2-c570e5e719f5
---
# Other Useful Scripting Objects

The following objects provide additional scripting functionality in Windows PowerShell ISE. They
are not part of the **$psISE** hierarchy.

## Useful Scripting objects

### $psUnsupportedConsoleApplications

There are some limitations on how Windows PowerShell ISE interacts with console applications. A
command or an automation script that requires user intervention might not work the way it works
from the Windows PowerShell console. You might want to block these commands or scripts from running
in the Windows PowerShell ISE Command pane. The **$psUnsupportedConsoleApplications** object keeps
a list of such commands. If you try to run the commands in this list, you get a message that they
are not supported. The following script adds an entry to the list.

```powershell
# List the unsupported commands
$psUnsupportedConsoleApplications

# Add a command to this list
$psUnsupportedConsoleApplications.Add('Mycommand')

# Show the augmented list of commands
$psUnsupportedConsoleApplications
```

### $psLocalHelp

This is a dictionary object that maintains a context-sensitive mapping between Help topics and
their associated links in the local compiled HTML Help file. It is used to locate the local Help
for a particular topic. You can add or delete topics from this list. The following code example
shows some example key-value pairs that are contained in `$psLocalHelp`.

```powershell
# See the local help map
$psLocalHelp | Format-List
```

```output
Key   : Add-Computer
Value : WindowsPowerShellHelp.chm::/html/093f660c-b8d5-43cf-aa0c-54e5e54e76f9.htm

Key   : Add-Content
Value : WindowsPowerShellHelp.chm::/html/0c836a1b-f389-4e9a-9325-0f415686d194.htm
```

The following script adds an entry to the list.

```powershell
$psLocalHelp.Add("get-myNoun", "c:\MyFolder\MyHelpChm.chm::/html/0198854a-1298-57ae-aa0c-87b5e5a84712.htm")
```

### $psOnlineHelp

This is a dictionary object that maintains a context-sensitive mapping between topic titles of Help
topics and their associated external URLs. It is used to locate the Help for a particular topic on
the web. You can add or delete topics from this list.

```powershell
$psOnlineHelp | Format-List
```

```output
Key   : Add-Computer
Value : http://go.microsoft.com/fwlink/p/?LinkID=135194

Key   : Add-Content
Value : http://go.microsoft.com/fwlink/p/?LinkID=113278
```

The following script adds an entry to the list.

```powershell
$psOnlineHelp.Add("get-myNoun", "http://www.mydomain.com/MyNoun.html")
```

## See Also

[Purpose of the Windows PowerShell ISE Scripting Object Model](../../core-powershell/ise/Purpose-of-the-Windows-PowerShell-ISE-Scripting-Object-Model.md)