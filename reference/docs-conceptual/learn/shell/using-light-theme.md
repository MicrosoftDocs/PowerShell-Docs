---
description: >
  This article shows how to configure PSReadLine color settings for a light themed terminal.
ms.date: 12/17/2022
title: Configuring a light colored theme
---
# Configuring a light colored theme

The default colors for both PowerShell and **PSReadLine** are selected for a dark background
terminal. However, some users may choose to use a light background with dark text. Since most of the
default colors don't set the background, using light foreground colors on a light background
produces unreadable text.

**PSReadLine** allows you to define colors for 18 different syntax elements. You can view the
current settings using the `Get-PSReadLineOption` cmdlet.

```Output
EditMode                               : Windows
AddToHistoryHandler                    : System.Func`2[System.String,System.Object]
HistoryNoDuplicates                    : True
HistorySavePath                        : C:\Users\user1\AppData\Roaming\Microsoft\Wind...
HistorySaveStyle                       : SaveIncrementally
HistorySearchCaseSensitive             : False
HistorySearchCursorMovesToEnd          : False
MaximumHistoryCount                    : 4096
ContinuationPrompt                     : >>
ExtraPromptLineCount                   : 0
PromptText                             : {> }
BellStyle                              : Audible
DingDuration                           : 50
DingTone                               : 1221
CommandsToValidateScriptBlockArguments : {ForEach-Object, %, Invoke-Command, icm...}
CommandValidationHandler               :
CompletionQueryItems                   : 100
MaximumKillRingCount                   : 10
ShowToolTips                           : True
ViModeIndicator                        : None
WordDelimiters                         : ;:,.[]{}()/\|^&*-=+'"-—―
AnsiEscapeTimeout                      : 100
PredictionSource                       : HistoryAndPlugin
PredictionViewStyle                    : InlineView
CommandColor                           : "`e[93m"
CommentColor                           : "`e[32m"
ContinuationPromptColor                : "`e[37m"
DefaultTokenColor                      : "`e[37m"
EmphasisColor                          : "`e[96m"
ErrorColor                             : "`e[91m"
InlinePredictionColor                  : "`e[38;5;238m"
KeywordColor                           : "`e[92m"
ListPredictionColor                    : "`e[33m"
ListPredictionSelectedColor            : "`e[48;5;238m"
MemberColor                            : "`e[97m"
NumberColor                            : "`e[97m"
OperatorColor                          : "`e[90m"
ParameterColor                         : "`e[90m"
SelectionColor                         : "`e[30;47m"
StringColor                            : "`e[36m"
TypeColor                              : "`e[37m"
VariableColor                          : "`e[92m"
```

The color settings are stored as strings containing ANSI escape sequences that change the color in
your terminal. Using the `Set-PSReadLineOption` cmdlet you can change the colors to values that work
better for a light-colored background.

## Defining colors for a light theme

The PowerShell ISE can be configured to use a light theme for both the editor and console panes. You
can also view and change the colors that the ISE uses for various syntax and output types. You can
use these color choices to define a similar theme for **PSReadLine**.

The following hashtable defines colors for **PSReadLine** that mimic the colors in the PowerShell
ISE.

```powershell
$ISETheme = @{
    Command                  = $PSStyle.Foreground.FromRGB(0x0000FF)
    Comment                  = $PSStyle.Foreground.FromRGB(0x006400)
    ContinuationPrompt       = $PSStyle.Foreground.FromRGB(0x0000FF)
    Default                  = $PSStyle.Foreground.FromRGB(0x0000FF)
    Emphasis                 = $PSStyle.Foreground.FromRGB(0x287BF0)
    Error                    = $PSStyle.Foreground.FromRGB(0xE50000)
    InlinePrediction         = $PSStyle.Foreground.FromRGB(0x93A1A1)
    Keyword                  = $PSStyle.Foreground.FromRGB(0x00008b)
    ListPrediction           = $PSStyle.Foreground.FromRGB(0x06DE00)
    Member                   = $PSStyle.Foreground.FromRGB(0x000000)
    Number                   = $PSStyle.Foreground.FromRGB(0x800080)
    Operator                 = $PSStyle.Foreground.FromRGB(0x757575)
    Parameter                = $PSStyle.Foreground.FromRGB(0x000080)
    String                   = $PSStyle.Foreground.FromRGB(0x8b0000)
    Type                     = $PSStyle.Foreground.FromRGB(0x008080)
    Variable                 = $PSStyle.Foreground.FromRGB(0xff4500)
    ListPredictionSelected   = $PSStyle.Background.FromRGB(0x93A1A1)
    Selection                = $PSStyle.Background.FromRGB(0x00BFFF)
}
```

> [!NOTE]
> In PowerShell 7.2 and higher you can use the `FromRGB()` method of `$PSStyle` to create the ANSI
> escape sequences for the colors you want.
>
> For more information about `$PSStyle`, see [about_ANSI_Terminals][01].
>
> For more information about ANSI escape sequences, see the [ANSI escape code][04] article in
> Wikipedia.

## Setting the color theme in your profile

To have the color settings you want in every PowerShell session, you must add the configuration
settings to your PowerShell profile script. For an example, see
[Customizing your shell environment][02]

Add the `$ISETheme` variable and the following `Set-PSReadLineOption` command to your profile.

```powershell
Set-PSReadLineOption -Colors $ISETheme
```

Beginning in PowerShell 7.2, PowerShell adds colorized output to the default console experience. The
colors used are defined in the `$PSStyle` variable and are designed for a dark background. The
following settings work better for a light background terminal.

```powershell
$PSStyle.Formatting.FormatAccent       = "`e[32m"
$PSStyle.Formatting.TableHeader        = "`e[32m"
$PSStyle.Formatting.ErrorAccent        = "`e[36m"
$PSStyle.Formatting.Error              = "`e[31m"
$PSStyle.Formatting.Warning            = "`e[33m"
$PSStyle.Formatting.Verbose            = "`e[33m"
$PSStyle.Formatting.Debug              = "`e[33m"
$PSStyle.Progress.Style                = "`e[33m"
$PSStyle.FileInfo.Directory            = $PSStyle.Background.FromRgb(0x2f6aff) +
                                         $PSStyle.Foreground.BrightWhite
$PSStyle.FileInfo.SymbolicLink         = "`e[36m"
$PSStyle.FileInfo.Executable           = "`e[95m"
$PSStyle.FileInfo.Extension['.ps1']    = "`e[36m"
$PSStyle.FileInfo.Extension['.ps1xml'] = "`e[36m"
$PSStyle.FileInfo.Extension['.psd1']   = "`e[36m"
$PSStyle.FileInfo.Extension['.psm1']   = "`e[36m"
```

## Choosing colors for accessibility

The ISE color theme may not work for users with color-blindness or other conditions that limit their
ability to see colors.

The [World Wide Web Consortium (W3C)][05] has recommendations for using colors for accessibility.
The Web Content Accessibility Guidelines (WCAG) 2.1 recommends that "visual presentation of text and
images of text has a contrast ratio of at least 4.5:1." For more information, see
[Success Criterion 1.4.3 Contrast (Minimum)][06].

The [Contrast Ratio][03] website provides a tool that lets you pick foreground and background
colors and measure the contrast. You can use this tool to find color combinations that work best for
you.

<!-- link references -->
[01]: /powershell/module/Microsoft.PowerShell.Core/About/about_ANSI_Terminals
[02]: creating-profiles.md
[03]: https://contrast-ratio.com/
[04]: https://en.wikipedia.org/wiki/ANSI_escape_code
[05]: https://www.w3.org/
[06]: https://www.w3.org/TR/WCAG/#contrast-minimum
