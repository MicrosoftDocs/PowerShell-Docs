---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_Command_Syntax
ms.technology:  powershell
ms.assetid:  f39782e8-fe76-46ea-b8b5-b50bbee8da4b
---

# about_Command_Syntax
Insert introduction here.  
  
## TOPIC  
 about\_Command\_Syntax  
  
## SHORT DESCRIPTION  
 Describes the syntax diagrams that are used in [!INCLUDE[wps_1]()].  
  
## LONG DESCRIPTION  
 The Get\-Help and Get\-Command cmdlets display syntax diagrams to help you construct commands correctly. This topic explains how to interpret the syntax diagrams.  
  
### SYNTAX DIAGRAMS  
 Each paragraph in a command syntax diagram represents a valid form of the command.  
  
 To construct a command, follow the syntax diagram from left to right. Select from among the optional parameters and provide values for the placeholders.  
  
 [!INCLUDE[wps_2]()]uses the following notation for syntax diagrams.  
  
```  
<command-name> -<Required Parameter Name> <Required Parameter Value>  
               [-<Optional Parameter Name> <Optional Parameter Value>]   
               [-<Optional Switch Parameters>]   
               [-<Optional Parameter Name>] <Required Parameter Value>  
  
```  
  
 The following is the syntax for the New\-Alias cmdlet.  
  
```  
New-Alias [-Name] <string> [-Value] <string> [-Description <string>]  
    [-Force] [-Option {None | ReadOnly | Constant | Private | AllScope}]  
    [-PassThru] [-Scope <string>] [-Confirm] [-WhatIf] [<CommonParameters>]  
  
```  
  
 The syntax is capitalized for readability, but [!INCLUDE[wps_2]()] is case\-insensitive.  
  
 The syntax diagram has the following elements.  
  
### COMMAND NAME  
 \-\-\-\-\-\-\-\-\-\-\-\-  
  
 Commands always begin with a command name, such as New\-Alias. Type the command name or its alias, such a "gcm" for Get\-Command.  
  
### PARAMETERS  
 \-\-\-\-\-\-\-\-\-\-  
  
 The parameters of a command are options that determine what the command does. Some parameters take a "value," which is user input to the command.  
  
 For example, the Get\-Help command has a Name parameter that lets you specify the name of the topic for which help is displayed. The topic name is the value of the Name parameter.  
  
 In a [!INCLUDE[wps_2]()]command, parameter names always begin with a hyphen. The hyphen tells [!INCLUDE[wps_2]()]that the item in the command is a parameter name.  
  
 For example, to use the Name parameter of New\-Alias, you type the following:  
  
```  
-Name  
  
```  
  
 Parameters can be mandatory or optional. In a syntax diagram, optional items are enclosed in brackets \(\[ \]\).  
  
 For more information about parameters, see about\_Parameters.  
  
### PARAMETER VALUES  
 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
  
 A parameter value is the input that the parameter takes. Because [!INCLUDE[wps_2]()] is based on the Microsoft .NET Framework, parameter values are represented in the syntax diagram by their .NET type.  
  
 For example, the Name parameter of Get\-Help takes a String value, which is a text string, such as a single word or multiple words enclosed in quotation marks.  
  
```  
[-Name] <string>  
  
```  
  
 The .NET type of a parameter value is enclosed in angle brackets \(\< \>\) to indicate that it is placeholder for a value and not a literal that you type in a command.  
  
 To use the parameter, replace the .NET type placeholder with an object that has the specified .NET type.  
  
 For example, to use the Name parameter, type "\-Name" followed by a string, such as the following:  
  
```  
-Name MyAlias  
  
```  
  
### PARAMETERS WITH NO VALUES  
 \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-  
  
 Some parameters do not accept input, so they do not have a parameter value. Parameters without values are called "switch parameters" because they work like on\/off switches. You include them \(on\) or you omit them \(off\) from a command.  
  
 To use a switch parameter, just type the parameter name, preceded by a hyphen.  
  
 For example, to use the WhatIf parameter of the New\-Alias cmdlet, type the following:  
  
```  
-WhatIf  
  
```  
  
### PARAMETER SETS  
 \-\-\-\-\-\-\-\-\-\-\-\-\-\-  
  
 The parameters of a command are listed in parameter sets. Parameter sets look like the paragraphs of a syntax diagram.  
  
 The New\-Alias cmdlet has one parameter set, but many cmdlets have multiple parameter sets. Some of the cmdlet parameters are unique to a parameter set, and others appear in multiple parameter sets.  
  
 Each parameter set represents the format of a valid command. A parameter set includes only parameters that can be used together in a command. If parameters cannot be used in the same command, they appear in separate parameter sets.  
  
 For example, the Get\-Random cmdlet has the following parameter sets:  
  
```  
Get-Random [[-Maximum] <Object>] [-Minimum <Object>] [-SetSeed <int>]  
            [<CommonParameters>]  
```  
  
```  
Get-Random [-InputObject] <Object[]> [-Count <int>] [-SetSeed <int>]  
           [<CommonParameters>]  
```  
  
 The first parameter set, which returns a random number, has the Minimum and Maximum parameters. The second parameter set, which returns a randomly selected object from a set of objects, includes the InputObject and Count parameters. Both parameter sets have the Set\-Seed parameter and the common parameters.  
  
 These parameter sets indicate that you can use the InputObject and Count parameters in the same command, but you cannot use the Maximum and Count parameters in the same command.  
  
 You indicate which parameter set you want to use by using the parameters in that parameter set.  
  
 However, every cmdlet also has a default parameter set. The default parameter set is used when you do not specify parameters that are unique to a parameter set. For example, if you use Get\-Random without parameters, [!INCLUDE[wps_2]()] assumes that you are using the Number parameter set and it returns a random number.  
  
 In each parameter set, the parameters appear in position order. The order of parameters in a command matters only when you omit the optional parameter names. When parameter names are omitted, [!INCLUDE[wps_2]()] assigns values to parameters by position and type. For more information about parameter position, see about\_Parameters.  
  
### SYMBOLS IN SYNTAX DIAGRAMS  
 The syntax diagram lists the command name, the command parameters, and the parameter values. It also uses symbols to show how to construct a valid command.  
  
 The syntax diagrams use the following symbols:  
  
 \-\- A hyphen \(\-\) indicates a parameter name. In a command, type the hyphen immediately before the parameter name with no intervening spaces, as shown in the syntax diagram.  
  
 For example, to use the Name parameter of New\-Alias, type:  
  
```  
-Name  
  
```  
  
 \-\- Angle brackets \(\<\>\) indicate placeholder text. You do not type the angle brackets or the placeholder text in a command. Instead, you replace it with the item that it describes.  
  
 Angle brackets are used to identify the .NET type of the value that a parameter takes. For example, to use the Name parameter of the New\-Alias cmdlet, you replace the \<string\> with a string, which is a single word or a group of words that are enclosed in quotation marks.  
  
 \-\- Brackets \(\[ \]\) indicate optional items. A parameter and its value can be optional, or the name of a required parameter can be optional.  
  
 For example, the Description parameter of New\-Alias and its value are enclosed in brackets because they are both optional.  
  
```  
[-Description <string>]  
  
```  
  
 The brackets also indicate that the Name parameter value \(\<string\>\) is required, but the parameter name, "Name," is optional.  
  
```  
[-Name] <string>  
  
```  
  
 \-\- A right and left bracket \(\[\]\) appended to a .NET type indicates that the parameter can accept one or multiple values of that type. Enter the values in a comma\-separated list.  
  
 For example, the Name parameter of the New\-Alias cmdlet takes only one string, but the Name parameter of Get\-Process can take one or many strings.  
  
```  
New-Alias [-Name] <string>  
  
     New-Alias -Name MyAlias  
  
Get-Process [-Name] <string[]>  
  
     Get-Process -Name Explorer, Winlogon, Services  
  
```  
  
 \-\- Braces \({}\) indicate an "enumeration," which is a set of valid values for a parameter.  
  
 The values in the braces are separated by vertical bars \( &#124; \). These bars indicate an "exclusive or" choice, meaning that you can choose only one value from the set of values that are listed inside the braces.  
  
 For example, the syntax for the New\-Alias cmdlet includes the following value enumeration for the Option parameter:  
  
```  
-Option {None | ReadOnly | Constant | Private | AllScope}  
  
```  
  
 The braces and vertical bars indicate that you can choose any one of the listed values for the Option parameter, such as ReadOnly or AllScope.  
  
```  
-Option ReadOnly  
  
```  
  
### OPTIONAL ITEMS  
 Brackets \(\[\]\) surround optional items. For example, in the New\-Alias cmdlet syntax description, the Scope parameter is optional. This is indicated in the syntax by the brackets around the parameter name and type:  
  
```  
[-Scope <string>]  
  
```  
  
 Both the following examples are correct uses of the New\-Alias cmdlet:  
  
```  
New-Alias -Name utd -Value Update-TypeData  
New-Alias -Name utd -Value Update-TypeData -Scope global  
  
```  
  
 A parameter name can be optional even if the value for that parameter is required. This is indicated in the syntax by the brackets around the parameter name but not the parameter type, as in this example from the New\-Alias cmdlet:  
  
```  
[-Name] <string> [-Value] <string>  
  
```  
  
 The following  commands correctly use the New\-Alias cmdlet. The commands produce the same result.  
  
```  
New-Alias -Name utd -Value Update-TypeData  
New-Alias -Name utd Update-TypeData  
New-Alias utd -Value Update-TypeData  
New-Alias utd Update-TypeData  
  
```  
  
 If the parameter name is not included in the statement as typed, [!INCLUDE[wps_2]()] tries to use the position of the arguments to assign the values to parameters.  
  
 The following example is not complete:  
  
```  
New-Alias utd  
  
```  
  
 This cmdlet requires values for both the Name and Value parameters.  
  
 In syntax examples, brackets are also used in naming and casting to .NET Framework types. In this context, brackets do not indicate an element is optional.  
  
### KEYWORDS  
 about\_Symbols  
  
 about\_Punctuation  
  
 about\_Help\_Syntax  
  
### SEE ALSO  
 about\_Parameters  
  
 Get\-Command  
  
 Get\-Help

