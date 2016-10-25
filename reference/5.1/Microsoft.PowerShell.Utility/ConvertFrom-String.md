---
author: jpjofre
description: 
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell, cmdlet
manager: carolz
ms.date: 2016-10-11
ms.prod: powershell
ms.technology: powershell
ms.topic: reference
online version: http://go.microsoft.com/fwlink/?LinkId=822386
schema: 2.0.0
title: ConvertFrom-String
---

# ConvertFrom-String

## SYNOPSIS
Extracts and parses structured objects from string content.

## SYNTAX

### ByDelimiter (Default)
```
ConvertFrom-String [-Delimiter <String>] [-PropertyNames <String[]>] [-InputObject] <String>
 [<CommonParameters>]
```

### TemplateParsing
```
ConvertFrom-String [-TemplateFile <String[]>] [-TemplateContent <String[]>] [-IncludeExtent] [-UpdateTemplate]
 [-InputObject] <String> [<CommonParameters>]
```

## DESCRIPTION
The **ConvertFrom-String** cmdlet extracts and parses structured objects from string content.
This cmdlet generates an object by parsing text from a traditional text stream.
For each string in the pipeline, the cmdlet splits the input by either a delimiter or a parse expression, and then assigns property names to each of the resulting split elements.
You can provide these property names; if you do not, they are automatically generated for you.

The cmdlet's default parameter set, *ByDelimiter*, splits exactly on the regular expression delimiter.
It does not perform quote matching or delimiter escaping as the Import-Csv cmdlet does.

The cmdlet's alternate parameter set, *TemplateParsing*, generates elements from the groups that are captured by a regular expression.

This cmdlet supports two modes: basic delimited parsing, and automatically-generated, example-driven parsing.

Delimited parsing, by default, splits the input at white space, and assigns property names to the resulting groups.
You can customize the delimiter by piping the **ConvertFrom-String** results into one of the Format-* cmdlets, or you can use the *Delimiter* parameter.

The cmdlet also supports automatically-generated, example-driven parsing based on the **FlashExtract** research work by Microsoft Researchhttp://research.microsoft.com/.

## EXAMPLES

### Example 1: Generate an object with default property names
```
PS C:\>"Hello World" | ConvertFrom-String
```

This command generates an object with default property names, P1 and P2.
The results are P1=Hello and P2=World.

### Example 2: Generate an object with default property names using a delimiter
```
PS C:\>"Hello World" | ConvertFrom-String -Delimiter "ll"
```

This command generates an object with P1=He and P2=o World, by specifying the ll in Hello  as the delimiter.

### Example 3: Use an expression as the value of the TemplateContent parameter
```
PS C:\>"Phoebe Cat" | ConvertFrom-String -TemplateContent {PersonInfo*:{Name:Phoebe Cat}} PS C:\>$Template = {PersonInfo*:{Name:Phoebe Cat}}
"Phoebe Cat" | ConvertFrom-String -TemplateContent $Template
```

This command uses an expression as the value of the *TemplateContent* parameter to instruct Windows PowerShell that the string that is used on the pipeline to **ConvertFrom-String** has a property of **Name**.

You can also save the expression in a variable, then use the variable as the value of the *TemplateContent* parameter, as shown here.

### Example 4: Generate an object that contains two properties
```
PS C:\>"Hello World" | ConvertFrom-String -PropertyNames FirstWord,SecondWord
```

This command generates an object that contains two properties, FirstWord and SecondWord.
The results are FirstWord=Hello and SecondWord=World.

### Example 5: Generate two objects of different object types
```
PS C:\>"123 456" | ConvertFrom-String -PropertyNames String,Int
```

This command generates an object with default property names P1 and P2, but property types String and Integer are identified.
The results are P1=123 and P2=456.
The second property is an integer, not a string.

## PARAMETERS

### -Delimiter
Specifies a regular expression that identifies the boundary between elements.
Elements that are created by the split become properties in the resulting object.
The delimiter is ultimately used in a call to System.Text.RegularExpressions.RegularExpression.Split().

```yaml
Type: String
Parameter Sets: ByDelimiter
Aliases: DEL

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeExtent
Indicates that this cmdlet includes an extent text property that is removed by default.

```yaml
Type: SwitchParameter
Parameter Sets: TemplateParsing
Aliases: IE

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies strings received from the pipeline, or a variable that contains a string object.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -PropertyNames
Specifies an array of property names to which to assign split values in the resulting object.
Every line of text that you split or parse generates elements that represent property values.
If the element is the result of a capture group, and that capture group is named (for example, (?\<name\>) or (?'name') ), then the name of that capture group is assigned to the property.

If you provide any elements in the *PropertyName* array, those names are assigned to properties that have not yet been named.

If you provide more property names than there are fields, Windows PowerShell ignores the extra property names.
If you do not specify enough property names to name all fields, Windows PowerShell automatically assigns numerical property names to any properties that are not named: P1, P2, etc.

```yaml
Type: String[]
Parameter Sets: ByDelimiter
Aliases: PN

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateContent
Specifies an expression, or an expression saved as a variable, that describes the properties to which this cmdlet assigns strings.
The syntax of a template field specification is the following: {\[optional-typecast\]name(sequence-spec, for example *):example-value}.
An example is {PersonInfo*:{Name:Patti Fuller}.

```yaml
Type: String[]
Parameter Sets: TemplateParsing
Aliases: TC

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateFile
Specifies a file, as an array, that contains a template for the desired parsing of the string.
In the template file, properties and their values are enclosed in brackets, as shown in the following example.
If a property, such as the Name property and its associated other properties, appears multiple times, you can add an asterisk (*) to indicate that this results in multiple records.
This avoids extracting multiple properties into a single record.

{Name*:David Chew}

{City:Redmond}, {State:WA}

{Name*:Evan Narvaez}    {Name*:Antonio Moreno}

{City:Issaquah}, {State:WA}

```yaml
Type: String[]
Parameter Sets: TemplateParsing
Aliases: TF

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdateTemplate
Indicates that this cmdlet saves the results of a learning algorithm into a comment in the template file.
This makes the algorithm learning process faster.
To use this parameter, you must also specify a template file with the *TemplateFile* parameter.

```yaml
Type: SwitchParameter
Parameter Sets: TemplateParsing
Aliases: UT

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

## NOTES

## RELATED LINKS

[ConvertFrom-String: Example-based text parsing](http://blogs.msdn.com/b/powershell/archive/2014/10/31/convertfrom-string-example-based-text-parsing.aspx)

[ConvertFrom-StringData](ConvertFrom-StringData.md)

[ConvertFrom-Csv](ConvertFrom-Csv.md)

[ConvertTo-Xml](ConvertTo-Xml.md)

