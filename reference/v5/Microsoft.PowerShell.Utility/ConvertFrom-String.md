---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/?LinkID=507579
schema: 2.0.0
---

# ConvertFrom-String
## SYNOPSIS
Extracts and parses structured objects from string content.

## SYNTAX

### ByDelimiter (Default)
```
ConvertFrom-String [-Delimiter <String>] [-PropertyNames <String[]>] -InputObject <String>
```

### TemplateParsing
```
ConvertFrom-String [-TemplateFile <String[]>] [-TemplateContent <String[]>] [-IncludeExtent] [-UpdateTemplate]
 -InputObject <String>
```

## DESCRIPTION
You can run the ConvertFrom-String cmdlet to add structure to unstructured string content.
ConvertFrom-String generates an object by parsing text from a traditional text stream.
For each string in the pipeline, the cmdlet splits the input by either a delimiter or a parse expression, and then assigns property names to each of the resulting split elements.
You can provide these property names; if you do not, they are automatically generated for you.

The cmdlet's default parameter set, ByDelimiter, splits exactly on the regular expression delimiter.
It does not perform quote matching or delimiter escaping as the Import-Csv cmdlet does.

The cmdlet's alternate parameter set, TemplateParsing, generates elements from the groups that are captured by a regular expression.

This cmdlet supports two modes: basic delimited parsing, and automatically-generated, example-driven parsing.

Delimited parsing, by default, splits the input at white space, and assigns property names to the resulting groups.
You can customize the delimiter by piping the ConvertFrom-String results into one of the Format-* cmdlets, or by adding the Delimiter parameter.

The cmdlet also supports automatically-generated, example-driven parsing based on the FlashExtract research work by Microsoft Research.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>"Hello World" | ConvertFrom-String
```

The following example generates an object with default property names, P1 and P2.
The results are "P1=Hello" and "P2=World".

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>"Hello World" | ConvertFrom-String -Delimiter "ll"
```

The following example generates an object with "P1=He" and "P2=o World", by specifying the "ll" in "Hello " as the delimiter.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>"Phoebe Cat" | ConvertFrom-String -TemplateContent {PersonInfo*:{Name:Phoebe Cat}} PS C:\>$template = {PersonInfo*:{Name:Phoebe Cat}}
"Phoebe Cat" | ConvertFrom-String -TemplateContent $template
```

The following example uses an expression as the value of the TemplateContent parameter to instruct Windows PowerShell that the string you're piping to ConvertFrom-String has a property of Name.

You can also save the expression in a variable, then use the variable as the value of the TemplateContent parameter, as shown here.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>"Hello World" | ConvertFrom-String -PropertyNames FirstWord,SecondWord
```

The following example generates an object that contains two properties, FirstWord and SecondWord.
The results are "FirstWord=Hello" and "SecondWord=World.

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>"123 456" | ConvertFrom-String -PropertyNames String,Int
```

The following example generates an object with default property names P1 and P2, but property types String and Int (for Integer) are identified.
The results are "P1=123" and "P2=456".
The second property is an integer, not a string.

## PARAMETERS

### -Delimiter
A regular expression that identifies the boundary between elements.
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
Includes extent text property that is removed by default.

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
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -PropertyNames
One or more property names to which to assign split values in the resulting object.
Every line of text that you split or parse generates elements that represent property values.
If the element is the result of a capture group, and that capture group is named (for example, (?\<name\>) or (?'name') ), then the name of that capture group is assigned to the property.

If you provide any elements in the PropertyName array, those names are assigned to properties that have not yet been named.

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
Specifies an expression (or an expression saved as a variable) that describes the properties to which you want to assign strings.
The syntax of a template field specification is the following: {\[optional-typecast\]name(sequence-spec, for example *):example-value}.
An example is {PersonInfo*:{Name:Randolph LaBelle}.

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
Specifies a file that contains a template for the desired parsing of the string.
In the template file, properties and their values are enclosed in brackets, as shown in the following example.
If a property (such as the Name property in this example) (and its associated other properties) can appear multiple times, add an asterisk (*) to indicate that this results in multiple records (rather than extracting multiple properties into a single record.

{Name*:Ana Trujillo}

{City:Redmond}, {State:WA}

{Name*:Antonio Moreno}

{City:Renton}, {State:WA}

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
Saves the results of a learning algorithm into a comment in the template file.
This makes the algorithm learning process faster.
To use UpdateTemplate, you must also specify a template file with the TemplateFile parameter.

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

## INPUTS

### System.String

## OUTPUTS

## NOTES

## RELATED LINKS

[ConvertFrom-String: Example-based text parsing]()

[ConvertFrom-StringData]()

[ConvertFrom-Csv]()

[ConvertTo-Xml]()

