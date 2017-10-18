---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Reserved_Words
---

# About Reserved Words

## SHORT DESCRIPTION

Lists the reserved words that cannot be used as identifiers because they
have a special meaning in PowerShell.

## LONG DESCRIPTION

There are certain words that have special meaning in PowerShell. When these
words appear without quotation marks, PowerShell attempts to apply their
special meaning rather than treating them as character strings. To use these
words as parameter arguments in a command or script without invoking their
special meaning, enclose the reserved words in quotation marks.

The following are the reserved words in PowerShell:

```
assembly         exit            process
base             filter          public
begin            finally         return
break            for             sequence
catch            foreach         static
class            from (*)        switch
command          function        throw
configuration    hidden          trap
continue         if              try
data             in              type
define (*)       inlinescript    until
do               interface       using
dynamicparam     module          var (*)
else             namespace       while
elseif           parallel        workflow
end              param
enum             private

(*) These keywords are reserved for future use.
```

For more information about language statements, including Foreach, If, For,
and While, type "Get-help", type the prefix "about_", and then type the name
of the statement. For example, to get information about the Foreach statement,
type:

```powershell
Get-Help about_ForEach
```

For information about the Filter statement or the Return statement syntax,
type:

```powershell
Get-Help about_Functions
```

For information about other reserved words, type:

```powershell
Get-Help <Reserved_Word>
```

## SEE ALSO

- [about_Command_Syntax](about_Command_Syntax.md)
- [about_Escape_Characters](about_Escape_Characters.md)
- [about_Language_Keywords](about_Language_Keywords.md)
- [about_Parsing](about_Parsing.md)
- [about_Quoting_Rules](about_Quoting_Rules.md)
- [about_Script_Blocks](about_Script_Blocks.md)
- [about_Special_Characters](about_Special_Characters.md)
