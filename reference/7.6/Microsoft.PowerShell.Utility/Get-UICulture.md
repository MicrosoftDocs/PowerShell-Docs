---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 12/12/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/get-uiculture?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-UICulture
---

# Get-UICulture

## SYNOPSIS
Gets the current UI culture settings in the operating system.

## SYNTAX

```
Get-UICulture [<CommonParameters>]
```

## DESCRIPTION

The `Get-UICulture` cmdlet gets information about the current user interface (UI) culture settings
for Windows. The UI culture determines which text strings are used for user interface elements, such
as menus and messages.

You can also use the `Get-Culture` cmdlet, which gets the current culture on the system. The culture
determines the display format of items such as numbers, currency, and dates.

## EXAMPLES

### Example 1: Get the UI culture

```powershell
Get-UICulture
```

This command gets the current UI culture information.

### Example 2: Get the UI culture and format the results

```powershell
Get-UICulture | Format-List *
```

This command displays the values of all of the properties of the current UI culture in a list.

### Example 3: Get the value of the Calendar property

```powershell
(Get-UICulture).Calendar
```

This command displays the current values for the Calendar property of the current UI culture.
Calendar is just one property of UI culture. To see all of the properties, type
`Get-UICulture | Get-Member`.

### Example 4: Get the short date pattern

```powershell
(Get-UICulture).DateTimeFormat.ShortDatePattern
```

This command displays the short date pattern for the current UI culture. To see all of the
subproperties of the **DateTimeFormat** property of the UI culture, type
`(Get-UICulture).DateTimeFormat | Get-Member`.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### System.Globalization.CultureInfo

This cmdlet returns an object representing the current UI culture. In PowerShell 3.0 and later,
it returns a **CultureInfo** object.

### Microsoft.PowerShell.VistaCultureInfo

In Windows PowerShell 2.0 and earlier, this cmdlet returns a **VistaCultureInfo** object.

## NOTES

You can also use the `$PSCulture` and `$PSUICulture` variables. The `$PSCulture` variable stores the
name of the current culture, and the `$PSUICulture` variable stores the name of the current UI
culture.

## RELATED LINKS
