---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/import-localizeddata?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Import-LocalizedData
---
# Import-LocalizedData

## SYNOPSIS
Imports language-specific data into scripts and functions based on the UI culture that is selected
for the operating system.

## SYNTAX

```
Import-LocalizedData [[-BindingVariable] <String>] [[-UICulture] <String>] [-BaseDirectory <String>]
 [-FileName <String>] [-SupportedCommand <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Import-LocalizedData` cmdlet dynamically retrieves strings from a subdirectory whose name
matches the UI language set for the current user of the operating system. It is designed to enable
scripts to display user messages in the UI language selected by the current user.

`Import-LocalizedData` imports data from `.psd1` files in language-specific subdirectories of the
script directory and saves them in a local variable that is specified in the command. The cmdlet
selects the subdirectory and file based on the value of the `$PSUICulture` automatic variable. When
you use the local variable in the script to display a user message, the message appears in the
user's UI language.

You can use the parameters of `Import-LocalizedData` to specify an alternate UI culture, path, and
filename, to add supported commands, and to suppress the error message that appears if the `.psd1`
files are not found.

The `Import-LocalizedData` cmdlet supports the script internationalization initiative that was
introduced in Windows PowerShell 2.0. This initiative aims to better serve users worldwide by making
it easy for scripts to display user messages in the UI language of the current user. For more
information about this and about the format of the `.psd1` files, see
[about_Script_Internationalization](../Microsoft.PowerShell.Core/About/about_Script_Internationalization.md).

## EXAMPLES

### Example 1: Import text strings

This example imports text strings into the `$Messages` variable. It uses the default values of all
other cmdlet parameters.

```powershell
Import-LocalizedData -BindingVariable "Messages"
```

If the command is included in the Archives.ps1 script in the `C:\Test` directory, and the value of
the `$PsUICulture` automatic variable is zh-CN, `Import-LocalizedData` imports the `Archives.psd1`
file in the `C:\test\zh-CN` directory into the `$Messages` variable.

### Example 2: Import localized data strings

This example is run at the command line not in a script. It gets localized data strings from the
Test.psd1 file and displays them at the command line. Because the command is not used in a script,
the **FileName** parameter is required. The command uses the **UICulture** parameter to specify the
en-US culture.

```powershell
Import-LocalizedData -FileName "Test.psd1" -UICulture "en-US"
```

```Output
Name                           Value
----                           -----
Msg3                           "Use $_ to represent the object that is being processed."
Msg2                           "This command requires the credentials of a member of the Administrators group on the...
Msg1                           "The Name parameter is missing from the command."
```

`Import-LocalizedData` returns a hash table that contains the localized data strings.

### Example 3: Import UI culture strings

```powershell
Import-LocalizedData -BindingVariable "MsgTbl" -UICulture "ar-SA" -FileName "Simple" -BaseDirectory "C:\Data\Localized"
```

This command imports text strings into the `$MsgTbl` variable of a script.

It uses the **UICulture** parameter to direct the cmdlet to import data from the `Simple.psd1` file
in the `ar-SA` subdirectory of `C:\Data\Localized`.

### Example 4: Import localized data into a script

This example shows how to use localized data in a simple script.

```powershell
PS C:\> # In C:\Test\en-US\Test.psd1:

ConvertFrom-StringData @'

# English strings

Msg1 = "The Name parameter is missing from the command."
Msg2 = "This command requires the credentials of a member of the Administrators group on the computer."
Msg3 = "Use $_ to represent the object that is being processed."
'@

# In C:\Test\Test.ps1

Import-LocalizedData -BindingVariable "Messages"
Write-Host $Messages.Msg2

# In Windows PowerShell

PS C:\> .\Test.ps1

This command requires the credentials of a member of the Administrators group on the computer.
```

The first part of the example shows the contents of the `Test.psd1` file. It contains a
`ConvertFrom-StringData` command that converts a series of named text strings into a hash table. The
`Test.psd1` file is located in the en-US subdirectory of the `C:\Test` directory that contains the
script.

The second part of the example shows the contents of the `Test.ps1` script. It contains an
`Import-LocalizedData` command that imports the data from the matching `.psd1` file into the
`$Messages` variable and a `Write-Host` command that writes one of the messages in the `$Messages`
variable to the host program.

The last part of the example runs the script. The output shows that it displays the correct user
message in the UI language set for the current user of the operating system.

### Example 5: Replace default text strings in a script

This example shows how to use `Import-LocalizedData` to replace default text strings defined in the
DATA section of a script.

```powershell
PS C:\> # In TestScript.ps1
$UserMessages = DATA

{    ConvertFrom-StringData @'

    # English strings

        Msg1 = "Enter a name."
        Msg2 = "Enter your employee ID."
        Msg3 = "Enter your building number."
'@
}

Import-LocalizedData -BindingVariable "UserMessages"
$UserMessages.Msg1...
```

In this example, the DATA section of the TestScript.ps1 script contains a `ConvertFrom-StringData`
command that converts the contents of the DATA section to a hash table and stores in the value of
the `$UserMessages` variable.

The script also includes an `Import-LocalizedData` command, which imports a hash table of translated
text strings from the TestScript.psd1 file in the subdirectory specified by the value of the
`$PsUICulture` variable. If the command finds the `.psd1` file, it saves the translated strings from
the file in the value of the same `$UserMessages` variable, overwriting the hash table saved by the
DATA section logic.

The third command displays the first message in the `$UserMessages` variable.

If the `Import-LocalizedData` command finds a `.psd1` file for the `$PsUICulture` language, the
value of the `$UserMessages` variable contains the translated text strings. If the command fails for
any reason, the command displays the default text strings defined in the DATA section of the script.

### Example 6: Suppress error messages if the UI culture is not found

This example shows how to suppress the error messages that appear when `Import-LocalizedData` cannot
find the directories that match the user's UI culture or cannot find a `.psd1` file for the script
in those directories.

```powershell
PS C:\> # In Day1.ps1

Import-LocalizedData -BindingVariable "Day"

# In Day2.ps1

Import-LocalizedData -BindingVariable "Day" -ErrorAction:SilentlyContinue

PS C:\> .\Day1.ps1
Import-LocalizedData : Cannot find PowerShell data file 'Day1.psd1' in directory 'C:\ps-test\fr-BE\' or any parent culture directories.
At C:\ps-test\Day1.ps1:17 char:21+ Import-LocalizedData <<<<  Day
Today is Tuesday

PS C:\> .\Day2.ps1
Today is Tuesday
```

You can use the **ErrorAction** common parameter with a value of SilentlyContinue to suppress the
error message. This is especially useful when you have provided user messages in a default or
fallback language, and no error message is needed.

This example compares two scripts, `Day1.ps1` and Day2.ps1, that include an `Import-LocalizedData`
command. The scripts are identical, except that Day2 uses the **ErrorAction** common parameter with
a value of `SilentlyContinue`.

The sample output shows the results of running both scripts when the UI culture is set to `fr-BE`
and there are no matching files or directories for that UI culture. `Day1.ps1` displays an error
message and English output. `Day2.ps1` just displays the English output.

## PARAMETERS

### -BaseDirectory

Specifies the base directory where the `.psd1` files are located. The default is the directory
where the script is located. `Import-LocalizedData` searches for the `.psd1` file for the script
in a language-specific subdirectory of the base directory.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BindingVariable

Specifies the variable into which the text strings are imported. Enter a variable name without a
dollar sign (`$`).

In Windows PowerShell 2.0, this parameter is required. In Windows PowerShell 3.0, this parameter is
optional. If you omit this parameter, `Import-LocalizedData` returns a hash table of the text
strings. The hash table is passed down the pipeline or displayed at the command line.

When using `Import-LocalizedData` to replace default text strings specified in the DATA section of a
script, assign the DATA section to a variable and enter the name of the DATA section variable in the
value of the **BindingVariable** parameter. Then, when `Import-LocalizedData` saves the imported
content in the **BindingVariable**, the imported data will replace the default text strings. If you
are not specifying default text strings, you can select any variable name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Variable

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileName

Specifies the name of the data file (`.psd1)` to be imported. Enter a file name. You can specify a
file name that does not include its `.psd1` file name extension, or you can specify the file name
including the `.psd1` file name extension. Data files should be saved as Unicode or UTF-8.

The **FileName** parameter is required when `Import-LocalizedData` is not used in a script.
Otherwise, the parameter is optional and the default value is the base name of the script. You can
use this parameter to direct `Import-LocalizedData` to search for a different `.psd1` file.

For example, if the **FileName** is omitted and the script name is FindFiles.ps1,
`Import-LocalizedData` searches for the FindFiles.psd1 data file.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SupportedCommand

Specifies cmdlets and functions that generate only data.

Use this parameter to include cmdlets and functions that you have written or tested. For more
information, see
[about_Script_Internationalization](../Microsoft.PowerShell.Core/About/about_Script_Internationalization.md).

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UICulture

Specifies an alternate UI culture.
The default is the value of the `$PsUICulture` automatic variable.
Enter a UI culture in `<language>-<region>` format, such as `en-US`, `de-DE`, or `ar-SA`.

The value of the **UICulture** parameter determines the language-specific subdirectory (within the
base directory) from which `Import-LocalizedData` gets the `.psd1` file for the script.

The cmdlet searches for a subdirectory with the same name as the value of the **UICulture**
parameter or the `$PsUICulture` automatic variable, such as `de-DE` or `ar-SA`. If it cannot find
the directory, or the directory does not contain a `.psd1` file for the script, it searches for a
subdirectory with the name of the language code, such as de or ar. If it cannot find the
subdirectory or `.psd1` file, the command fails and the data is displayed in the default language
specified in the script.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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

You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Collections.Hashtable

`Import-LocalizedData` saves the hash table in the variable that is specified by the value of the
**BindingVariable** parameter.

## NOTES

- Before using `Import-LocalizedData`, localize your user messages. Format the messages for each
  locale (UI culture) in a hash table of key-value pairs, and save the hash table in a file with the
  same name as the script and a `.psd1` file name extension. Create a directory under the script
  directory for each supported UI culture, and then save the `.psd1` file for each UI culture in
  the directory with the UI culture name.

  For example, localize your user messages for the de-DE locale and format them in a hash table.
  Save the hash table in a `<ScriptName>.psd1` file. Then create a `de-DE` subdirectory under the
  script directory, and save the German `<ScriptName\>.psd1` file in the `de-DE` subdirectory.
  Repeat this method for each locale that you support.

- `Import-LocalizedData` performs a structured search for the localized user messages for a script.

  `Import-LocalizedData` begins the search in the directory where the script file is located (or the
  value of the **BaseDirectory** parameter). It then searches within the base directory for a
  subdirectory with the same name as the value of the `$PsUICulture` variable (or the value of the
  **UICulture** parameter), such as `de-DE` or `ar-SA`. Then, it searches in that subdirectory for a
  `.psd1` file with the same name as the script (or the value of the **FileName** parameter).

  If `Import-LocalizedData` cannot find a subdirectory with the name of the UI culture, or the
  subdirectory does not contain a `.psd1` file for the script, it searches for a `.psd1` file
  for the script in a subdirectory with the name of the language code, such as de or ar. If it
  cannot find the subdirectory or `.psd1` file, the command fails, the data is displayed in the
  default language in the script, and an error message is displayed explaining that the data could
  not be imported. To suppress the message and fail gracefully, use the **ErrorAction** common
  parameter with a value of SilentlyContinue.

  If `Import-LocalizedData` finds the subdirectory and the `.psd1` file, it imports the hash table
  of user messages into the value of the **BindingVariable** parameter in the command. Then, when
  you display a message from the hash table in the variable, the localized message is displayed.

  For more information, see
  [about_Script_Internationalization](../Microsoft.Powershell.Core/About/about_Script_Internationalization.md).

## RELATED LINKS

[Write-Host](Write-Host.md)

[Import-PowerShellDataFile](Import-PowerShellDataFile.md)
