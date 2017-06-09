---
ms.date:  2017-06-09
keywords:  powershell,cmdlet
external help file:  Pester-help.xml
---

# Describe

## SYNOPSIS
Creates a logical group of tests. 
All Mocks and TestDrive contents
defined within a Describe block are scoped to that Describe; they
will no longer be present when the Describe block exits. 
A Describe
block may contain any number of Context and It blocks.

## SYNTAX

```
Describe [-Name] <String> [-Tags <Object>] [[-Fixture] <ScriptBlock>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
function Add-Numbers($a, $b) {
```

return $a + $b
}

Describe "Add-Numbers" {
    It "adds positive numbers" {
        $sum = Add-Numbers 2 3
        $sum | Should Be 5
    }

    It "adds negative numbers" {
        $sum = Add-Numbers (-2) (-2)
        $sum | Should Be (-4)
    }

    It "adds one negative number to positive number" {
        $sum = Add-Numbers (-2) 2
        $sum | Should Be 0
    }

    It "concatenates strings if given strings" {
        $sum = Add-Numbers two three
        $sum | Should Be "twothree"
    }
}

## PARAMETERS

### -Name
The name of the test group.
This is often an expressive phrase describing the scenario being tested.

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

### -Tags
Optional parameter containing an array of strings. 
When calling Invoke-Pester, it is possible to
specify a -Tag parameter which will only execute Describe blocks containing the same Tag.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -Fixture
The actual test script.
If you are following the AAA pattern (Arrange-Act-Assert), this
typically holds the arrange and act sections.
The Asserts will also lie in this block but are
typically nested each in its own It block.
Assertions are typically performed by the Should
command within the It blocks.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: $(Throw "No test script block is provided. (Have you put the open curly brace on the next line?)")
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[It
Context
Invoke-Pester
about_Should
about_Mocking
about_TestDrive]()

