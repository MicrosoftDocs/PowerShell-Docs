---
external help file: Microsoft.PowerShell.PSReadLine.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PSReadLine
ms.date: 12/07/2018
online version: http://go.microsoft.com/fwlink/?LinkId=821450
schema: 2.0.0
title: Get-PSReadLineOption
---

# Get-PSReadLineOption

## SYNOPSIS
Gets values for the options that can be configured.

## SYNTAX

```
Get-PSReadLineOption [<CommonParameters>]
```

## DESCRIPTION

The `Get-PSReadLineOption` cmdlet returns the current state of the settings that can be configured
by using the `Set-PSReadLineOption` cmdlet. You can use the returned object to change
**PSReadLine** options. This provides a slightly simpler way to set syntax coloring options for
multiple kinds of tokens.

## EXAMPLES

### Example 1: Get options and their values

```powershell
Get-PSReadLineOption
```

```Output
EditMode                               : Windows
ContinuationPrompt                     : >>
ContinuationPromptForegroundColor      : DarkYellow
ContinuationPromptBackgroundColor      : DarkMagenta
ExtraPromptLineCount                   : 0
AddToHistoryHandler                    :
CommandValidationHandler               :
CommandsToValidateScriptBlockArguments : {ForEach-Object, %, Invoke-Command, icm...}
HistoryNoDuplicates                    : False
MaximumHistoryCount                    : 4096
MaximumKillRingCount                   : 10
HistorySearchCursorMovesToEnd          : False
ShowToolTips                           : False
DingTone                               : 1221
CompletionQueryItems                   : 100
WordDelimiters                         : ;:,.[]{}()/\|^&*-=+'"
DingDuration                           : 50
BellStyle                              : Audible
HistorySearchCaseSensitive             : False
ViModeIndicator                        : None
HistorySavePath                        : C:\Users\testuser\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\Cons
                                         oleHost_history.txt
HistorySaveStyle                       : SaveIncrementally
DefaultTokenForegroundColor            : DarkYellow
CommentForegroundColor                 : DarkGreen
KeywordForegroundColor                 : Green
StringForegroundColor                  : DarkCyan
OperatorForegroundColor                : DarkGray
VariableForegroundColor                : Green
CommandForegroundColor                 : Yellow
ParameterForegroundColor               : DarkGray
TypeForegroundColor                    : Gray
NumberForegroundColor                  : White
MemberForegroundColor                  : White
DefaultTokenBackgroundColor            : DarkMagenta
CommentBackgroundColor                 : DarkMagenta
KeywordBackgroundColor                 : DarkMagenta
StringBackgroundColor                  : DarkMagenta
OperatorBackgroundColor                : DarkMagenta
VariableBackgroundColor                : DarkMagenta
CommandBackgroundColor                 : DarkMagenta
ParameterBackgroundColor               : DarkMagenta
TypeBackgroundColor                    : DarkMagenta
NumberBackgroundColor                  : DarkMagenta
MemberBackgroundColor                  : DarkMagenta
EmphasisForegroundColor                : Cyan
EmphasisBackgroundColor                : DarkMagenta
ErrorForegroundColor                   : Red
ErrorBackgroundColor                   : DarkMagenta
```

This command returns the list of available PSReadLine options and their current values.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe objects to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.PSConsoleReadLineOptions

## NOTES

## RELATED LINKS

[Remove-PSReadLineKeyHandler](Remove-PSReadLineKeyHandler.md)

[Get-PSReadLineKeyHandler](Get-PSReadLineKeyHandler.md)

[Set-PSReadLineOption](Set-PSReadLineOption.md)

[Set-PSReadLineKeyHandler](Set-PSReadLineKeyHandler.md)