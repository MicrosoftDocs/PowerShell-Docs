---
description: This article contains the list of changes for each released version of PSReadLine.
Locale: en-US
ms.date: 09/17/2024
online version: https://learn.microsoft.com/powershell/module/psreadline/about/about_psreadline_release_notes?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_PSReadLine_Release_Notes
---
# about_PSReadLine_Release_Notes

This is a summary of changes to the **PSReadLine** module. For a full list of
changes, see the **PSReadLine** [ChangeLog][01].

- Current preview: v2.4.0-beta0
- Current stable release: v2.3.5

## PSReadLine release history

There have been many updates to PSReadLine since the version that ships in
Windows PowerShell 5.1.

- v2.3.5 first shipped in PowerShell 7.4.2 and 7.5.0-preview.3
- v2.3.4 first shipped in PowerShell 7.4.0-rc.1
- v2.2.6 first shipped in PowerShell 7.3.0
- v2.1.0 first shipped in PowerShell 7.2.5
- v2.0.4 first shipped in PowerShell 7.0.11
- v2.0.0 ships in Windows PowerShell 5.1

## Release Notes

### v2.4.0-beta0 - 2024-03-01

- Fix copying text to system clipboard on Linux using `xclip`
- Tab completion uses the correct directory separator for the platform
- PowerShell version 5.1 is now the minimum supported version
- Get the Windows keyboard layout from the parent terminal process
- Fix a few VI key handlers to correctly close the edit group
- Read the history file in the streaming way to handle large files efficiently

### v2.3.5 - 2024-04-02

This is a servicing release that excludes test components from SBOM generation.

### v2.3.4 - 2023-10-02

In addition to several bug fixes, this release includes the following
enhancements:

- Scrollable **ListView** for Predictive IntelliSense
  - Autoadjusts the size based on the size of the terminal window
  - Can contain up to 50 prediction results
  - Dynamic list header that shows the number of results and the current
    prediction source
  - Show tooltips in the prediction list view
- Improved sensitive history scrubbing to allow retrieving token from `az`,
  `gcloud`, and `kubectl`
- Improve the default sensitive history scrubbing to allow safe property access
- Added support for upcasing, downcasing, and capitalizing words
- Make tab completion show results whose `ListItemText` are different by case
  only
- Supports the text-object command `<d,i,w>` in the VI edit mode
- Change default color for inline prediction to dim
- Add a sample to README for transforming Unicode code point to Unicode char by
  `Alt+x`
- Add the `TerminateOrphanedConsoleApps` option on Windows to kill orphaned
  console-attached process that may mess up reading from Console input
- De-duplicate prediction results with the history results
- Make tab completion show results whose `ListItemText` are different by case only
- Add support for upcasing, downcasing, and capitalizing word
- Handle multi-line description for parameter help content

### v2.2.6 - 2022-06-27

In this release, the Predictive IntelliSense feature is enabled by default
depending on the following conditions:

- If Virtual Terminal (VT) is supported and PSReadLine running in PowerShell
  7.2 or higher, **PredictionSource** is set to `HistoryAndPlugin`
- If VT is supported and PSReadLine running in PowerShell prior to 7.2,
  **PredictionSource** is set to `History`
- If VT isn't supported, **PredictionSource** is set to `None`

### v2.2.5 - 2022-05-03

Official servicing release with minor bug fixes.

### v2.2.3 - 2022-04-20

- Respect cancellation in `ReadOneOrMoreKeys()`

### v2.2.2 - 2022-02-22

- PSReadLine added two new predictive IntelliSense features:
  - Added the **PredictionViewStyle** parameter to allow for the selection of
    the new `ListView`.
  - Connected PSReadLine to the `CommandPrediction` APIs introduced in
    PowerShell 7.2 to allow a user can import a predictor module that can
    render the suggestions from a custom source.
- Updated to use the 1.0.0 version of `Microsoft.PowerShell.Pager` for
  dynamic help
- Improved the scrubbing of sensitive history items
- Make `Ctrl+r` and `Ctrl+s` in `Vi` edit mode work the same way as in `Emacs`
  edit mode
- Make `d0` to delete to the start of the current logical line in a multiline
  buffer in VI mode
- Use `d^` to delete from the first non-blank character of a logical line
- VI Mode: `Undo` now leaves the cursor under the position at the start of the
  deletion
- Make `HistorySearchBackward` and `HistorySearchForward` able to navigate the
  list view
- Add the `SelectCommandArgument` bind-able function
- Remove `LineIsMultiline` in favor of multi-line agnostic algorithms
- Lots of bug fixes and smaller improvements

### v2.1.0 - 2020-11-02

This release rolls up the following enhancements added since the 2.0.4
release:

- Add Predictive IntelliSense suggestions from the command history
- Many bug fixes and API enhancements

### v2.0.4 - 2020-08-05

- vi-mode: Make `dd` deletes the logical line instead of the entire buffer
- vi-mode: Add `dG` to delete to the end of multiline buffer
- vi-mode: `dd` now handles single line or multiline buffers consistently
- vi-mode: Make `D` and `d$` delete to the end of the current logical line
- vi-mode - Make `dj` delete the current and next `n` logical lines
- vi-mode: Use `dk` to delete the previous `n` logical lines and the current
  logical line in a multi-line buffer
- vi-mode: Add `dgg` to delete from the beginning of the buffer to the current
  logical line
- Rename `PredictionColor` to `InlinePredictionColor`
- Allow `MaximumHistoryCount` to be set from user's profile
- Add the parameter `-PredictionSource` to `Set-PSReadLineOption`, with the options `None` and `History`
- Make the functions `AcceptSuggestion` and `AcceptNextSuggestionWord` bindable
- Relax the sensitive words we filter by changing `key` to `apikey` to reduce false positives
- Make `ViForwardChar` able to accept suggestions
- Expose `ViBackwardChar` and `ViForwardChar` as bindable functions

### v2.0.3 - 2020-07-22

- Minor bug fixes

### v2.0.2 - 2020-06-05

- Run script in local scope to make PSReadLine works in PSES in
  `ConstrainedLanguageMode`
- Other bug fixes

### v2.0.1 - 2020-04-01

- Add the `-Chord` parameter to `Get-PSReadLineKeyHandler` to allow searching
  for specific key bindings
- Other minor bug fixes

### v2.0.0 - 2020-02-11

- Allow `InsertPairedBraces` to wrap selected text
- Lots of bug fixes and smaller improvements
- Filter sensitive history items and avoid writing them to the history file
- Supporting line-wise yanks, including paste and undo
- Make `y0` yank up to the start of the logical line in `VI` mode
- Add API to detect if the screen reader is active
- Make `PageUp/PageDown` and `CtrlPageUp/CtrlPageDown` windows only
- Add script block vi mode indicator option
- Support vi mode `G` and `gg` movements in multi-line buffers
- Supports `_` and `$` to move to the beginning and end of the logical line in
  vi mode
- Add `xtermjs` keybindings
- Support `Ctrl+u` in vi insert mode
- Enable `Ctrl+c` on non-Windows
- Interactive filtering during menu complete
- `Shift+Insert` bound to Paste in Windows mode
- `Ctrl+t` bound to `SwapCharacters` in Emacs mode
- `Ctrl+x,Ctrl+e` bound to `ViEditVisually` in Emacs
- `HistoryNoDuplicates` is now on by default

<!-- link references -->
[01]: https://github.com/PowerShell/PSReadLine/blob/master/PSReadLine/Changes.txt
