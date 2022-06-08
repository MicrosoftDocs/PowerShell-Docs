### Functions

Avoid using the `return` keyword in your functions. Just place the object variable on its own.

When declaring simple functions leave a space between the function name and the parameters.

```PowerShell
function MyFunction ($param1, $param2) {
    ...
}
```

### Advanced Functions

For Advanced Functions and scripts use the format of `<Verb>-<Noun>` for naming. For a list of
approved verbs the cmdlet `Get-Verb` will list them. On the noun side it can be composed of more
than one joined word using Pascal Case and only singular nouns.

In Advanced Functions do not use the keyword `return` to return an object.

In Advanced Functions you return objects inside the `Process {}` block
   and not in `Begin {}` or `End {}` since it defeats the advantage of the pipeline.

```PowerShell
# Bad
function Get-USCitizenCapability {
    [CmdletBinding()]
    [OutputType([psobject])]
    param (
        [Parameter(Mandatory = $true,
                   ValueFromPipelineByPropertyName = $true,
                   Position = 0)]
        [int16]
        $Age
    )
    process {
        $Capabilities = @{
            MilitaryService = $false
            DrinkAlcohol = $false
            Vote = $false
        }
        if ($Age -ge 18) {
            $Capabilities['MilitaryService'] = $true
            $Capabilities['Vote'] = $true
        }

        $Obj = New-Object -Property $Capabilities -TypeName psobject
    }
    end { return $Obj }
}

# Good
function Get-USCitizenCapability {
    [CmdletBinding()]
    [OutputType([psobject])]
    param (
        [Parameter(Mandatory = $true,
                   ValueFromPipelineByPropertyName = $true,
                   Position = 0)]
        [int16]
        $Age
    )
    process {
        $Capabilities = @{
            MilitaryService = $false
            DrinkAlcohol = $false
            Vote = $false
        }

        if ($Age -ge 18) {
            $Capabilities['MilitaryService'] = $true
            $Capabilities['Vote'] = $true
        }

        New-Object -Property $Capabilities -TypeName psobject
    }
}
```

#### Always use CmdletBinding attribute.

#### Always have at least a `process {}` code block if any parameters takes values from the Pipeline.

#### Specify an OutputType attribute if the advanced function returns an object or collection of objects.

If the function returns different object types depending on the parameter set provide one per
parameter set.

```PowerShell
[OutputType([<TypeLiteral>], ParameterSetName = "<Name>")]
[OutputType("<TypeNameString>", ParameterSetName = "<Name>")]
```

#### When a ParameterSetName is used in any of the parameters, always provide a DefaultParameterSetName in the CmdletBinding attribute.

```PowerShell
function Get-User {
    [CmdletBinding(DefaultParameterSetName = "ID")]
    [OutputType("System.Int32", ParameterSetName = "ID")]
    [OutputType([String], ParameterSetName = "Name")]
    param (
        [parameter(Mandatory = $true, ParameterSetName = "ID")]
        [Int[]]
        $UserID,

        [parameter(Mandatory = $true, ParameterSetName = "Name")]
        [String[]]
        $UserName
    )
    <# function body #>
}
```

#### When using advanced functions or scripts with CmdletBinding attribute avoid validating parameters in the body of the script when possible and use parameter validation attributes instead.

* **AllowNull** Validation Attribute

  The AllowNull attribute allows the value of a mandatory parameter to be null ($null).

  ```PowerShell
  param (
      [Parameter(Mandatory = $true)]
      [AllowNull()]
      [String]
      $ComputerName
  )
  ```

* **AllowEmptyString** Validation Attribute

  The AllowEmptyString attribute allows the value of a mandatory parameter to be an empty string
  ("").

  ```PowerShell
  param (
      [Parameter(Mandatory = $true)]
      [AllowEmptyString()]
      [String]
      $ComputerName
  )
  ```

* **AllowEmptyCollection** Validation Attribute

  The AllowEmptyCollection attribute allows the value of a mandatory parameter to be an empty
  collection (@()).

  ```PowerShell
  param (
      [Parameter(Mandatory = $true)]
      [AllowEmptyCollection()]
      [String[]]
      $ComputerName
  )
  ```

* **ValidateCount** Validation Attribute

  The ValidateCount attribute specifies the minimum and maximum number of parameter values that a
  parameter accepts. Windows PowerShell generates an error if the number of parameter values in the
  command that calls the function is outside that range.

  ```PowerShell
  param (
      [Parameter(Mandatory = $true)]
      [ValidateCount(1,5)]
      [String[]]
      $ComputerName
  )
  ```

* **ValidateLength** Validation Attribute

  The ValidateLength attribute specifies the minimum and maximum number of characters in a parameter
  or variable value. Windows PowerShell generates an error if the length of a value specified for a
  parameter or a variable is outside of the range.

  ```PowerShell
  param (
      [Parameter(Mandatory = $true)]
      [ValidateLength(1,10)]
      [String[]]
      $ComputerName
  )
  ```

* **ValidatePattern** Validation Attribute

  The ValidatePattern attribute specifies a regular expression that is compared to the parameter or
  variable value. Windows PowerShell generates an error if the value does not match the regular
  expression pattern.

  ```PowerShell
  param (
      [Parameter(Mandatory = $true)]
      [ValidatePattern("[0-9][0-9][0-9][0-9]")]
      [String[]]
      $ComputerName
  )
  ```

* **ValidateRange** Validation Attribute

  The ValidateRange attribute specifies a numeric range for each parameter or variable value.
  Windows PowerShell generates an error if any value is outside that range.

  ```PowerShell
  param (
      [Parameter(Mandatory = $true)]
      [ValidateRange(0,10)]
      [Int]
      $Attempts
  )
  ```

* **ValidateScript** Validation Attribute

  The ValidateScript attribute specifies a script that is used to validate a parameter or variable
  value. Windows PowerShell pipes the value to the script, and generates an error if the script
  returns "false" or if the script throws an exception.

  When you use the ValidateScript attribute, the value that is being validated is mapped to the $_
  variable. You can use the $_ variable to refer to the value in the script.

  ```PowerShell
  param (
      [Parameter()]
      [ValidateScript({$_ -ge (get-date)})]
      [DateTime]
      $EventDate
  )
  ```

* **ValidateSet** Attribute

  The ValidateSet attribute specifies a set of valid values for a parameter or variable. Windows
  PowerShell generates an error if a parameter or variable value does not match a value in the set.
  In the following example, the value of the Detail parameter can only be "Low," "Average," or
  "High."

  ```PowerShell
  param (
      [Parameter(Mandatory = $true)]
      [ValidateSet("Low", "Average", "High")]
      [String[]]
      $Detail
  )
  ```

* **ValidateNotNull** Validation Attribute

  The ValidateNotNull attribute specifies that the parameter value cannot be null ($null). Windows
  PowerShell generates an error if the parameter value is null.

  The ValidateNotNull attribute is designed to be used when the type of the parameter value is not
  specified or when the specified type will accept a value of Null. (If you specify a type that will
  not accept a null value, such as a string, the null value will be rejected without the
  ValidateNotNull attribute, because it does not match the specified type.)

  ```PowerShell
  param (
      [Parameter(Mandatory = $true)]
      [ValidateNotNull()]
      $ID
  )
  ```

* **ValidateNotNullOrEmpty** Validation Attribute

  The ValidateNotNullOrEmpty attribute specifies that the parameter value cannot be null ($null) and
  cannot be an empty string (""). Windows PowerShell generates an error if the parameter is used in
  a function call, but its value is null, an empty string, or an empty array.

  ```PowerShell
  param (
      [Parameter(Mandatory = $true)]
      [ValidateNotNullOrEmpty()]
      [String[]]
      $UserName
  )
  ```
