---
description: Describes the script internationalization features that make it easy for scripts to display messages and instructions to users in their user interface (UI) language. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 03/20/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_script_internationalization?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Script_Internationalization
---
# About Script Internationalization

## Short Description
Describes the script internationalization features that make it easy for
scripts to display messages and instructions to users in their user interface
(UI) language.

## Long Description

The PowerShell script internationalization features allow you to better serve
users throughout the world by displaying help and user messages in the user's
language.

The script internationalization features query the UI culture of the operating
system during execution, import the appropriate translated text strings, and
display them to the user. The Data section lets you store text strings separate
from code so they are easily identified and extracted. A new cmdlet,
`ConvertFrom-StringData`, converts text strings into dictionary-like hash
tables to facilitate translation.

To support international Help text, PowerShell includes the following
features:

- A Data section that separates text strings from code instructions. For more
  information about the Data section, see
  [about_Data_Sections](about_Data_Sections.md).

- New automatic variables, `$PSCulture` and `$PSUICulture`. `$PSCulture` stores
  the name of the UI language used on the system for elements such as the date,
  time, and currency. The `$PSUICulture` variable stores the name of the UI
  language used on the system for user interface elements such as menus and
  text strings.

- A cmdlet, `ConvertFrom-StringData`, that converts text strings into
  dictionary-like hash tables to facilitate translation. For more information,
  see [ConvertFrom-StringData](xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData).

- A new file type, `.psd1`, that stores translated text strings. The `.psd1`
  files are stored in language-specific subdirectories of the script directory.

- A cmdlet, `Import-LocalizedData`, that imports translated text strings for a
  specified language into a script at runtime. This cmdlet recognizes and
  imports strings in any Windows-supported language. For more information see
  [Import-LocalizedData](xref:Microsoft.PowerShell.Utility.Import-LocalizedData).

### The Data Section: Storing Default Strings

Use a Data section in the script to store the text strings in the default
language. Arrange the strings in key/value pairs in a here-string. Each
key/value pair must be on a separate line. If you include comments, the
comments must be on separate lines.

The `ConvertFrom-StringData` cmdlet converts the key/value pairs in the
here-string into a dictionary-like hash table that is stored in the value of
the Data section variable.

In the following example, the Data section of the `World.ps1` script includes
the English-United States (en-US) set of prompt messages for a script. The
`ConvertFrom-StringData` cmdlet converts the strings into a hash table and
stores them in the `$msgtable` variable.

```powershell
$msgTable = Data {
    #culture="en-US"
    ConvertFrom-StringData @'
    helloWorld = Hello, World.
    errorMsg1 = You cannot leave the user name field blank.
    promptMsg = Please enter your user name.
'@
}
```

For more information about here-strings, see
[about_Quoting_Rules](about_Quoting_Rules.md).

### PSD1 Files: Storing Translated Strings

Save the script messages for each UI language in separate text files with the
same name as the script and the `.psd1` file name extension. Store the files in
subdirectories of the script directory with names of cultures in the following
format:

`<language>-<region>`

Examples: de-DE, ar-SA, and zh-Hans

For example, if the `World.ps1` script is stored in the `C:\Scripts` directory,
you would create a file directory structure that resembles the following:

```
C:\Scripts
C:\Scripts\World.ps1
C:\Scripts\de-DE\World.psd1
C:\Scripts\ar-SA\World.psd1
C:\Scripts\zh-CN\World.psd1
...
```

The `World.psd1` file in the de-DE subdirectory of the script directory might
include the following statement:

```powershell
ConvertFrom-StringData -StringData @'
helloWorld = Hallo, Welt.
errorMsg1 = Das Feld Benutzername darf nicht leer sein.
promptMsg = Geben Sie Ihren Benutzernamen ein.
'@
```

Similarly, the `World.psd1` file in the ar-SA subdirectory of the script
directory might includes the following statement:

```powershell
ConvertFrom-StringData -StringData @'
helloWorld = مرحبًا أيها العالَم
errorMsg1 = لا يمكنك ترك حقل اسم المستخدم فارغًا
promptMsg = يرجى إدخال اسم المستخدم الخاص بك
'@
```

### Import-LocalizedData: Dynamic Retrieval of Translated Strings

To retrieve the strings in the UI language of the current user, use the
`Import-LocalizedData` cmdlet.

`Import-LocalizedData` finds the value of the `$PSUICulture` automatic variable
and imports the content of the `<script-name>.psd1` files in the subdirectory
that matches the `$PSUICulture` value. Then, it saves the imported content in
the variable specified by the value of the **BindingVariable** parameter.

```powershell
Import-LocalizedData -BindingVariable msgTable
```

For example, if the `Import-LocalizedData` command appears in the
`C:\Scripts\World.ps1` script and the value of `$PSUICulture` is "ar-SA",
`Import-LocalizedData` finds the following file:

`C:\Scripts\ar-SA\World.psd1`

Then, it imports the Arabic text strings from the file into the `$msgTable`
variable, replacing any default strings that might be defined in the Data
section of the `World.ps1` script.

As a result, when the script uses the `$msgTable` variable to display user
messages, the messages are displayed in Arabic.

For example, the following script displays the "Please enter your user name"
message in Arabic:

```powershell
if (!($username)) { $msgTable.promptMsg }
```

If `Import-LocalizedData` cannot find a `.psd1` file that matches the value of
`$PSUIculture`, the value of `$msgTable` is not replaced, and the call to
`$msgTable.promptMsg` displays the fallback en-US strings.

## Examples

This example shows how the script internationalization features are used in a
script to display a day of the week to users in the language that is set on the
computer.

The following is a complete listing of the Sample1.ps1 script file.

The script begins with a Data section named Day ($Day) that contains a
`ConvertFrom-StringData` command. The expression submitted to
`ConvertFrom-StringData` is a here-string that contains the day names in the
default UI culture, en-US, in key/value pairs. The `ConvertFrom-StringData`
cmdlet converts the key/value pairs in the here-string into a hash table and
then saves it in the value of the `$Day` variable.

The `Import-LocalizedData` command imports the contents of the `.psd1` file in
the directory that matches the value of the `$PSUICulture` automatic variable
and then saves it in the `$Day` variable, replacing the values of `$Day` that
are defined in the Data section.

The remaining commands load the strings into an array and display them.

```powershell
$Day = Data {
#culture="en-US"
ConvertFrom-StringData -StringData @'
    messageDate = Today is
    d0 = Sunday
    d1 = Monday
    d2 = Tuesday
    d3 = Wednesday
    d4 = Thursday
    d5 = Friday
    d6 = Saturday
'@
}

Import-LocalizedData -BindingVariable Day

#Build an array of weekdays.
$a = $Day.d0, $Day.d1, $Day.d2, $Day.d3, $Day.d4, $Day.d5, $Day.d6

# Get the day of the week as a number (Monday = 1).
# Index into $a to get the name of the day.
# Use string formatting to build a sentence.

"{0} {1}" -f $Day.messageDate, $a[(Get-Date -UFormat %u)] | Out-Host
```

The `.psd1` files that support the script are saved in subdirectories of the
script directory with names that match the `$PSUICulture` values.

The following is a complete listing of `.\de-DE\sample1.psd1`:

```powershell
# culture="de-DE"
ConvertFrom-StringData @'
    messageDate = Heute ist
    d0 = Sonntag
    d1 = Montag
    d2 = Dienstag
    d3 = Mittwoch
    d4 = Donnerstag
    d5 = Freitag
    d6 = Samstag
'@
```

As a result, when you run Sample.ps1 on a system on which the value of
`$PSUICulture` is de-DE, the output of the script is:

```Output
Heute ist Freitag
```

## See also

- [about_Data_Sections](about_Data_Sections.md)
- [about_Automatic_Variables](about_Automatic_Variables.md)
- [about_Hash_Tables](about_Hash_Tables.md)
- [about_Quoting_Rules](about_Quoting_Rules.md)
- [ConvertFrom-StringData](xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData)
- [Import-LocalizedData](xref:Microsoft.PowerShell.Utility.Import-LocalizedData)

