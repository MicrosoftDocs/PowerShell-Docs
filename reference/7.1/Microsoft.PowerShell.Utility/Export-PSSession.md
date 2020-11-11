---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/23/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/export-pssession?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Export-PSSession
---

# Export-PSSession

## SYNOPSIS

Exports commands from another session and saves them in a PowerShell module.

## SYNTAX

### All

```
Export-PSSession [-OutputModule] <String> [-Force] [-Encoding <Encoding>]
 [[-CommandName] <String[]>] [-AllowClobber] [-ArgumentList <Object[]>]
 [-CommandType <CommandTypes>] [-Module <String[]>] [-FullyQualifiedModule <ModuleSpecification[]>]
 [[-FormatTypeName] <String[]>] [-Certificate <X509Certificate2>] [-Session] <PSSession>
 [<CommonParameters>]
```

## DESCRIPTION

The `Export-PSSession` cmdlet gets cmdlets, functions, aliases, and other command types from
another PowerShell session (PSSession) on a local or remote computer and saves them in a PowerShell
module. To add the commands from the module to the current session, use the `Import-Module` cmdlet.

Unlike `Import-PSSession`, which imports commands from another PSSession into the current session,
`Export-PSSession` saves the commands in a module. The commands are not imported into the current
session.

To export commands, use the `New-PSSession` cmdlet to create a PSSession that has the commands that
you want to export. Then use the `Export-PSSession` cmdlet to export the commands.

To prevent command name conflicts, the default for `Export-PSSession` is to export all commands,
except for commands that exist in the current session. You can use the **CommandName** parameter to
specify the commands to export.

The `Export-PSSession` cmdlet uses the implicit remoting feature of PowerShell. When you import
commands into the current session, they run implicitly in the original session or in a similar
session on the originating computer.

## EXAMPLES

### Example 1: Export commands from a PSSession

This example creates a new PSSession from the local computer to the Server01 computer. All of the
commands, except those that exist in the current session, are exported to the module named Server01
on the local computer. The export includes the formatting data for the commands.

```powershell
$S = New-PSSession -ComputerName Server01
Export-PSSession -Session $S -OutputModule Server01
```

The `New-PSSession` command creates a PSSession on the Server01 computer. The PSSession is stored
in the `$S` variable. The `Export-PSSession` command exports the `$S` variable's commands and
formatting data into the Server01 module.

### Example 2: Export the Get and Set commands

This example exports all of the `Get` and `Set` commands from a server.

```powershell
$S = New-PSSession -ConnectionUri https://exchange.microsoft.com/mailbox -Credential exchangeadmin01@hotmail.com -Authentication Negotiate
Export-PSSession -Session $S -Module exch* -CommandName Get-*, Set-* -FormatTypeName * -OutputModule $PSHOME\Modules\Exchange -Encoding ASCII
```

These commands export the `Get` and `Set` commands from a Microsoft Exchange Server snap-in on a
remote computer to an Exchange module in the `$PSHOME\Modules` directory on the local computer.
Placing the module in the `$PSHOME\Modules` directory makes it accessible to all users of the
computer.

### Example 3: Export commands from a remote computer

This example exports cmdlets from a PSSession on a remote computer and saves them in a module on
the local computer. The cmdlets from the module are added to the current session so that they can
be used.

```powershell
$S = New-PSSession -ComputerName Server01 -Credential Server01\User01
Export-PSSession -Session $S -OutputModule TestCmdlets -Type Cmdlet -CommandName *test* -FormatTypeName *
Remove-PSSession $S
Import-Module TestCmdlets
Get-Help Test*
Test-Files
```

The `New-PSSession` command creates a PSSession on the Server01 computer and saves it in the `$S`
variable. The `Export-PSSession` command exports the cmdlets whose names begin with Test from the
PSSession in `$S` to the TestCmdlets module on the local computer.

The `Remove-PSSession` cmdlet deletes the PSSession in `$S` from the current session. This command
shows that the PSSession need not be active to use the commands that were imported from the
session. The `Import-Module` cmdlet adds the cmdlets in the TestCmdlets module to the current
session. The command can be run in any session at any time.

The `Get-Help` cmdlet gets help for cmdlets whose names begin with Test. After the commands in a
module are added to the current session, you can use the `Get-Help` and `Get-Command` cmdlets to
learn about the imported commands. The `Test-Files` cmdlet was exported from the Server01 computer
and added to the session. The `Test-Files` cmdlet runs in a remote session on the computer from
which the command was imported. PowerShell creates a session from information that is stored in the
TestCmdlets module.

### Example 4: Export and clobber commands in the current session

This example exports commands that are stored in a variable into the current session.

```powershell
Export-PSSession -Session $S -AllowClobber -OutputModule AllCommands
```

This `Export-PSSession` command exports all commands and all formatting data from the PSSession in
the `$S` variable into the current session. The **AllowClobber** parameter includes commands with
the same names as commands in the current session.

### Example 5: Export commands from a closed PSSession

This example shows how to run the exported commands with special options when the PSSession that
created the exported commands is closed.

If the original remote session is closed when a module is imported, the module will use any open
remote session that connects to the originating computer. If there is no current session to the
originating computer, the module will reestablish a session.

To run exported commands with special options in a remote session, you must create a remote session
with those options before you import the module. Use the `New-PSSession` cmdlet with the
**SessionOption** parameter

```powershell
$Options = New-PSSessionOption -NoMachineProfile
$S = New-PSSession -ComputerName Server01 -SessionOption $Options
Export-PSSession -Session $S -OutputModule Server01
Remove-PSSession $S
New-PSSession -ComputerName Server01 -SessionOption $Options
Import-Module Server01
```

The `New-PSSessionOption` cmdlet creates a **PSSessionOption** object, and it saves the object in
the `$Options` variable. The `New-PSSession` command creates a PSSession on the Server01 computer.
The **SessionOption** parameter uses the object stored in `$Options`. The session is stored in the
`$S` variable.

The `Export-PSSession` cmdlet exports commands from the PSSession in `$S` to the Server01 module.
The `Remove-PSSession` cmdlet deletes the PSSession in the `$S` variable.

The `New-PSSession` cmdlet creates a new PSSession that connects to the Server01 computer. The
**SessionOption** parameter uses the object stored in `$Options`. The `Import-Module` cmdlet
imports the commands from the Server01 module. The commands in the module are run in the PSSession
on the Server01 computer.

## PARAMETERS

### -AllowClobber

Exports the specified commands, even if they have the same names as commands in the current
session.

If you export a command with the same name as a command in the current session, the exported
command hides or replaces the original commands. For more information, see
[about_Command_Precedence](../Microsoft.PowerShell.Core/About/about_Command_Precedence.md).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ArgumentList

Exports the variant of the command that results from using the specified arguments (parameter
values).

For example, to export the variant of the `Get-Item` command in the certificate (Cert:) drive in
the PSSession in `$S`, type `Export-PSSession -Session $S -Command Get-Item -ArgumentList cert:`.

```yaml
Type: System.Object[]
Parameter Sets: (All)
Aliases: Args

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Certificate

Specifies the client certificate that is used to sign the format files (*.Format.ps1xml) or script
module files (.psm1) in the module that `Export-PSSession` creates. Enter a variable that contains
a certificate or a command or expression that gets the certificate.

To find a certificate, use the `Get-PfxCertificate` cmdlet or use the `Get-ChildItem` cmdlet in the
Certificate (Cert:) drive. If the certificate is not valid or does not have sufficient authority,
the command fails.

```yaml
Type: System.Security.Cryptography.X509Certificates.X509Certificate2
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CommandName

Exports only the commands with the specified names or name patterns. Wildcards are permitted. Use
**CommandName** or its alias, **Name**.

By default, `Export-PSSession` exports all commands from the PSSession except for commands that
have the same names as commands in the current session. This prevents commands from being hidden or
replaced by commands in the current session. To export all commands, even those that hide or
replace other commands, use the **AllowClobber** parameter.

If you use the **CommandName** parameter, the formatting files for the commands are not exported
unless you use the **FormatTypeName** parameter. Similarly, if you use the **FormatTypeName**
parameter, no commands are exported unless you use the **CommandName** parameter.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Name

Required: False
Position: 2
Default value: All commands in the session.
Accept pipeline input: False
Accept wildcard characters: True
```

### -CommandType

Exports only the specified types of command objects. Use **CommandType** or its alias, **Type**.

The acceptable values for this parameter are as follows:

- Alias. All PowerShell aliases in the current session.
- All. All command types. It is the equivalent of `Get-Command -Name *`.
- Application. All files other than PowerShell files in paths listed in the Path environment
  variable (`$env:path`), including .txt, .exe, and .dll files.
- Cmdlet. The cmdlets in the current session. Cmdlet is the default.
- Configuration. A PowerShell configuration. For more information, see
  [about_Session_Configurations](../Microsoft.PowerShell.Core/About/about_Session_Configurations.md).
- ExternalScript. All .ps1 files in the paths listed in the Path environment variable
  (`$env:path`).
- Filter and Function. All PowerShell functions.
- Script. Script blocks in the current session.
- Workflow. A PowerShell workflow. For more information, see [about_Workflows](/powershell/module/PSWorkflow/About/about_Workflows).

```yaml
Type: System.Management.Automation.CommandTypes
Parameter Sets: (All)
Aliases: Type
Accepted values: Alias, All, Application, Cmdlet, Configuration, ExternalScript, Filter, Function, Script, Workflow

Required: False
Position: Named
Default value: All commands in the session.
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding

Specifies the type of encoding for the target file. The default value is `utf8NoBOM`.

The acceptable values for this parameter are as follows:

- `ascii`: Uses the encoding for the ASCII (7-bit) character set.
- `bigendianunicode`: Encodes in UTF-16 format using the big-endian byte order.
- `bigendianutf32`: Encodes in UTF-32 format using the big-endian byte order.
- `oem`: Uses the default encoding for MS-DOS and console programs.
- `unicode`: Encodes in UTF-16 format using the little-endian byte order.
- `utf7`: Encodes in UTF-7 format.
- `utf8`: Encodes in UTF-8 format.
- `utf8BOM`: Encodes in UTF-8 format with Byte Order Mark (BOM)
- `utf8NoBOM`: Encodes in UTF-8 format without Byte Order Mark (BOM)
- `utf32`: Encodes in UTF-32 format.

Beginning with PowerShell 6.2, the **Encoding** parameter also allows numeric IDs of registered code
pages (like `-Encoding 1251`) or string names of registered code pages (like
`-Encoding "windows-1251"`). For more information, see the .NET documentation for
[Encoding.CodePage](/dotnet/api/system.text.encoding.codepage?view=netcore-2.2).

```yaml
Type: System.Text.Encoding
Parameter Sets: (All)
Aliases:
Accepted values: ASCII, BigEndianUnicode, BigEndianUTF32, OEM, Unicode, UTF7, UTF8, UTF8BOM, UTF8NoBOM, UTF32

Required: False
Position: Named
Default value: UTF8NoBOM
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Overwrites one or more existing output files, even if the file has the read-only attribute.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatTypeName

Exports formatting instructions only for the specified Microsoft .NET Framework types. Enter the
type names. By default, `Export-PSSession` exports formatting instructions for all .NET Framework
types that are not in the **System.Management.Automation** namespace.

The value of this parameter must be the name of a type that is returned by a `Get-FormatData`
command in the session from which the commands are being imported. To get all of the formatting
data in the remote session, type `*`.

If you use the **FormatTypeName** parameter, no commands are exported unless you use the
**CommandName** parameter.

If you use the **CommandName** parameter, the formatting files for the commands are not exported
unless you use the **FormatTypeName** parameter.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FullyQualifiedModule

Specifies modules with names that are specified in the form of **ModuleSpecification** objects. See
the Remarks section of
[ModuleSpecification Constructor (Hashtable)](/dotnet/api/microsoft.powershell.commands.modulespecification.-ctor#Microsoft_PowerShell_Commands_ModuleSpecification__ctor_System_Collections_Hashtable_).

For example, the **FullyQualifiedModule** parameter accepts a module name that is specified in
either of these formats:

- `@{ModuleName = "modulename"; ModuleVersion = "version_number"}`
- `@{ModuleName = "modulename"; ModuleVersion = "version_number"; Guid = "GUID"}`

**ModuleName** and **ModuleVersion** are required, but **Guid** is optional. You cannot specify the
**FullyQualifiedModule** parameter in the same command as a **Module** parameter. the two
parameters are mutually exclusive.

```yaml
Type: Microsoft.PowerShell.Commands.ModuleSpecification[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Module

Exports only the commands in the specified PowerShell snap-ins and modules. Enter the snap-in and
module names. Wildcards are not permitted.

For more information, see `Import-Module` and
[about_PSSnapins](/powershell/module/microsoft.powershell.core/about/about_pssnapins?view=powershell-5.1).

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: PSSnapin

Required: False
Position: Named
Default value: All commands in the session.
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputModule

Specifies an optional path and name for the module created by `Export-PSSession`. The default path
is `$home\Documents\WindowsPowerShell\Modules`. This parameter is required.

If the module subdirectory or any of the files that `Export-PSSession` creates already exist, the
command fails. To overwrite existing files, use the **Force** parameter.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: PSPath, ModuleName

Required: True
Position: 1
Default value: $home\Documents\WindowsPowerShell\Modules
Accept pipeline input: False
Accept wildcard characters: False
```

### -Session

Specifies the PSSession from which the commands are exported. Enter a variable that contains a
session object or a command that gets a session object, such as a `Get-PSSession` command. This
parameter is required.

```yaml
Type: System.Management.Automation.Runspaces.PSSession
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe objects to `Export-PSSession`.

## OUTPUTS

### System.IO.FileInfo

`Export-PSSession` returns a list of files that comprise the module that it created.

## NOTES

`Export-PSSession` relies on the PowerShell remoting infrastructure. To use this cmdlet, the
computer must be configured for remoting. For more information, see
[about_Remote_Requirements](../Microsoft.PowerShell.Core/About/about_Remote_Requirements.md).

You cannot use `Export-PSSession` to export a PowerShell provider.

Exported commands run implicitly in the PSSession from which they were exported. The details of
running the commands remotely are handled entirely by PowerShell. You can run the exported commands
just as you would run local commands.

`Export-ModuleMember` captures and saves information about the PSSession in the module that it
exports. If the PSSession from which the commands were exported is closed when you import the
module, and there are no active PSSessions to the same computer, the commands in the module attempt
to recreate the PSSession. If attempts to recreate the PSSession fail, the exported commands will
not run.

The session information that `Export-ModuleMember` captures and saves in the module does not
include session options, such as those that you specify in the `$PSSessionOption` preference
variable or by using the **SessionOption** parameter of the `New-PSSession`, `Enter-PSSession`, or
`Invoke-Command` cmdlets. If the original PSSession is closed when you import the module, the
module will use another PSSession to the same computer, if one is available. To enable the imported
commands to run in a correctly configured session, create a PSSession with the options that you
want before you import the module.

To find the commands to export, `Export-PSSession` uses the `Invoke-Command` cmdlet to run a
`Get-Command` command in the PSSession. To get and save formatting data for the commands, it uses
the `Get-FormatData` and `Export-FormatData` cmdlets. You might see error messages from
`Invoke-Command`, `Get-Command`, `Get-FormatData`, and `Export-FormatData` when you run an
`Export-PSSession` command. Also, `Export-PSSession` cannot export commands from a session that
does not include the `Get-Command`, `Get-FormatData`, `Select-Object`, and `Get-Help` cmdlets.

`Export-PSSession` uses the `Write-Progress` cmdlet to display the progress of the command. You
might see the progress bar while the command is running.

Exported commands have the same limitations as other remote commands, including the inability to
start a program with a user interface, such as Notepad.

Because PowerShell profiles are not run in PSSessions, the commands that a profile adds to a
session are not available to `Export-PSSession`. To export commands from a profile, use an
`Invoke-Command` command to run the profile in the PSSession manually before exporting commands.

The module that `Export-PSSession` creates might include a formatting file, even if the command
does not import formatting data. If the command does not import formatting data, any formatting
files that are created will not contain formatting data.

## RELATED LINKS

[about_Command_Precedence](../Microsoft.PowerShell.Core/About/about_Command_Precedence.md)

[about_PSSessions](../Microsoft.PowerShell.Core/About/about_PSSessions.md)

[about_PSSnapins](/powershell/module/microsoft.powershell.core/about/about_pssnapins?view=powershell-5.1)

[about_Remote_Requirements](../Microsoft.PowerShell.Core/About/about_Remote_Requirements.md)

[Import-Module](../Microsoft.PowerShell.Core/Import-Module.md)

[Import-PSSession](Import-PSSession.md)

[Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md)

[New-PSSession](../Microsoft.PowerShell.Core/New-PSSession.md)

[New-PSSessionOption](../Microsoft.PowerShell.Core/New-PSSessionOption.md)

[Remove-PSSession](../Microsoft.PowerShell.Core/Remove-PSSession.md)
