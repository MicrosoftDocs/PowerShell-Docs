---
title: about_Type_Operators
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 06db73f5-24d4-42a8-a7f6-56a54d069442
---
# about_Type_Operators
## TOPIC  
 about\_Type\_Operators  
  
## SHORT DESCRIPTION  
 Describes the operators that work with Microsoft .NET Framework types.  
  
## LONG DESCRIPTION  
 The Boolean type operators \(\-is and \-isNot\) tell whether an object is an instance of a specified .NET Framework type. The \-is operator returns a value of TRUE if the type matches and a value of FALSE otherwise. The \-isNot operator returns a value of FALSE if the type matches and a value of TRUE otherwise.  
  
 The \-as operator tries to convert the input object to the specified .NET Framework type. If it succeeds, it returns the converted object. It if fails, it returns nothing. It does not return an error.  
  
 The following table lists the type operators in [!INCLUDE[wps_1](../Token/wps_1_md.md)].  
  
```  
Operator  Description                 Example    
--------  ------------------------    -------------------------------------  
-is       Returns TRUE when the       C:\PS> (get-date) -is [DateTime]  
          input is an instance        True  
          of the specified  
          .NET Framework type.  
  
-isNot    Returns TRUE when the       C:\PS> (get-date) -isNot [DateTime]  
          input is not an instance    False  
          of the specified  
          .NET Framework type.  
  
-as       Converts the input to       C:\PS> 12/31/07 -as [DateTime]  
          the specified               Monday, December 31, 2007 12:00:00 AM  
          .NET Framework type.  
  
```  
  
 The syntax of the type operators is as follows:  
  
```  
<input> <operator> [.NET type]  
  
```  
  
 You can also use the following syntax:  
  
```  
<input> <operator> ".NET type"  
  
```  
  
 To specify the .NET Framework type, enclose the type name in brackets \(\[ \]\), or enter the type as a string, such as \[DateTime\] or "DateTime" for System.DateTime. If the type is not at the root of the system namespace, specify the full name of the object type. You can omit "System.". For example, to specify System.Diagnostics.Process, enter \[System.Diagnostics.Process\], \[Diagnostics.Process\], or "diagnostics.process".  
  
 The type operators always return a Boolean value, even if the input is a collection of objects. However, when the input is a collection, the type operators match the .NET Framework type of the collection. They do not match the type of each object, even when all of the objects are of the same type.  
  
 To find the .NET Framework type of an object, use the Get\-Member cmdlet. Or, use the GetType method of all the objects together with the FullName property of this method. For example, the following statement gets the type of the return value of a Get\-Culture command:  
  
```  
C:\PS> (get-culture).gettype().fullname  
System.Globalization.CultureInfo  
  
```  
  
## EXAMPLES  
 The following examples show some uses of the Type operators:  
  
```  
C:\PS> 32 -is [Float]  
False  
  
C:\PS> 32 -is "int"  
True  
  
C:\PS> (get-date) -is [DateTime]  
True  
  
C:\PS> "12/31/2007" -is [DateTime]  
False  
  
C:\PS> "12/31/2007" -is [String]  
True  
  
C:\PS> (get-process PowerShell)[0] -is [System.Diagnostics.Process]  
True  
  
C:\PS> (get-command get-member) -is [System.Management.Automation.CmdletInfo]  
True  
  
```  
  
 The following example shows that when the input is a collection of objects, the matching type is the .NET Framework type of the collection, not the type of the individual objects in the collection.  
  
 In this example, although both the Get\-Culture and Get\-UICulture cmdlets return System.Globalization.CultureInfo objects, a collection of these objects is a System.Object array.  
  
```  
C:\PS> (get-culture) -is [System.Globalization.CultureInfo]  
True  
  
C:\PS> (get-uiculture) -is [System.Globalization.CultureInfo]  
True  
  
C:\PS> (get-culture), (get-uiculture) -is [System.Globalization.CultureInfo]  
False  
  
C:\PS> (get-culture), (get-uiculture) -is [Array]  
True  
  
C:\PS> (get-culture), (get-uiculture) | foreach {$_ -is [System.Globalization.CultureInfo])  
True  
True  
  
C:\PS> (get-culture), (get-uiculture) -is [Object]  
True  
  
```  
  
 The following examples show how to use the \-as operator.  
  
```  
C:\PS> "12/31/07" -is [DateTime]  
False  
  
C:\PS> "12/31/07" -as [DateTime]  
Monday, December 31, 2007 12:00:00 AM  
  
C:\PS> $date = "12/31/07" -as [DateTime]  
  
C:\PS>$a -is [DateTime]  
True  
  
C:\PS> 1031 -as [System.Globalization.CultureInfo]  
  
LCID             Name             DisplayName  
----             ----             -----------  
1031             de-DE            German (Germany)  
  
```  
  
 The following example shows that when the \-as operator cannot convert the input object to the .NET Framework type, it returns nothing.  
  
```  
C:\PS> 1031 -as [System.Diagnostic.Process]  
C:\PS>  
  
```  
  
## SEE ALSO  
 about\_Operators