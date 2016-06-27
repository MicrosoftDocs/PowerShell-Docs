---
title: about_Arrays
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: beca4530-77f9-4c0f-817b-ec7a48cdcf9d
---
# about_Arrays
Insert introduction here.  
  
## TOPIC  
 about\_Arrays  
  
## SHORT DESCRIPTION  
 Describes arrays, which are data structures designed to store collections of items.  
  
## LONG DESCRIPTION  
 An array is a data structure that is designed to store a collection of items. The items can be the same type or different types.  
  
 Beginning in [!INCLUDE[wps_1]()] 3.0, a collection of zero or one object has some properties of arrays.  
  
### CREATING AND INITIALIZING AN ARRAY  
 To create and initialize an array, assign multiple values to a variable. The values stored in the array are delimited with a comma and separated from the variable name by the assignment operator \(\=\).  
  
 For example, to create an array named $A that contains the seven numeric \(int\) values of 22, 5, 10, 8, 12, 9, and 80, type:  
  
```  
$A = 22,5,10,8,12,9,80  
```  
  
 You can also create and initialize an array by using the range operator \(..\). For example, to create and initialize an array named "$B" that contains the values 5 through 8, type:  
  
```  
$B = 5..8  
```  
  
 As a result, $B contains four values: 5, 6, 7, and 8.  
  
 When no data type is specified, [!INCLUDE[wps_2]()] creates each array as an object array \(type: System.Object\[\]\). To determine the data type of an array, use the GetType\(\) method. For example, to determine the data type of the $a array, type:  
  
```  
$a.GetType()  
```  
  
 To create a strongly typed array, that is, an array that can contain only values of a particular type, cast the variable as an array type, such as string\[\], long\[\], or int32\[\]. To cast an array, precede the variable name with an array type enclosed in brackets. For example, to create a 32\-bit integer array named $ia containing four integers \(1500, 2230, 3350, and 4000\), type:  
  
```  
[int32[]]$ia = 1500,2230,3350,4000  
```  
  
 As a result, the $ia array can contain only integers.  
  
 You can create arrays that are cast to any supported type in the Microsoft .NET Framework. For example, the objects that Get\-Process retrieves to represent processes are of the System.Diagnostics.Process type. To create a strongly typed array of process objects, enter the following command:  
  
```  
[Diagnostics.Process[]]$zz = Get-Process  
```  
  
### THE ARRAY SUB\-EXPRESSION OPERATOR  
 The array sub\-expression operator creates an array, even if it contains zero or one object.  
  
 The syntax of the array operator is as follows:  
  
```  
@( ... )  
```  
  
 You can use the array operator to create an array of zero or one object.  
  
```  
PS C:\>$a = @("One")  
PS C:\>$a.Count  
1  
  
```  
  
```  
PS C:\>$b = @()  
PS C:\>$b.Count  
0  
  
```  
  
 The array operator is particularly useful in scripts when you are getting objects, but do not know how many objects you will get.  
  
```  
PS C:\> $p = @(Get-Process Notepad)  
```  
  
 For more information about the array sub\-expression operator, see about\_Operators.  
  
### READING AN ARRAY  
 You can refer to an array by using its variable name. To display all the elements in the array, type the array name. For example:  
  
```  
$a  
```  
  
 You can refer to the elements in an array by using an index, beginning at position 0. Enclose the index number in brackets. For example, to display the first element in the $a array, type:  
  
```  
$a[0]  
```  
  
 To display the third element in the $a array, type:  
  
```  
$a[2]  
```  
  
 Negative numbers count from the end of the array. For example, "\-1" refers to the last element of the array. To display the last three elements of the array, type:  
  
```  
$a[-3..-1]  
```  
  
 However, be cautious when using this notation.  
  
```  
$a[0..-2]  
```  
  
 This command does not refer to all the elements of the array, except for the last one. It refers to the first, last, and second\-to\-last elements in the array.  
  
 You can use the range operator to display a subset of all the values in an array. For example, to display the data elements at index position 1 through 3, type:  
  
```  
$a[1..3]  
```  
  
 You can use the plus operator \(\+\) to combine a range with a list of elements in an array. For example, to display the elements at index positions 0, 2, and 4 through 6, type:  
  
```  
$a[0,2+4..6]  
```  
  
 To determine how many items are in an array, use the Length property or its Count alias.  
  
```  
$a.Count  
```  
  
 You can also use looping constructs, such as ForEach, For, and While loops, to refer to the elements in an array. For example, to use a ForEach loop to display the elements in the $a array, type:  
  
```  
foreach ($element in $a) {$element}  
```  
  
 The Foreach loop iterates through the array and returns each value in the array until reaching the end of the array.  
  
 The For loop is useful when you are incrementing counters while examining the elements in an array. For example, to use a For loop to  return every other value in an array, type:  
  
```  
for ($i = 0; $i -le ($a.length - 1); $i += 2) {$a[$i]}  
```  
  
 You can use a While loop to display the elements in an array until a defined condition is no longer true. For example, to display the elements in the $a array while the array index is less than 4, type:  
  
```  
$i=0  
while($i -lt 4) {$a[$i]; $i++}  
  
```  
  
### GET THE MEMBERS OF AN ARRAY  
 To get the properties and methods of an array, such as the Length property and the SetValue method, use the InputObject parameter of the Get\-Member cmdlet.  
  
 When you pipe an array to Get\-Member, [!INCLUDE[wps_2]()] sends the items one at a time and Get\-Member returns the type of each item in the array \(ignoring duplicates\).  
  
 When you use the InputObject parameter, Get\-Member returns the members of the array.  
  
 For example, the following command gets the members of the array in the $a variable.  
  
```  
Get-Member -InputObject $a  
```  
  
 You can also get the members of an array by typing a comma \(,\) before the value that is piped to the Get\-Member cmdlet. The comma makes the array the second item in an array of arrays. [!INCLUDE[wps_2]()] pipes the arrays one at a time and Get\-Member returns the members of the array.  
  
```  
,$a | Get-Member  
```  
  
```  
,(1,2,3) | Get-Member  
```  
  
### MANIPULATING AN ARRAY  
 You can change the elements in an array, add an element to an array, and combine the values from two arrays into a third array.  
  
 To change the value of a particular element in an array, specify the array name and the index of the element that you want to change, and then use the assignment operator \(\=\) to specify a new value for the element. For example, to change the value of the second item in the $a array \(index position 1\) to 10, type:  
  
```  
$a[1] = 10  
```  
  
 You can also use the SetValue method of an array to change a value. The following example changes the second value \(index position 1\) of the $a array to 500:  
  
```  
$a.SetValue(500,1)  
```  
  
 You can use the \+\= operator to add an element to an array. When you use it, [!INCLUDE[wps_2]()] actually creates a new array with the values of the original array and the added value. For example, to add an element with a value of 200 to the array in the $a variable, type:  
  
```  
$a += 200  
```  
  
 It is not easy to delete elements from an array, but you can create a new array that contains only selected elements of an existing array. For example, to create the $t array with all the elements in the $a array except for the value at index position 2, type:  
  
```  
$t = $a[0,1 + 3..($a.length - 1)]  
```  
  
 To combine two arrays into a single array, use the plus operator \(\+\). The following example creates two arrays, combines them, and then displays the resulting combined array.  
  
```  
$x = 1,3  
$y = 5,9  
$z = $x + $y  
  
```  
  
 As a result, the $z array contains 1, 3, 5, and 9.  
  
 To delete an array, assign a value of $null to the array. The following command deletes the array in the $a variable.  
  
```  
$a = $null  
```  
  
 You can also use the Remove\-Item cmdlet, but assigning a value of $null is faster, especially for large arrays.  
  
### ARRAYS OF ZERO OR ONE  
 Beginning in [!INCLUDE[wps_2]()] 3.0, a collection of zero or one object has the Count and Length property. Also, you can index into an array of one object. This feature helps you to avoid scripting errors that occur when a command that expects a collection gets fewer than two items.  
  
 The following examples demonstrate this feature.  
  
```  
#Zero objects  
$a = $null  
$a.Count  
0  
$a.Length  
0  
  
```  
  
```  
#One object  
$a = 4  
$a.Count  
1  
$a.Length  
1  
$a[0]  
4  
$a[-1]  
4  
  
```  
  
## SEE ALSO  
 about\_Assignment\_Operators  
  
 about\_Hash\_Tables  
  
 about\_Operators  
  
 about\_For  
  
 about\_Foreach  
  
 about\_While