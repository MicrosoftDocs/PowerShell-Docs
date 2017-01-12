---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Variable Provider
ms.technology:  powershell
online version:   http://go.microsoft.com/fwlink/?LinkId=834963
---

# Variable Provider
## PROVIDER NAME  
 Variable  

## DRIVES  
 Variable:  

## SHORT DESCRIPTION  
 Provides access to the Windows PowerShell variables and to their values.  

## DETAILED DESCRIPTION  
 The Windows PowerShell Variable provider lets you get, add, change, clear, and delete Windows PowerShell variables in the current console.  

 The Windows PowerShell Variable provider supports the variables that Windows PowerShell creates, including the automatic variables, the preference variables, and the variables that you create.  

 The Variable provider is a flat namespace that contains only the variable objects. The variables have no child items.  

 Most of the variables are instances of the System.Management.Automation.PSVariable class. However, there are some variations. For example, the "?" variable is a member of the QuestionMarkVariable class, and the "MaximumVariableCount" variable is a member of the SessionStateCapacityVariable class.  

 The Variable provider exposes its data store in the Variable: drive. To work with variables, you can change your location to the Variable: drive ("set-location variable:"), or you can work from any other Windows PowerShell drive. To reference a variable from another location, use the drive name (Variable:) in the path.  

 Windows PowerShell includes a set of cmdlets designed especially to view and to change variables:  

 -- Get-Variable  

 -- New-Variable  

 -- Set-Variable  

 -- Remove-Variable  

 -- Clear-Variable  

 When you use these cmdlets, you do not need to specify the Variable: drive in the name.  

 The Variable provider supports all of the cmdlets whose names contain the Item noun (the Item cmdlets), except for [Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md). The Variable provider supports the [Get-Content](../../Microsoft.PowerShell.Management/Get-Content.md) and [Set-Content](../../Microsoft.PowerShell.Management/Set-Content.md) cmdlets. However, it does not support the cmdlets whose names contain the ItemProperty noun (the ItemProperty cmdlets), and it does not support the Filter parameter in any cmdlet.  

 You can also use the Windows PowerShell expression parser to create, view, and change the values of variables without using the cmdlets. When working with variables directly, use a dollar sign ($) to identify the name as a variable and the assignment operator (=) to establish and change its value. For example, "$p = [Get-Process](../../Microsoft.PowerShell.Management/Get-Process.md)" creates the "p" variable and stores the results of a "[Get-Process](../../Microsoft.PowerShell.Management/Get-Process.md)" command in it.  

 All changes to the variables affect the current session only. To save the changes, add the changes to the Windows PowerShell profile, or use [Export-Console](../Export-Console.md) to save the current console.  

## CAPABILITIES  
 ShouldProcess  

## EXAMPLES  

### Getting to the Variable: Drive  

#### -------------------------- EXAMPLE 1 --------------------------  
 This command changes the current location to the Variable: drive. You can use this command from any drive in Windows PowerShell. To return to a file system drive, type the drive name. For example, type "set-location c:".  

```  
set-location variable:  

```  

### Displaying the Value of Variables  

#### -------------------------- EXAMPLE 1 --------------------------  
 This command gets the list of all the variables and their values in the current session. You can use this command from any Windows PowerShell drive.  

```  
get-childitem -path variable:  

```  

#### -------------------------- EXAMPLE 2 --------------------------  
 This command gets the variables with names that begin with "max". You can use this command from any Windows PowerShell drive.  

```  
get-childitem -path variable:max*  

```  

 If you are in the Variable: drive, you can omit the drive name from the path.  

#### -------------------------- EXAMPLE 3 --------------------------  
 This command gets the value of the WhatIfPreference variable by typing it at the command line.  

 The name of the variable is preceded by a dollar sign ($) to indicate that it is a variable. The Variable: drive name is not specified.  

```  
$WhatIfPreference  

```  

#### -------------------------- EXAMPLE 4 --------------------------  
 This command uses the LiteralPath parameter of Get-ChildItem to get the value of the "?" variable from within the Variable: drive. Get-ChildItem does not attempt to resolve any wildcards in the values of the LiteralPath parameter.  

```  
get-childitem -literalpath ?  

```  

 To display the value of a variable with a special character name without a cmdlet, type a dollar sign ($) and the variable name. For example, to display the value of the "?" variable, type "$?".  

#### -------------------------- EXAMPLE 5 --------------------------  
 This command gets the variables that have the values of "ReadOnly" or "Constant" for their Options property.  

```  
get-childitem -path variable: | where-object {$_.options -match "Constant" -or $_.options -match "ReadOnly"} | format-list -property name, value, options  

```  

### Creating a New Variable  

#### -------------------------- EXAMPLE 1 --------------------------  
 This command creates the "services" variable and stores the results of a Get-Service command in it. Because the current location is in the Variable: drive, the value of the Path parameter is a dot (.), which represents the current location.  

 The parentheses around the Get-Service command ensure that the command is executed before the variable is created. Without the parentheses, the value of the new variable is a "Get-Service" string.  

```  
new-item -path . -name services -value (Get-Service)  

```  

 If you are not in the variable: drive, include the Variable: drive name in the path.  

#### -------------------------- EXAMPLE 2 --------------------------  
 This command creates a "services" variable and stores the result of a Get-Service command in it.  

 The command uses a dollar sign ($) to indicate a variable and the assignment operator (=) to assign the result of the Get-Service command to the newly created variable.  

```  
$services = Get-Service  

```  

 To create a variable without a value, omit the assignment operator.  

### Displaying the Properties and Methods of Variables  

#### -------------------------- EXAMPLE 1 --------------------------  
 This command uses the Get-Item cmdlet to get all variables. The pipeline operator (&#124;) sends the results to the Get-Member cmdlet, which displays the methods and properties of the object.  

```  
get-item -path variable:* | get-member  

```  

 When you pipe a collection of objects (such as the collection of variables in the Variable: drive) to Get-Member, Get-Member evaluates each object in the collection separately and returns information about each of the object types that it finds.   
To get information about the collection of objects in the Variable: drive, use the InputObject parameter of Get-Member. For example, "get-member -inputobject (get-item variable:*)". When you use InputObject, Get-Member evaluates the collection, not the objects in the collection.  

#### -------------------------- EXAMPLE 2 --------------------------  
 This command lists the values of the properties of the "home" variable. It uses the Get-Item cmdlet to get an object that represents the "home" variable. The pipeline operator (&#124;) sends the results to the Format-List command. The Format-List command uses the Property parameter with a wildcard character (*) to format and to display the values of all of the properties of the "home" variable.  

```  
get-item variable:home | format-list -property *  

```  

### Changing the Properties of a Variable  

#### -------------------------- EXAMPLE 1 --------------------------  
 This command uses the Rename-Item cmdlet to change the name of the "a" variable to "processes".  

```  
rename-item -path variable:a -newname processes  

```  

#### -------------------------- EXAMPLE 2 --------------------------  
 This command uses the Set-Item cmdlet to change the value of the ErrorActionPreference variable to "Stop".  

```  
set-item -path variable:ErrorActionPreference -value Stop  

```  

#### -------------------------- EXAMPLE 3 --------------------------  
 This command changes the value of the ErrorActionPreference variable to "Stop".  

 It uses a dollar sign ($) to indicate a variable and the assignment operator (=) to assign the value.  

```  
$ErrorActionPreference = Stop  

```  

### Copying a Variable  

#### -------------------------- EXAMPLE 1 --------------------------  
 This command uses the Copy-Item cmdlet to copy the "processes" variable to "old_processes". This creates a new variable named "old_processes" that has the same value as the "processes" variable.  

```  
copy-item -path variable:processes -destination variable:old_processes  

```  

 If the command is issued from within the Variable: drive, you can omit the drive name from the value of the Path parameter.  

#### -------------------------- EXAMPLE 2 --------------------------  
 This command copies the "processes" variable to "old_processes" without using a cmdlet. It uses the dollar sign ($) to indicate variables and the assignment operator to assign the value of $processes to old_processes.  

```  
$old_processes = $processes  

```  

### Deleting a Variable  

#### -------------------------- EXAMPLE 1 --------------------------  
 This command deletes the "serv" variable from the current session. You can use this command in any Windows PowerShell drive.  

```  
remove-variable -path variable:serv  

```  

#### -------------------------- EXAMPLE 2 --------------------------  
 This command deletes all variables from the current session except for the variables whose Options property has a value of Constant. Without the Force parameter, the command does not delete variables whose Options property has a value of ReadOnly.  

```  
remove-item variable:* -force  

```  

### Setting the Value of a Variable to NULL  

#### -------------------------- EXAMPLE 1 --------------------------  
 This command uses the Clear-Item cmdlet to change the value of the "processes" variable to NULL.  

```  
clear-item -path variable:processes  

```  

#### -------------------------- EXAMPLE 2 --------------------------  
 This command clears the value of the "processes" variable by assigning a null value to it. It uses the $null automatic variable to represent the NULL value.  

```  
$processes = $null  

```  

## See Also  
 [about_Variables](../About/about_Variables.md)   
 [about_Automatic_Variables](../About/about_Automatic_Variables.md)   
 [about_Providers](../About/about_Providers.md)

