---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_CommonParameters
---

# About CommonParameters
## about_CommonParameters



# SHORT DESCRIPTION

Describes the parameters that can be used with any cmdlet.

# LONG DESCRIPTION

The common parameters are a set of cmdlet parameters that you can
use with any cmdlet. They are implemented by Windows PowerShell, not
by the cmdlet developer, and they are automatically available to any
cmdlet.

You can use the common parameters with any cmdlet, but they might
not have an effect on all cmdlets. For example, if a cmdlet does not
generate any verbose output, using the Verbose common parameter
has no effect.

The common parameters are also available on advanced functions that
use the CmdletBinding attribute or the Parameter attribute, and on
all workflows.

Several common parameters override system defaults or preferences
that you set by using the Windows PowerShell preference variables. Unlike
the preference variables, the common parameters affect only the commands
in which they are used.

In addition to the common parameters, many cmdlets offer the WhatIf and
Confirm risk mitigation parameters. Cmdlets that involve risk to the system
or to user data usually offer these parameters.

The following list displays the common parameters.
Their aliases are listed in parentheses.
* Debug (db)
* ErrorAction (ea)
* ErrorVariable (ev)
* InformationAction (infa)
* InformationVariable (iv)
* OutVariable (ov)
* OutBuffer (ob)
* PipelineVariable (pv)
* Verbose (vb)
* WarningAction (wa)
* WarningVariable (wv)

The risk mitigation parameters are:
* WhatIf (wi)
* Confirm (cf)

For more information about preference variables, type:
help about_Preference_Variables

# COMMON PARAMETER DESCRIPTIONS


-Debug[:{$true | $false}]
Alias: db

Displays programmer-level detail about the operation performed by the
command. This parameter works only when the command generates
a debugging message. For example, this parameter works when a command
contains the Write-Debug cmdlet.

The Debug parameter overrides the value of the $DebugPreference
variable for the current command, setting the value of $DebugPreference
to Inquire. Because the default value of the $DebugPreference variable
is SilentlyContinue, debugging messages are not displayed by default.

Valid values:

$true (-Debug:$true). Has the same effect as -Debug.

$false (-Debug:$false). Suppresses the display of debugging
messages when the value of the $DebugPreference is not
SilentlyContinue (the default).

-ErrorAction[:{Continue | Ignore | Inquire | SilentlyContinue | Stop |
Suspend }]
Alias: ea

Determines how the cmdlet responds to a non-terminating error
from the command. This parameter works only when the command generates
a non-terminating error, such as those from the Write-Error cmdlet.

The ErrorAction parameter overrides the value of the
$ErrorActionPreference variable for the current command.
Because the default value of the $ErrorActionPreference variable
is Continue, error messages are displayed and execution continues
unless you use the ErrorAction parameter.

The ErrorAction parameter has no effect on terminating errors (such as
missing data, parameters that are not valid, or insufficient
permissions) that prevent a command from completing successfully.

Valid values:

Continue. Displays the error message and continues executing
the command. "Continue" is the default value.

Ignore.  Suppresses the error message and continues
executing the command. Unlike SilentlyContinue, Ignore
does not add the error message to the $Error automatic
variable. The Ignore value is introduced in Windows
PowerShell 3.0.

Inquire. Displays the error message and prompts you for
confirmation before continuing execution. This value is rarely
used.

SilentlyContinue. Suppresses the error message and continues
executing the command.

Stop. Displays the error message and stops executing the
command.

Suspend. This value is only available in Windows PowerShell workflows.
When a workflow runs into terminating error, this action preference
automatically suspends the job to allow for further investigation. After
investigation, the workflow can be resumed.

-ErrorVariable [+]<variable-name>
Alias: ev

Stores error messages about the command in the specified variable
and in the $Error automatic variable. For more information,
type the following command:

get-help about_Automatic_Variables

By default, new error messages overwrite error messages that are
already stored in the variable. To append the error message to the
variable content, type  a plus sign (+) before the variable name.

For example, the following command creates the $a variable and then
stores any errors in it:

Get-Process -Id 6 -ErrorVariable a

The following command adds any error messages to the $a variable:

Get-Process -Id 2 -ErrorVariable +a

The following command displays the contents of $a:

$a

You can use this parameter to create a variable that contains only
error messages from specific commands. The $Error automatic
variable contains error messages from all the commands in the session.
You can use array notation, such as $a[0] or $error[1,2] to refer to
specific errors stored in the variables.

-InformationAction [:{SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend}]
Alias: ia

Introduced in Windows PowerShell 5.0. Within the command or script in which
it is used, the InformationAction common parameter overrides the value of the
$InformationPreference preference variable, which by default is set to
SilentlyContinue. When you use Write-Information in a script with -InformationAction,
Write-Information values are shown depending on the value of the -InformationAction
parameter. For more information about $InformationPreference, see
about_Preference_Variables.

Valid values:
Stop:               Stops a command or script at an occurrence of the
Write-Information command.

Ignore              Suppresses the informational message and continues
running the command. Unlike SilentlyContinue, Ignore
completely "forgets" the informational message; it does
not add the informational message to the information
stream.

Inquire:            Displays the informational message that you
specify in a Write-Information command, then
asks whether you want to continue.

Continue:           Displays the informational message, and continues
running.

Suspend:            Automatically suspends a workflow job after a
Write-Information command is carried out, to allow
users to see the messages before continuing.
The workflow can be resumed at the user’s
discretion.

SilentlyContinue:   No effect. The informational messages are not
(Default)           displayed, and the script continues without
interruption.

-InformationVariable [+]<variable-name>
Alias: iv

Introduced in Windows PowerShell 5.0. Within the command or script in which
it is used, the InformationVariable common parameter stores in a variable
a string that you specify by adding the Write-Information command. Write-Information
values are shown depending on the value of the -InformationAction
common parameter; if you do not add the -InformationAction common parameter,
Write-Information strings are shown depending on the value of the $InformationPreference
preference variable. For more information about $InformationPreference, see
about_Preference_Variables.

-OutBuffer <Int32>
Alias: ob

Determines the number of objects to accumulate in a buffer before
any objects are sent through the pipeline. If you omit this parameter,
objects are sent as they are generated.

This resource management parameter is designed for advanced users.
When you use this parameter, Windows PowerShell does not call the
next cmdlet in the pipeline until the number of objects generated
equals OutBuffer + 1. Thereafter, it sends all objects as they are
generated.

-OutVariable [+]<variable-name>
Alias: ov

Stores output objects from the command in the specified variable and
displays it at the command line.

To add the output to the variable, instead of replacing any output
that might already be stored there, type a plus sign (+) before the
variable name.

For example, the following command creates the $out variable and
stores the process object in it:

Get-Process PowerShell -OutVariable out

The following command adds the process object to the $out variable:

Get-Process iexplore -OutVariable +out

The following command displays the contents of the $out variable:

$out

-PipelineVariable <String>
Alias: pv

PipelineVariable stores the value of the current pipeline element
as a variable, for any named command as it flows through the pipeline.

Valid values are strings, the same as for any variable names.

The following is an example of how PipelineVariable works. In
this example, the PipelineVariable parameter is added to a
Foreach-Object command to store the results of the command
in variables. A range of numbers, 1 to 10, are piped into the first
Foreach-Object command, the results of which are stored in a
variable named Left.

The results of the first Foreach-Object command are piped into a
second Foreach-Object command, which filters the objects returned
by the first Foreach-Object command. The results of the second
command are stored in a variable named Right.

In the third Foreach-Object command, the results of the first two
Foreach-Object piped commands, represented by the variables Left
and Right, are processed by using a multiplication operator. The
command instructs objects stored in the Left and Right variables
to be multiplied, and specifies that the results should be
displayed as "Left range member * Right range member = product".

1..10 | Foreach-Object -PipelineVariable Left -Process { $_ } |
>>    Foreach-Object -PV Right -Process { 1..10 } |
>>    Foreach-Object -Process { "$Left$Right = " + ($Left$Right) }
# >>

# 1 * 1 = 1

# 1 * 2 = 2

# 1 * 3 = 3

# 1 * 4 = 4

# 1 * 5 = 5


-Verbose[:{$true | $false}]
Alias: vb

Displays detailed information about the operation performed by the
command. This information resembles the information in a trace or in
a transaction log. This parameter works only when the command generates
a verbose message. For example, this parameter works when a command
contains the Write-Verbose cmdlet.

The Verbose parameter overrides the value of the $VerbosePreference
variable for the current command. Because the default value of the
$VerbosePreference variable is SilentlyContinue, verbose messages
are not displayed by default.

Valid values:

$true (-Verbose:$true) has the same effect as -Verbose.

$false (-Verbose:$false) suppresses the display of verbose
messages. Use this parameter when the value of $VerbosePreference
is not SilentlyContinue (the default).

-WarningAction[:{Continue | Inquire | SilentlyContinue | Stop}]
Alias: wa

Determines how the cmdlet responds to a warning from the command.
"Continue" is the default value. This parameter works only
when the command generates a warning message. For example, this
parameter works when a command contains the Write-Warning cmdlet.

The WarningAction parameter overrides the value of the
$WarningPreference variable for the current command. Because the
default value of the $WarningPreference variable is Continue,
warnings are displayed and execution continues unless you use the
WarningAction parameter.

Valid Values:

Continue. Displays the warning message and continues executing
the command. "Continue" is the default value.

Inquire. Displays the warning message and prompts you for
confirmation before continuing execution. This value is rarely
used.

SilentlyContinue. Suppresses the warning message and continues
executing the command.

Stop. Displays the warning message and stops executing the
command.

NOTE: The WarningAction parameter does not override the value of
the $WarningAction preference variable when the parameter
is used in a command to run a script or function.

-WarningVariable [+]<variable-name>
Alias: wv

Stores warnings about the command in the specified variable.

All generated warnings are saved in the variable even if the
warnings are not displayed to the user.

To append the warnings to the variable content, instead of replacing
any warnings that might already be stored there, type a plus sign (+)
before the variable name.

For example, the following command creates the $a variable and then
stores any warnings in it:

Get-Process -Id 6 -WarningVariable a

The following command adds any warnings to the $a variable:

Get-Process -Id 2 -WarningVariable +a

The following command displays the contents of $a:

$a

You can use this parameter to create a variable that contains only
warnings from specific commands. You can use array notation, such as
$a[0] or $warning[1,2] to refer to specific warnings stored in the
variable.

NOTE: The WarningVariable parameter does not capture warnings from
nested calls in functions or scripts.

Risk Management Parameter Descriptions

-WhatIf[:{$true | $false}]
Alias: wi

Displays a message that describes the effect of the command,
instead of executing the command.

The WhatIf parameter overrides the value of the $WhatIfPreference
variable for the current command. Because the default value of the
$WhatIfPreference variable is 0 (disabled), WhatIf behavior is not
performed without the WhatIf parameter. For more information, type
the following command:

Get-Help about_Preference_Variables

Valid values:

$true (-WhatIf:$true). Has the same effect as -WhatIf.

$false (-WhatIf:$false). Suppresses the automatic WhatIf behavior
that results when the value of the $WhatIfPreference variable
is 1.

For example, the following command uses the WhatIf parameter in a
Remove-Item command:

PS> Remove-Item Date.csv -WhatIf

Instead of removing the item, Windows PowerShell lists the operations
it would perform and the items that would be affected. This command
produces the following output:

What if: Performing operation "Remove File" on
Target "C:\ps-test\date.csv".

-Confirm[:{$true | $false}]
Alias: cf

Prompts you for confirmation before executing the command.

The Confirm parameter overrides the value of the $ConfirmPreference
variable for the current command. The default value is High. For more
information, type the following command:

Get-Help about_Preference_Variables

Valid values:

$true (-Confirm:$true). Has the same effect as -Confirm.

$false(-Confirm:$false). Suppresses automatic confirmation,
which occurs when the value of $ConfirmPreference is less than
or equal to the estimated risk of the cmdlet.

For example, the following command uses the Confirm parameter with a
Remove-Item command. Before removing the item, Windows PowerShell
lists the operations it would perform and the items that would be
affected, and asks for approval.

PS C:\ps-test> Remove-Item tmp*.txt -Confirm

This command produces the following output:

Confirm
Are you sure you want to perform this action?
Performing operation "Remove File" on Target " C:\ps-test\tmp1.txt
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend
[?] Help (default is "Y"):

The Confirm response options are as follows:

Yes (Y)         Perform the action.
Yes to All (A)  Perform all actions and suppress subsequent
Confirm queries for this command.
No (N):         Do not perform the action.
No to All (L):  Do not perform any actions and suppress subsequent
Confirm queries for this command.
Suspend (S):    Pause the command and create a temporary session.
Help (?)        Display help for these options.

The Suspend option places the command on hold and creates a temporary nested
session in which you can work until you're ready to choose a Confirm option.
The command prompt for the nested session has two extra carets (>>) to indicate
that it's a child operation of the original parent command. You can run commands
and scripts in the nested session. To end the nested session and return to the
Confirm options for the original command, type "exit".

In the following example, the Suspend option (S) is used to halt a command
temporarily while the user checks the help for a command parameter. After
obtaining the needed information, the user types "exit" to end the nested prompt
and then selects the Yes (y) response to the Confirm query.

PS C:\ps-test> New-Item -ItemType File -Name Test.txt -Confirm

Confirm
Are you sure you want to perform this action?
Performing operation "Create File" on Target "Destination: C:\ps-test\test.txt".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): s

PS C:\ps-test>>> Get-Help New-Item -Parameter ItemType

-ItemType <string>
Specifies the provider-specified type of the new item.

Required?                    false
Position?                    named
Default value
Accept pipeline input?       true (ByPropertyName)
Accept wildcard characters?  false

PS C:\ps-test>>> exit

Confirm
Are you sure you want to perform this action?
Performing operation "Create File" on Target "Destination: C:\ps-test\test.txt".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y

Directory: C:\ps-test

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---         8/27/2010   2:41 PM          0 test.txt

# KEYWORDS

about_Common_Parameters

# SEE ALSO

[about_Preference_Variables](about_Preference_Variables.md)

Write-Debug

Write-Warning

Write-Error

Write-Verbose

