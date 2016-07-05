---
external help file: PSITPro5_Script.xml
online version: http://go.microsoft.com/fwlink/?LinkId=525913
schema: 2.0.0
---

# Get-ScriptAnalyzerRule
## SYNOPSIS
Gets rules that are used by Script Analyzer.

## SYNTAX

```
Get-ScriptAnalyzerRule [-CustomizedRulePath <String[]>] [-Name <String[]>] [-Severity <String[]>]
```

## DESCRIPTION
The Get-ScriptAnalyzerRule cmdlet gets all of the rules that work with the PSScriptAnalyzer module, and against which scripts are evaluated when you run the Invoke-ScriptAnalyzer cmdlet.
Each rule has the following properties: 

- Name
- CommonName
- Description
- Severity
- SourceType
- SourceName

CommonName is the display name of the rule.
Use the value of the Name property when you want to include or exclude a rule in script analysis.
The value of the Description property explains what in scripts might violate rules, and provides suggestions for improving your script.

## EXAMPLES

### Example 1: Get all Script Analyzer rules
```
PS C:\>Get-ScriptAnalyzerRule
```

This command gets all built-in Windows PowerShell Script Analyzer rules.

### Example 2: Get Script Analyzer rules by name
```
PS C:\>Get-ScriptAnalyzerRule -Name "PSAvoidUsingcmdletaliases, PSReservedCmdletChar"
SourceType SourceName   Name                      CommonName                 Description
---------- ----------   ----                      ----------                 -----------
Builtin    BuiltinRules PSAvoidUsingCmdletAliases Avoid Using Cmdlet Aliases An alias is an alternate name or nickname... 
Builtin    BuiltinRules PSReservedCmdletChar      Reserved Cmdlet Chars      Checks for reserved characters in cmdlet ...
```

This command gets the PSAvoidUsingcmdletaliases and PSReservedCmdletChar rules.

### Example 3: Use a wildcard to get Script Analyzer rules
```
PS C:\>Get-ScriptAnalyzerRule -Name "PSAvoid*"
```

This command gets rules with names that begin with PSAvoid.
The Name parameter accepts wildcard characters.

### Example 4: Get Script Analyzer rules by severity
```
PS C:\>Get-ScriptAnalyzerRule -Severity "Information, Error"
```

This command specifies the Severity parameter to get rules that have the specified severity levels.

### Example 5: Get customized Script Analyzer rules
```
PS C:\>Get-ScriptAnalyzerRule -CustomizedRulePath "D:\CommunityRules"
```

This command gets rules that have been customized or created by Windows PowerShell users.
You specify the CustomizedRulePath parameter to specify a path to where custom (not the built-in Windows PowerShell rules) are stored.
In this example, the rules are stored in the CommunityRules folder on the D:\ drive.

## PARAMETERS

### -CustomizedRulePath
Specifies the path to a customized or user-created module or assembly of rules.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies an array of rule names.
The value of this parameter is taken from the Name property of a rule.
Separate multiple names with commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -Severity
Specifies an array of severity levels.
If you specify this parameter, only results that match the specified severity levels are displayed.
The acceptable values for this parameter are:

- Warning
- Error
- Strict

Separate multiple severity levels with commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### Microsoft.Windows.Powershell.ScriptAnalyzer.Generic.RuleInfo

## NOTES

## RELATED LINKS

[Invoke-ScriptAnalyzer](2e2f93fe-7407-4e05-bbee-0511dcab7285)

