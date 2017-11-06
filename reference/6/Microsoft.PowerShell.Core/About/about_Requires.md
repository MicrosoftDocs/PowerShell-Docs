---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Requires
---

# About Requires
## about_Requires


## SHORT DESCRIPTION
Prevents a script from running without the required elements.


## LONG DESCRIPTION
The \#Requires statement prevents a script from running unless the  Windows PowerShell version, modules, snap-ins, and module and snap-in version prerequisites are met. If the prerequisites are not met,  Windows PowerShell does not run the script.

You can use \#Requires statements in any script. You cannot use them in functions, cmdlets, or snap-ins.


### SYNTAX


```
#Requires -Version <N>[.<n>]   
#Requires -PSSnapin <PSSnapin-Name> [-Version <N>[.<n>]]  
#Requires -Modules { <Module-Name> | <Hashtable> }   
#Requires -ShellId <ShellId>  
#Requires -RunAsAdministrator
```



### RULES FOR USE
- The \#Requires statement must be the first item on a line in a script.

- A script can include more than one \#Requires statement.

- The \#Requires statements can appear on any line in a script.


### PARAMETERS
-Version <N>[.<n>]

Specifies the minimum version of  Windows PowerShell that the script requires. Enter a major version number and optional minor version number.

For example:


```
#Requires -Version 3.0
```


-PSSnapin <PSSnapin-Name> [-Version <N>[.<n>]]

Specifies a  Windows PowerShell snap-in that the script requires. Enter the snap-in name and an optional version number.

For example:


```
#Requires -PSSnapin DiskSnapin -Version 1.2
```


-Modules <Module-Name> &#124; <Hashtable>

Specifies  Windows PowerShell modules that the script requires. Enter the module name and an optional version number. The Modules parameter is introduced in  Windows PowerShell 3.0.

If the required modules are not in the current session,  Windows PowerShell imports them. If the modules cannot be imported,  Windows PowerShell throws a terminating error.

For each module, type the module name (<String>) or a hash table with the following keys. The value can be a combination of strings and hash tables.


```
-- ModuleName. This key is required.  
-- ModuleVersion. This key is required.  
-- GUID. This key is optional.
```


For example,


```
#Requires -Modules PSWorkflow, @{ModuleName="PSScheduledJob";ModuleVersion="1.0.0.0"}
```


-ShellId

Specifies the shell that the script requires. Enter the shell ID.

For example,


```
#Requires -ShellId MyLocalShell
```


-RunAsAdministrator

When this switch parameter is added to your requires statement, it specifies that the  Windows PowerShell session in which you are running the script must be started with elevated user rights (Run as Administrator). This switch was introduced in PowerShell 4.

For example,


```
#Requires -RunAsAdministrator
```



### EXAMPLES
The following script has two \#Requires statements. If the requirements specified in both statements are not met, the script does not run. Each \#Requires statement must be the first item on a line:


```
#Requires -Modules PSWorkflow  
#Requires -Version 3  
Param  
(  
    [parameter(Mandatory=$true)]  
    [String[]]  
    $Path  
)  
...
```



### NOTES
In  Windows PowerShell 3.0, the  Windows PowerShell Core packages appear as modules in sessions started by using the InitialSessionState.CreateDefault2 method, such as sessions started in the  Windows PowerShell console. Otherwise, they appear as snap-ins. The exception is Microsoft.PowerShell.Core, which is always a snap-in.


## SEE ALSO

[about_Automatic_Variables](about_Automatic_Variables.md)

[about_Language_Keywords](about_Language_Keywords.md)

[about_PSSnapins](about_PSSnapins.md)

Get-PSSnapin

