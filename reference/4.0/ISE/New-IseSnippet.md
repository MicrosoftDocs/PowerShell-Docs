---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=287357
external help file:  ISE-help.xml
title:  New-IseSnippet
---
# New-IseSnippet

## SYNOPSIS

Creates a Windows PowerShell ISE code snippet.

## SYNTAX

```
New-IseSnippet [-Title] <String> [-Description] <String> [-Text] <String> [-Author <String>]
 [-CaretOffset <Int32>] [-Force] [<CommonParameters>]
```

## DESCRIPTION

The **New-ISESnippet** cmdlet creates a reusable text "snippet" for Windows PowerShell ISE.
You can use snippets to add text to the Script pane or Command pane in Windows PowerShell ISE.
This cmdlet is available only in Windows PowerShell ISE.

Beginning in Windows PowerShell 3.0, Windows PowerShell ISE includes a collection of built-in snippets.
The **New-ISESnippet** cmdlet lets you create your own snippets to add to the built-in collection.
You can view, change, add, delete, and share snippet files and include them in Windows PowerShell modules.
To see  snippets in Windows PowerShell ISE, from the **Edit** menu, select **Start Snippets** or press CTRL+J.

The **New-ISESnippet** cmdlet creates a \<Title\>.Snippets.ps1xml file in the $home\Documents\WindowsPowerShell\Snippets directory with the title that you specify.
To include a snippet file in a module that you are authoring, add the snippet file to a Snippets subdirectory of your module directory.

You cannot use user-created snippets in a session in which the execution policy is **Restricted** or **AllSigned**.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Create a Comment-BasedHelp snippet
```
PS C:\> New-IseSnippet -Title Comment-BasedHelp -Description "A template for comment-based help." -Text "<#
    .SYNOPSIS
    .DESCRIPTION
    .PARAMETER  <Parameter-Name>
    .INPUTS
    .OUTPUTS
    .EXAMPLE
    .LINK
#>"
```

This command creates a Comment-BasedHelp snippet for Windows PowerShell ISE.
It creates a file named "Comment-BasedHelp.snippets.ps1xml" in the user's Snippets directory ($home\Documents\WindowsPowerShell\Snippets).

### Example 2: Create a mandatory snippet
```
PS C:\> $M = @'
Param
(
  [parameter(Mandatory=$true)]
  [String[]]
  $<ParameterName>
)
'@

PS C:\> New-ISESnippet -Text $M -Title Mandatory -Description "Adds a mandatory function parameter." -Author "Patti Fuller, Fabrikam Corp." -Force
```

This example creates a Mandatory snippet for Windows PowerShell ISE.
The first command saves the snippet text in the $M variable.
The second command uses the **New-ISESnippet** cmdlet to create the snippet.
The command uses the **Force** parameter to overwrite a previous snippet with the same name.

### Example 3: Copy a mandatory snippet from a folder to a destination folder
```
PS C:\> Copy-Item "$Home\Documents\WindowsPowerShell\Snippets\Mandatory.Snippets.ps1xml" -Destination "\\Server\Share"
```

This command uses the Copy-Item cmdlet to copy the Mandatory snippet from the folder where **New-ISESnippet** places it to the Server\Share file share.

Because the Snippets.ps1xml files that **New-ISESnippet** creates are text (XML) files, you can use the **Item** cmdlets to get, changes, move, rename, and copy them.

## PARAMETERS

### -Author

Identifies the author of the snippet.
The author field appears in the snippet file, but it does not appear when you click the snippet name in Windows PowerShell ISE.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None (no value)
Accept pipeline input: False
Accept wildcard characters: False
```

### -CaretOffset

Places the cursor on the specified character of the snippet text.
Enter an integer that represents the cursor position, with "1" representing the first character of text.
The default value, 0 (zero), places the cursor immediately before the first character of text.
This parameter does not indent the snippet text.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Provides a description of the snippet.
The description value appears when you click the snippet name in Windows PowerShell ISE.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Overwrites snippet files with the same name in the same location.
By default, **New-ISESnippet** does not overwrite files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text

Specifies the text value that is added when you select the snippet.
The snippet text appears when you click the snippet name in Windows PowerShell ISE.
This parameter is mandatory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title

Specifies a title or name for the snippet.
The title also names the snippet file.
This parameter is mandatory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet does not take input from the pipeline.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

- **New-IseSnippet** stores new user-created snippets in unsigned .ps1xml files. As such, Windows PowerShell cannot add them to a session in which the execution policy is **AllSigned** or **Restricted**. In a **Restricted** or **AllSigned** session, you can create, get, and import unsigned user-created snippets, but you cannot use them in the session.

If you use the **New-IseSnippet** cmdlet in a  **Restricted** or **AllSigned** session, the snippet is created, but an error message appears when Windows PowerShell tries to add the newly created snippet to the session.
To use the new snippet (and other unsigned user-created snippets), change the execution policy, and then restart Windows PowerShell ISE.

For more information about Windows PowerShell execution policies, see about_Execution_Policies.

- To change a snippet, edit the snippet file. You can edit snippet files in the Script pane of Windows PowerShell ISE.

- To delete a snippet that you added, delete the snippet file.

- You cannot delete a built-in snippet, but you can hide all built-in snippets by using the "$psise.Options.ShowDefaultSnippets=$false" command.

- You can create a snippet that has the same name as a built-in snippet. Both snippets appear in the snippet menu in Windows PowerShell ISE.

## RELATED LINKS

[Get-IseSnippet](Get-IseSnippet.md)

[Import-IseSnippet](Import-IseSnippet.md)