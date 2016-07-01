---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Get UICulture
ms.technology:  powershell
external help file:  PSITPro4_Utility.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=293977
schema:  2.0.0
---


# Get-UICulture
## SYNOPSIS
Gets the current user interface (UI) culture settings in the operating system.
## SYNTAX

```
Get-UICulture [<CommonParameters>]
```

## DESCRIPTION
The Get-UICulture cmdlet gets information about the current UI culture settings for Windows.
The UI culture determines which text strings are used for user interface elements, such as menus and messages.

You can also use the Get-Culture cmdlet, which gets the current culture on the system.
The culture determines the display format of items such as numbers, currency, and dates.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-uiculture
```

This command gets the current UI culture information.
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-uiculture | format-list *
```

This command displays the values of all of the properties of the current UI culture in a list.
### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>(get-uiculture).calendar
```

This command displays the current values for the Calendar property of the current UI culture.
Calendar is just one property of UI culture.
To see all of the properties, type "get-uiculture | get-member".
### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>(get-uiculture).datetimeformat.shortdatepattern
```

This command displays the short date pattern for the current UI culture.
To see all of the subproperties of the DateTimeFormat property of the UI culture, type "(get-uiculture).datetimeformat | gm".
## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### None
You cannot pipe input to this cmdlet.
## OUTPUTS

### System.Globalization.CultureInfo, Microsoft.PowerShell.VistaCultureInfo
Get-UICulture returns an object that represents the current UI culture.
In Windows PowerShell 3.0, it returns a CultureInfo object.
In Windows PowerShell 2.0, it returns a VistaCultureInfo object.
## NOTES
* You can also use the $PsCulture and $PsUICulture variables. The $PsCulture variable stores the name of the current culture, and the $PsUICulture variable stores the name of the current UI culture.

*
## RELATED LINKS

