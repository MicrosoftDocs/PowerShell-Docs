---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293959
schema: 2.0.0
---

# Export-PSSession
## SYNOPSIS
Imports commands from another session and saves them in a Windows PowerShell module.

## SYNTAX

```
Export-PSSession [-OutputModule] <String> [-Force] [-Encoding <String>] [[-CommandName] <String[]>]
 [-AllowClobber] [-ArgumentList <Object[]>] [-CommandType <CommandTypes>] [-Module <String[]>]
 [-FullyQualifiedModule <ModuleSpecification[]>] [[-FormatTypeName] <String[]>]
 [-Certificate <X509Certificate2>] [-Session] <PSSession> [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The Export-PSSession cmdlet gets cmdlets, functions, aliases, and other command types from another PSSession on a local or remote computer and saves them in a Windows PowerShell module.
To add the commands from the module to the current session, use the Import-Module cmdlet.

Unlike Import-PSSession, which imports commands from another PSSession into the current session, Export-PSSession saves the commands in a module.
The commands are not imported into the current session.

To export commands, first use the New-PSSession cmdlet to create a PSSession that has the commands that you want to export.
Then use the Export-PSSession cmdlet to export the commands.
By default, Export-PSSession exports all commands, except for commands that exist in the current session, but you can use the CommandName parameters to specify the commands to export.

The Export-PSSession cmdlet uses the implicit remoting feature of Windows PowerShell.
When you import commands into the current session, they run implicitly  in the original session or in a  similar session on the originating computer.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>$s = new-pssession -computerName Server01
PS C:\>export-pssession -session $s -outputModule Server01
```

The commands in this example export all commands from a PSSession on the Server01 computer to the Server01 module on the local computer except for commands that have the same names as commands in the current session.
It also exports the formatting data for the commands.

The first command creates a PSSession on the Server01 computer.
The second command exports the commands and formatting data from the session into the Server01 module.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$s = new-pssession -ConnectionUri http://exchange.microsoft.com/mailbox -credential exchangeadmin01@hotmail.com -authentication negotiate
PS C:\>export-pssession -session $r -module exch* -commandname get-*, set-* -formattypename * -outputModule $pshome\Modules\Exchange -encoding ASCII
```

These commands export the Get and Set commands from a Microsoft Exchange Server snap-in on a remote computer to an Exchange module in the $pshome\Modules directory on the local computer.

Placing the module in the $pshome\Module directory makes it accessible to all users of the computer.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$s = new-pssession -computerName Server01 -credential Server01\User01
PS C:\>export-pssession -session $s -outputModule TestCmdlets -type cmdlet -commandname *test* -formattypename *
PS C:\>remove-pssession $s
PS C:\>import-module TestCmdlets
PS C:\>get-help test*
PS C:\>test-files
```

These commands export cmdlets from a PSSession on a remote computer and save them in a module on the local computer.
Then, the commands add the cmdlets from the module to the current session so that they can be used.

The first command creates a PSSession on the Server01 computer and saves it in the $s variable.

The second command exports the cmdlets whose names begin with "Test" from the PSSession in $s to the TestCmdlets module on the local computer.

The third command uses the Remove-PSSession cmdlet to delete the PSSession in $s from the current session.
This command shows that the PSSession need not be active to use the commands that were imported from it.

The fourth command, which can be run in any session at any time, uses the Import-Module cmdlet to add the cmdlets in the TestCmdlets module to the current session.

The fifth command uses the Get-Help cmdlet to get help for cmdlets whose names begin with "Test." After the commands in a module are added to the current session, you can use the Get-Help and Get-Command cmdlets to learn about the imported commands, just as you would use them for any command in the session.

The sixth command uses the Test-Files cmdlet, which was exported from the Server01 computer and added to the session.

Although it is not evident, the Test-Files command actually runs in a remote session on the computer from which the command was imported.
Windows PowerShell creates a session from information that is stored in the module.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>export-pssession -session $s -AllowClobber -outputModule AllCommands
```

This command exports all commands and all formatting data from the PSSession in the $s variable into the current session.
The command uses the AllowClobber parameter to include commands with the same names as commands in the current session.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>$options = New-PSSessionOption -NoMachineProfile
PS C:\>$s = new-pssession -computername Server01 -sessionoption $options
PS C:\>export-pssession -session $s -outputModule Server01
PS C:\>remove-pssession $s
PS C:\>new-pssession -computername Server01 -sessionoption $options
PS C:\>import-module Server01
```

This example shows how to run the exported commands in a session with particular options when the PSSession from which the commands were exported is closed.

When you use Export-PSSession, it saves information about the original PSSession in the module that it creates.
When you import the module, if the original remote session is closed, the module will use any open remote session that connects to originating computer.

If the current session does not include a remote session to the originating computer, the commands in the module will re-establish a session to that computer.
However, Export-PSSession does not save special options, such as those set by using the SessionOption parameter of New-PSSession, in the module.

Therefore, if you want to run the exported commands in a remote session with particular options, you need to create a remote session with the options that you want before you import the module.

The first command uses the New-PSSessionOption cmdlet to create a PSSessionOption object, and it saves the object in the $options variable.

The second command creates a PSSession that includes the specified options.
The command uses the New-PSSession cmdlet to create a PSSession on the Server01 computer.
It uses the SessionOption parameter to submit the option object in $options.

The third command uses the Export-PSSession cmdlet to export commands from the PSSession in $s to the Server01 module.

The fourth command uses the Remove-PSSession cmdlet to delete the PSSession in the $s variable.

The fifth command uses the New-PSSession cmdlet to create a new PSSession that connects to the Server01 computer.
This PSSession also uses the session options in the $options variable.

The sixth command uses the Import-Module cmdlet to import the commands from the Server01 module.
The commands in the module run in the PSSession on the Server01 computer.

## PARAMETERS

### -AllowClobber
Exports the specified commands, even if they have the same names as commands in the current session.

If you import a command with the same name as a command in the current session, the imported command hides or replaces the original commands.
For more information, see about_Command_Precedence.

Export-PSSession does not import commands that have the same names as commands in the current session.
The default behavior is designed to prevent command name conflicts.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ArgumentList
Exports the variant of the command that results from using the specified arguments (parameter values).

For example, to export the variant of the Get-Item command in the certificate (Cert:) drive in the PSSession in $s, type "export-pssession -session $s -command get-item -argumentlist cert:".

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: Args

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CommandName
Exports only the commands with the specified names or name patterns.
Wildcards are permitted.
Use "CommandName" or its alias, "Name".

By default, Export-PSSession exports all commands from the PSSession except for commands that have the same names as commands in the current session.
This prevents imported commands from hiding or replacing commands in the current session.
To export all commands, even those that hide or replace other commands, use the AllowClobber parameter.

If you use the CommandName parameter, the formatting files for the commands are not exported unless you use the FormatTypeName parameter.
Similarly, if you use the FormatTypeName parameter, no commands are exported unless you use the CommandName parameter.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Name

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CommandType
Exports only the specified types of command objects.
Use "CommandType" or its alias, "Type".

Valid values are:

-- Alias: All Windows PowerShell aliases in the current session.
-- All: All command types. It is the equivalent of "get-command *".
-- Application: All files other than Windows PowerShell files in paths listed in the Path environment variable ($env:path), including .txt, .exe, and .dll files.
-- Cmdlet: The cmdlets in the current session. "Cmdlet" is the default.
-- ExternalScript: All .ps1 files in the paths listed in the Path environment variable ($env:path).
-- Filter and Function: All Windows PowerShell functions.
-- Script: Script blocks in the current session.

```yaml
Type: CommandTypes
Parameter Sets: (All)
Aliases: Type
Accepted values: Alias, Function, Filter, Cmdlet, ExternalScript, Application, Script, Workflow, Configuration, All

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding
Specifies the encoding for the output files.
Valid values are "Unicode", "UTF7", "UTF8", "ASCII", "UTF32", "BigEndianUnicode", "Default", and "OEM".
The default is "UTF-8".

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Unicode, UTF7, UTF8, ASCII, UTF32, BigEndianUnicode, Default, OEM

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Overwrites one or more existing output files, even if the file has the read-only attribute.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatTypeName
Exports formatting instructions only for the specified Microsoft .NET Framework types.
Enter the type names.
By default, Export-PSSession exports formatting instructions for all .NET Framework types that are not in the System.Management.Automation namespace.

The value of this parameter must be the name of a type that is returned by a Get-FormatData command in the session from which the commands are being imported.
To get all of the formatting data in the remote session, type *.

If you use the FormatTypeName parameter, no commands are exported unless you use the CommandName parameter.

Similarly, if you use the CommandName parameter, the formatting files for the commands are not exported unless you use the FormatTypeName parameter.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FullyQualifiedModule
Specifies modules with names that are specified in the form of ModuleSpecification objects (described by the Remarks section of Module Specification Constructor (Hashtable) on MSDN).
For example, the FullyQualifiedModule parameter accepts a module name that is specified in the format @{ModuleName = "modulename"; ModuleVersion = "version_number"} or @{ModuleName = "modulename"; ModuleVersion = "version_number"; Guid = "GUID"}.
ModuleName and ModuleVersion are required, but Guid is optional.

You cannot specify the FullyQualifiedModule parameter in the same command as a Module parameter; the two parameters are mutually exclusive.

```yaml
Type: ModuleSpecification[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
If you import a command with the same name as a command in the current session, the imported command hides or replaces the original commands.
For more information, see about_Command_Precedence.

Export-PSSession does not import commands that have the same names as commands in the current session.
The default behavior is designed to prevent command name conflicts.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
If you import a command with the same name as a command in the current session, the imported command hides or replaces the original commands.
For more information, see about_Command_Precedence.

Export-PSSession does not import commands that have the same names as commands in the current session.
The default behavior is designed to prevent command name conflicts.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Module
Exports only the commands in the specified Windows PowerShell snap-ins and modules.
Enter the snap-in and module names.
Wildcards are not permitted.

For more information, see about_PSSnapins and Import-Module.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: PSSnapin

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputModule
Specifies a path (optional) and name for the module that Export-PSSession creates.
The default path is $home\Documents\WindowsPowerShell\Modules.
This parameter is required.

If the module subdirectory or any of the files that Export-PSSession creates already exist, the command fails.
To overwrite existing files, use the Force parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PSPath, ModuleName

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Session
Specifies the PSSession from which the commands are exported. 
Enter a variable that contains a session object or a command that gets a session object, such as a Get-PSSession command.
This parameter is required.

```yaml
Type: PSSession
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Certificate
Specifies the client certificate that is used to sign the format files (*.Format.ps1xml) or script module files (.psm1) in the module that Export-PSSession creates.
Enter a variable that contains a certificate or a command or expression that gets the certificate.

To find a certificate, use the Get-PfxCertificate cmdlet or use the Get-ChildItem cmdlet in the Certificate (Cert:) drive.
If the certificate is not valid or does not have sufficient authority, the command fails.

```yaml
Type: X509Certificate2
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe objects to Export-PSSession.

## OUTPUTS

### System.IO.FileInfo
Export-PSSession returns a list of files that comprise the module that it created.

## NOTES
Export-PSSession relies on the Windows PowerShell remoting infrastructure.
To use this cmdlet, the computer must be configured for remoting.
For more information, see about_Remote_Requirements.

You cannot use Export-PSSession to export a Windows PowerShell provider.

Exported commands run implicitly in the PSSession from which they were exported.
However, the details of running the commands remotely are handled entirely by Windows PowerShell.
You can run the exported commands just as you would run local commands.

Export-Module captures and saves information about the PSSession in the module that it exports.
If the PSSession from which the commands were exported is closed when you import the module, and there are no active PSSessions to the same computer, the commands in the module attempt to re-create the PSSession.
If attempts to re-create the PSSession fail, the exported commands will not run.

The session information that Export-Module captures and saves in the module does not include session options, such as those that you specify in the $PSSessionOption preference variable or by using the SessionOption parameters of  the New-PSSession, Enter-PSSession, or Invoke-Command cmdlet.
If the original PSSession is closed when you import the module, the module will use another PSSession to the same computer, if one is available.
To enable the imported commands to run in a correctly configured session, create a PSSession with the options that you want before you import the module.

To find the commands to export, Export-PSSession uses the Invoke-Command cmdlet to run a Get-Command command in the PSSession.
To get and save formatting data for the commands, it uses the Get-FormatData and Export-FormatData cmdlets.
You might see error messages from Invoke-Command, Get-Command, Get-FormatData, and Export-FormatData when you run an Export-PSSession command.
Also, Export-PSSession cannot export commands from a session that does not include the Get-Command, Get-FormatData, Select-Object, and Get-Help cmdlets.

Export-PSSession uses the Write-Progress cmdlet to display the progress of the command.
You might see the progress bar while the command is running.

Exported commands have the same limitations as other remote commands, including the inability to start a program with a user interface, such as Notepad.

Because Windows PowerShell profiles are not run in PSSessions, the commands that a profile adds to a session are not available to Export-PSSession.
To export commands from a profile, use an Invoke-Command command to run the profile in the PSSession manually before exporting commands.

The module that Export-PSSession creates might include a formatting file, even if the command does not import formatting data.
If the command does not import formatting data, any formatting files that are created will not contain formatting data.

## RELATED LINKS

[Import-Module]()

[Import-PSSession]()

[Invoke-Command]()

[New-PSSession]()

