---
external help file: PSITPro5_Script.xml
online version: http://go.microsoft.com/fwlink/?LinkId=525914
schema: 2.0.0
---

# Invoke-ScriptAnalyzer
## SYNOPSIS
Starts analyzing a specified script by using Script Analyzer.

## SYNTAX

```
Invoke-ScriptAnalyzer [-Path] <String> [-CustomizedRulePath <String[]>] [-ExcludeRule <String[]>]
 [-IncludeRule <String[]>] [-LoggerPath <String[]>] [-Recurse] [-Severity <String[]>]
```

## DESCRIPTION
The Invoke-ScriptAnalyzer cmdlet starts analyzing one or more specified scripts by using Script Analyzer, evaluating your scripts against a set of best practice measures called rules.
Script Analyzer works by evaluating scripts against either all available rules, or against a set of rules that you specify by adding the ExcludeRule or IncludeRule parameters.
After Script Analyzer finishes evaluating your scripts, it displays results in the console window.

Script Analyzer works on .ps1 and .psm1 files.
Although you can run this release of Script Analyzer on DSC resources, the output might not be as helpful; this functionality is not fully available in this release.

Windows PowerShell includes many built-in rules, but Script Analyzer can also use customized rules that you write in Windows PowerShell scripts, or compile in assemblies by using C#.
Just as with the built-in rules, you can add the ExcludeRule and IncludeRule parameters to your Invoke-ScriptAnalyzer command to exclude or include custom rules.

Invoke-ScriptAnalyzer lets you specify a customized logger assembly by adding the LoggerPath parameter.
A logger is a tool that monitors the progress or output when you are using a cmdlet.
A customized logger lets you track elements of cmdlet use that you want to track.
The customized logger must be defined by using C#, and compiled as an assembly.

You can specify the Severity parameter to filter results by severity level.

## EXAMPLES

### Example 1: Analyze a script by name
```
PS C:\>Invoke-ScriptAnalyzer -Path "D:\test_scripts\Test-Script.ps1"
```

This command runs Script Analyzer on one script, Test-Script.ps1.
The command applies all default rules on script files in the specified path.

### Example 2: Analyze all scripts in a folder
```
PS C:\>Invoke-ScriptAnalyzer -Path "D:\test_scripts"
```

This command runs Script Analyzer on all scripts that are stored in the folder D:\test_scripts.

### Example 3: Analyze scripts recursively
```
PS C:\>Invoke-ScriptAnalyzer -Path "d:\test_scripts" -Recurse
```

This example adds the Recurse parameter to analyze script files in the directory specified by the Path parameter, and in all of its subfolders.

### Example 4: Analyze a script with a specified rule
```
PS C:\>Invoke-ScriptAnalyzer -Path "C:\users\test\Documents\demo\Test-Script.ps1" -IncludeRule "PSAvoidUsingCmdletAliases"
```

This example runs Script Analyzer on the Test-Script.ps1 script, and instructs Script Analyzer to include only the built-in rule, PSAvoidUsingCmdletAliases, in its analysis.

### Example 5: Analyze a script and exclude specified rules
```
PS C:\>Invoke-ScriptAnalyzer -Path "d:\test_scripts\Test-Script.ps1" -ExcludeRule "PSAvoidUsingCmdletAliases","PSAvoidUsingInternalURLs"
```

This example runs Script Analyzer on the Test-Script.ps1 script, and instructs Script Analyzer to exclude the built-in rules, PSAvoidUsingCmdletAliases and PSAvoidUsingInternalURLs, from its analysis.

### Example 6: Analyze a script and filter for severity
```
PS C:\>Invoke-ScriptAnalyzer -Path "D:\test_scripts\Test-Script.ps1" -Severity "Warning"
```

This example runs Script Analyzer on the Test-Script.ps1 script, and instructs Script Analyzer to show only those results with a severity level of Warning.

### Example 7: Analyze a script with customized rules
```
PS C:\>Invoke-ScriptAnalyzer -Path d:\test_scripts\test.ps1 Invoke-ScriptAnalyzer -Path "D:\test_scripts\Test-Script.ps1" -CustomizedRulePath "C:\CommunityAnalyzerRules"
```

This example runs Script Analyzer on the Test-Script.ps1 script, but adds the CustomizedRulePath parameter to instruct Script Analyzer to evaluate the script against user-created rules in C:\CommunityAnalyzerRules.

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

### -ExcludeRule
Specifies the names of one or more rules that you want Script Analyzer to exclude from the evalution process.
Use the value of the Name property when you want to exclude a rule from script analysis.
Separate multiple rule names with commas.

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

### -IncludeRule
Specifies the names of one or more rules that you want Script Analyzer to include in the evalution process.

When you specify the IncludeRule parameter, only the specified rules are applied to the analysis.
Use the value of the Name property when you want to include a rule in script analysis.
Separate multiple rule names with commas.

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

### -LoggerPath
Specifies one or more paths to customized logger assemblies.
Separate multiple paths with commas.

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

### -Path
Specifies a path to a script file that you want to analyze, or to a folder that contains multiple scripts that you want to analyze.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PSPath

Required: True
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Recurse
Applies rules to script files in the specified path, and in all subfolders.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Severity
If you add this parameter, the DiagnosticRecord displays only results that match the specified severity levels.
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

### Microsoft.Windows.Powershell.ScriptAnalyzer.Generic.DiagnosticRecord

## NOTES

## RELATED LINKS

[Get-ScriptAnalyzerRule](8d1e6be7-ddd3-4907-a829-abe2587924de)

