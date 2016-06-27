---
title: about_Functions_Advanced_Parameters
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2efa1fb8-5218-4e85-9086-2496220b5ede
---
# about_Functions_Advanced_Parameters
## TOPIC  
 Insert section body here.  
  
## SHORT DESCRIPTION  
 Explains how to add parameters to advanced functions.  
  
## LONG DESCRIPTION  
 You can add parameters to the advanced functions that you write, and use parameter attributes and arguments to limit the parameter values that function users submit with the parameter.  
  
 The parameters that you add to your function are available to users in addition to the common parameters that [!INCLUDE[wps_1]()] adds automatically to all cmdlets and advanced functions. For more information about the [!INCLUDE[wps_2]()] common parameters, see about\_CommonParameters \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113216\).  
  
 Beginning in [!INCLUDE[wps_2]()] 3.0, you can use splatting with @Args to represent the parameters in a command. This technique is valid on simple and advanced functions. For more information, see about\_Functions \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113231\) and about\_Splatting \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=262720\).  
  
## STATIC PARAMETERS  
 Static parameters are parameters that are always available in the function. Most parameters in [!INCLUDE[wps_2]()] cmdlets and scripts are static parameters.  
  
 The following example shows the declaration of a ComputerName parameter that has the following characteristics:  
  
 It is mandatory \(required\).  
  
 It takes input from the pipeline.  
  
 It takes an array of strings as input.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true,  
    ValueFromPipeline=$true)]  
    [String[]]  
    $ComputerName  
  )  
```  
  
### ATTRIBUTES OF PARAMETERS  
 This section describes the attributes that you can add to function parameters.  
  
 All attributes are optional. However, if you omit the CmdletBinding attribute, then to be recognized as an advanced function, the function must include the Parameter attribute.  
  
 You can add one or multiple attributes in each parameter declaration. There is no limit to the number of attributes that you can add to a parameter declaration.  
  
### THE PARAMETER ATTRIBUTE  
 The Parameter attribute is used to declare the attributes of function parameters.  
  
 The Parameter attribute is optional, and you can omit it if none of the parameters of your functions need attributes, but to be recognized as an advanced function \(rather than a simple function\), a function must have either the CmdletBinding attribute or the Parameter attribute, or both.  
  
 The Parameter attribute has arguments that define the characteristics of the parameter, such as whether the parameter is mandatory or optional.  
  
 Use the following syntax to declare the Parameter attribute, an argument, and an argument value. The parentheses that enclose the argument and its value must follow "Parameter" with no intervening space.  
  
```  
Param  
  (  
    [parameter(Argument=value)]  
    $ParameterName  
  )  
```  
  
 Use commas to separate arguments within the parentheses. Use the following syntax to declare two arguments of the Parameter attribute.  
  
```  
Param  
  (  
    [parameter(Argument1=value1,  
               Argument2=value2)]  
  
  )  
```  
  
 If you use the Parameter attribute without arguments \(as an alternative to using the CmdletBinding attribute\), the parentheses that follow the attribute name are still required.  
  
```  
Param  
  (  
    [parameter()]  
    $ParameterName  
  )  
```  
  
#### Mandatory Argument  
 The Mandatory argument indicates that the parameter is required. If this argument is not specified, the parameter is an optional parameter.  
  
 The following example declares the ComputerName parameter. It uses the Mandatory argument to make the parameter mandatory.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [String[]]  
    $ComputerName  
  )  
```  
  
#### Position Argument  
 The Position argument determines whether the parameter name is required when the parameter is used in a command. When a parameter declaration includes the Position argument, the parameter name can be omitted and [!INCLUDE[wps_2]()] identifies the unnamed parameter value by its position \(or order\) in the list of unnamed parameter values in the command.  
  
 If the Position argument is not specified, the parameter name \(or a parameter name alias or abbreviation\) must precede the parameter value whenever the parameter is used in a command.  
  
 By default, all function parameters are positional. [!INCLUDE[wps_2]()] assigns position numbers to parameters in the order in which the parameters are declared in the function. To disable this feature, set the value of the PositionalBinding argument of the CmdletBinding attribute to $False. The Position argument takes precedence over the value of the PositionalBinding argument for the parameters on which it is declared. For more information, see PositionalBinding in about\_Functions\_CmdletBindingAttribute.  
  
 The value of the Position argument is specified as an integer. A position value of 0 represents the first position in the command, a position value of 1 represents the second position in the command, and so on.  
  
 If a function has no positional parameters, [!INCLUDE[wps_2]()] assigns positions to each parameter based on the order in which the parameters are declared. However, as a best practice, do not rely on this assignment. When you want parameters to be positional, use the Position argument.  
  
 The following example declares the ComputerName parameter. It uses the Position argument with a value of 0. As a result, when "\-ComputerName" is omitted from command, its value must be the first or only unnamed parameter value in the command.  
  
```  
Param  
  (  
    [parameter(Position=0)]  
    [String[]]  
    $ComputerName  
  )  
```  
  
 NOTE:  
  
 When the Get\-Help cmdlet displays the corresponding "Position?" parameter attribute, the position value is incremented by 1. For example, a parameter with a Position argument value of 0 has a parameter attribute of "Position? 1."  
  
#### ParameterSetName Argument  
 The ParameterSetName argument specifies the parameter set to which a parameter belongs. If no parameter set is specified, the parameter belongs to all the parameter sets defined by the function. Therefore, to be unique, each parameter set must have at least one parameter that is not a member of any other parameter set.  
  
 The following example declares a ComputerName parameter in the Computer parameter set, a UserName parameter in the User parameter set, and a Summary parameter in both parameter sets.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true,  
              ParameterSetName="Computer")]  
    [String[]]  
    $ComputerName,  
  
    [parameter(Mandatory=$true,  
              ParameterSetName="User")]  
    [String[]]  
    $UserName,  
  
    [parameter(Mandatory=$false)]  
    [Switch]  
    $Summary  
  )  
```  
  
 You can specify only one ParameterSetName value in each argument and only one ParameterSetName argument in each Parameter attribute. To indicate that a parameter appears in more than one parameter set, add additional Parameter attributes.  
  
 The following example explicitly adds the Summary parameter to the Computer and User parameter sets. The Summary parameter is mandatory in one parameter set and optional in the other.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true,  
              ParameterSetName="Computer")]  
    [String[]]  
    $ComputerName,  
  
    [parameter(Mandatory=$true,  
              ParameterSetName="User")]  
    [String[]]  
    $UserName,  
  
    [parameter(Mandatory=$false, ParameterSetName="Computer")]  
    [parameter(Mandatory=$true, ParameterSetName="User")]  
    [Switch]  
    $Summary  
  )  
  
```  
  
 For more information about parameter sets, see "Cmdlet Parameter Sets" in the MSDN library at http:\/\/go.microsoft.com\/fwlink\/?LinkId\=142183.  
  
##### ValueFromPipeline Argument  
 The ValueFromPipeline argument indicates that the parameter accepts input from a pipeline object. Specify this argument if the function accepts the entire object, not just a property of the object.  
  
 The following example declares a ComputerName parameter that is mandatory and accepts an object that is passed to the function from the pipeline.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true,  
              ValueFromPipeline=$true)]  
    [String[]]  
    $ComputerName  
  )  
```  
  
##### ValueFromPipelineByPropertyName Argument  
 The valueFromPipelineByPropertyName argument indicates that the parameter accepts input from a property of a pipeline object. The object property must have the same name or alias as the parameter.  
  
 For example, if the function has a ComputerName parameter, and the piped object has a ComputerName property, the value of the ComputerName property is assigned to the ComputerName parameter of the function.  
  
 The following example declares a ComputerName parameter that is mandatory and accepts input from the ComputerName property of the object that is passed to the function through the pipeline.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true,  
              ValueFromPipelineByPropertyName=$true)]  
    [String[]]  
    $ComputerName  
  )  
```  
  
#### ValueFromRemainingArguments Argument  
 The ValueFromRemainingArguments argument indicates that the parameter accepts all of the parameters values in the command that are not assigned to other parameters of the function.  
  
 The following example declares a ComputerName parameter that is mandatory and accepts all the remaining parameter values that were submitted to the function.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true,  
              ValueFromRemainingArguments=$true)]  
    [String[]]  
    $ComputerName  
  )  
```  
  
#### HelpMessage Argument  
 The HelpMessage argument specifies a string that contains a brief description of the parameter or its value. [!INCLUDE[wps_2]()] displays this message in the prompt that appears when a mandatory parameter value is missing from a command. This argument has no effect on optional parameters.  
  
 The following example declares a mandatory ComputerName parameter and a help message that explains the expected parameter value.  
  
```  
Param  
  (  
    [parameter(mandatory=$true,  
               HelpMessage="Enter one or more computer names separated by commas.")]  
    [String[]]  
    $ComputerName  
  )  
```  
  
### ALIAS ATTRIBUTE  
 The Alias attribute establishes an alternate name for the parameter. There is no limit to the number of aliases that you can assign to a parameter.  
  
 The following example shows a parameter declaration that adds the "CN" and "MachineName" aliases to the mandatory ComputerName parameter.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [alias("CN","MachineName")]  
    [String[]]  
    $ComputerName  
  )  
```  
  
### PARAMETER AND VARIABLE VALIDATION ATTRIBUTES  
 Validation attributes direct [!INCLUDE[wps_2]()] to test the parameter values that users submit when they call the advanced function. If the parameter values fail the test, an error is generated and the function is not called. You can also use some of the validation attributes to restrict the values that users can specify for variables.  
  
#### AllowNull Validation Attribute  
 The AllowNull attribute allows the value of a mandatory parameter to be null \($null\). The following example declares a ComputerName parameter that can have a Null value.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [AllowNull()]  
    [String]  
    $ComputerName  
  )  
```  
  
##### AllowEmptyString Validation Attribute  
 The AllowEmptyString attribute allows the value of a mandatory parameter to be an empty string \(""\). The following example declares a ComputerName parameter that can have an empty string value.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [AllowEmptyString()]  
    [String]  
    $ComputerName  
  )  
```  
  
###### AllowEmptyCollection Validation Attribute  
 The AllowEmptyCollection attribute allows the value of a mandatory parameter to be an empty collection \(@\(\)\). The following example declares a ComputerName parameter that can have a empty collection value.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [AllowEmptyCollection()]  
    [String[]]  
    $ComputerName  
  )  
```  
  
###### ValidateCount Validation Attribute  
 The ValidateCount attribute specifies the minimum and maximum number of parameter values that a parameter accepts. [!INCLUDE[wps_2]()] generates an error if the number of parameter values in the command that calls the function is outside that range.  
  
 The following parameter declaration creates a ComputerName parameter that takes 1 to 5 parameter values.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [ValidateCount(1,5)]  
    [String[]]  
    $ComputerName  
  )  
```  
  
###### ValidateLength Validation Attribute  
 The ValidateLength attribute specifies the minimum and maximum number of characters in a parameter or variable value. [!INCLUDE[wps_2]()] generates an error if the length of a value specified for a parameter or a variable is outside of the range.  
  
 In the following example, each computer name must have one to 10 characters.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [ValidateLength(1,10)]  
    [String[]]  
    $ComputerName  
  )  
```  
  
 In the following example, the value of the variable $number must be a minimum of one character in length, and a maximum of ten characters.  
  
```  
[Int32][ValidateLength(1,10)]$number = 01  
```  
  
###### ValidatePattern Validation Attribute  
 The ValidatePattern attribute specifies a regular expression that is compared to the parameter or variable value. [!INCLUDE[wps_2]()] generates an error if the value does not match the regular expression pattern.  
  
 In the following example, the parameter value must be a four\-digit number, and each digit must be a number 0 to 9.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [ValidatePattern("[0-9][0-9][0-9][0-9]")]  
    [String[]]  
    $ComputerName  
  )  
```  
  
 In the following example, the value of the variable $number must be a four\-digit number, and each digit must be a number 0 to 9.  
  
```  
[Int32][ValidatePattern("[0-9][0-9][0-9][0-9]")]$number = 1111  
```  
  
###### ValidateRange Validation Attribute  
 The ValidateRange attribute specifies a numeric range for each parameter or variable value. [!INCLUDE[wps_2]()] generates an error if any value is outside that range. In the following example, the value of the Attempts parameter must be between 0 and 10.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [ValidateRange(0,10)]  
    [Int]  
    $Attempts  
  )  
```  
  
 In the following example, the value of the variable $number must be between 0 and 10.  
  
```  
[Int32][ValidateRange(0,10)]$number = 5  
```  
  
###### ValidateScript Validation Attribute  
 The ValidateScript attribute specifies a script that is used to validate a parameter or variable value. [!INCLUDE[wps_2]()] pipes the value to the script, and generates an error if the script returns "false" or if the script throws an exception.  
  
 When you use the ValidateScript attribute, the value that is being validated is mapped to the $\_ variable. You can use the $\_ variable to refer to the value in the script.  
  
 In the following example, the value of the EventDate parameter must be greater than or equal to the current date.  
  
```  
Param  
  (  
    [parameter()]  
    [ValidateScript({$_ -ge (get-date)})]  
    [DateTime]  
    $EventDate  
  )  
```  
  
 In the following example, the value of the variable $date must be greater than or equal to the current date and time.  
  
```  
[DateTime][ValidateScript({$_ -ge (get-date)})]$date = (get-date)  
```  
  
###### ValidateSet Attribute  
 The ValidateSet attribute specifies a set of valid values for a parameter or variable. [!INCLUDE[wps_2]()] generates an error if a parameter or variable value does not match a value in the set. In the following example, the value of the Detail parameter can only be "Low," "Average," or "High."  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [ValidateSet("Low", "Average", "High")]  
    [String[]]  
    $Detail  
  )  
```  
  
 In the following example, the value of the variable $flavor must be either Chocolate, Strawberry, or Vanilla.  
  
```  
[String][ValidateSet("Chocolate", "Strawberry", "Vanilla")]$flavor = Strawberry  
```  
  
###### ValidateNotNull Validation Attribute  
 The ValidateNotNull attribute specifies that the parameter value cannot be null \($null\). [!INCLUDE[wps_2]()] generates an error if the parameter value is null.  
  
 The ValidateNotNull attribute is designed to be used when the type of the parameter value is not specified or when the specified type will accept a value of Null. \(If you specify a type that will not accept a null value, such as a string, the null value will be rejected without the ValidateNotNull attribute, because it does not match the specified type.\)  
  
 In the following example, the value of the ID parameter cannot be null.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [ValidateNotNull()]  
    $ID  
  )  
```  
  
###### ValidateNotNullOrEmpty Validation Attribute  
 The ValidateNotNullOrEmpty attribute specifies that the parameter value cannot be null \($null\) and cannot be an empty string \(""\).[!INCLUDE[wps_2]()] generates an error if the parameter is used in a function call, but its value is null, an empty string, or an empty array.  
  
```  
Param  
  (  
    [parameter(Mandatory=$true)]  
    [ValidateNotNullOrEmpty()]  
    [String[]]  
    $UserName  
  )  
```  
  
### DYNAMIC PARAMETERS  
 Dynamic parameters are parameters of a cmdlet, function, or script that are available only under certain conditions.  
  
 For example, several provider cmdlets have parameters that are available only when the cmdlet is used in the provider drive, or in a particular path of the provider drive. For example, the Encoding parameter is available on the Add\-Content, Get\-Content, and Set\-Content cmdlets only when it is used in a file system drive.  
  
 You can also create a parameter that appears only when another parameter is used in the function command or when another parameter has a certain value.  
  
 Dynamic parameters can be very useful, but use them only when necessary, because they can be difficult for users to discover. To find a dynamic parameter, the user must be in the provider path, use the ArgumentList parameter of the Get\-Command cmdlet, or use the Path parameter of Get\-Help.  
  
 To create a dynamic parameter for a function or script, use the DynamicParam keyword.  
  
 The syntax is as follows:  
  
```  
DynamicParam {<statement-list>}  
```  
  
 In the statement list, use an If statement to specify the conditions under which the parameter is available in the function.  
  
 Use the New\-Object cmdlet to create a System.Management.Automation.RuntimeDefinedParameter object to represent the parameter and specify its name.  
  
 You can also use a New\-Object command to create a System.Management.Automation.ParameterAttribute object to represent attributes of the parameter, such as Mandatory, Position, or ValueFromPipeline or its parameter set.  
  
 The following example shows a sample function with standard parameters named Name and Path, and an optional dynamic parameter named DP1.The DP1 parameter is in the PSet1 parameter set and has a type of Int32. The DP1 parameter is available in the Sample function only when the value of the Path parameter contains "HKLM:", indicating that it is being used in the HKEY\_LOCAL\_MACHINE registry drive.  
  
```  
function Get-Sample {  
    [CmdletBinding()]  
    Param ([String]$Name, [String]$Path)  
  
    DynamicParam  
    {  
        if ($path -match ".*HKLM.*:")  
        {  
            $attributes = new-object System.Management.Automation.ParameterAttribute  
            $attributes.ParameterSetName = "__AllParameterSets"  
            $attributes.Mandatory = $false  
            $attributeCollection = new-object `  
                -Type System.Collections.ObjectModel.Collection[System.Attribute]  
            $attributeCollection.Add($attributes)  
  
            $dynParam1 = new-object `  
                -Type System.Management.Automation.RuntimeDefinedParameter("dp1", [Int32], $attributeCollection)  
  
            $paramDictionary = new-object `  
                -Type System.Management.Automation.RuntimeDefinedParameterDictionary  
            $paramDictionary.Add("dp1", $dynParam1)  
            return $paramDictionary  
        }  
    }  
}  
```  
  
 For more information, see "RuntimeDefinedParameter Class" in the MSDN \(Microsoft Developer Network\) library at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=145130.  
  
 Switch Parameters  
  
 Switch parameters are parameters with no parameter value. They are effective only when they are used and have only one effect.  
  
 For example, the \-NoProfile parameter of PowerShell.exe is a switch parameter.  
  
 To create a switch parameter in a function, specify the Switch type in the parameter definition.  
  
```  
For example:  
    Param ([Switch]<ParameterName>)  
-or-   
    Param  
      (  
         [parameter(Mandatory=$false)]  
         [Switch]  
         $<ParameterName>  
      )  
```  
  
 Switch parameters are easy to use and are preferred over Boolean parameters, which have a more difficult syntax.  
  
 For example, to use a switch parameter, the user types the parameter in the command.  
  
```  
-IncludeAll  
```  
  
 To use a Boolean parameter, the user types the parameter and a Boolean value.  
  
```  
-IncludeAll:$true  
```  
  
 When creating switch parameters, choose the parameter name carefully. Be sure that the parameter name communicates the effect of the parameter to the user, and avoid ambiguous terms, such as Filter or Maximum, that might imply that a value is required.  
  
## SEE ALSO  
 about\_Functions  
  
 about\_Functions\_Advanced  
  
 about\_Functions\_Advanced\_Methods  
  
 about\_Functions\_CmdletBindingAttribute  
  
 about\_Functions\_OutputTypeAttribute