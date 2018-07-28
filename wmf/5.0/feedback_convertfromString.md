---
ms.date:  06/12/2017
keywords:  wmf,powershell,setup
---
# Extract and Parse Structured Objects out of String

This also introduces some additional functionality for the `ConvertFrom-String` cmdlet:

- Removes the extent text property by default. You can include it with the -IncludeExtent parameter.

- Many learning algorithm bug fixes from MVP and community feedback.

- A new -UpdateTemplate parameter to save the results of the learning algorithm into a comment in the template file. This makes the learning process (the slowest stage) a one-time cost. Running Convert-String with a template that contains the encoded learning algorithm is now nearly instantaneous.

## Extract and parse structured objects out of string content

In collaboration with [Microsoft Research](https://www.microsoft.com/en-us/research/?from=http%3A%2F%2Fresearch.microsoft.com%2F), a new `ConvertFrom-String` cmdlet has been added.

This cmdlet supports two modes: basic delimited parsing, and auto generated example-driven parsing.

Delimited parsing, by default, splits the input at white space, and assigns property names to the resulting groups. You can customize the delimiter:

```powershell
"Hello World" | ConvertFrom-String | Format-Table -Auto
```

```output
P1     P2
--     --
Hello  World
```

The cmdlet also supports auto-generated example-driven parsing based on the [FlashExtract](https://www.microsoft.com/en-us/research/publication/flashextract-framework-data-extraction-examples/?from=http%3A%2F%2Fresearch.microsoft.com%2Fen-us%2Fum%2Fpeople%2Fsumitg%2Fflashextract.html) research work in [Microsoft Research](https://www.microsoft.com/en-us/research/?from=http%3A%2F%2Fresearch.microsoft.com%2F).

To get started, consider a text-based address book:

```
    Ana Trujillo

    Redmond, WA

    Antonio Moreno

    Renton, WA

    Thomas Hardy

    Seattle, WA

    Christina Berglund

    Redmond, WA

    Hanna Moos

    Puyallup, WA
```

Copy a few examples into a file, which you will use as your template:

```
    Ana Trujillo

    Redmond, WA

    Antonio Moreno

    Renton, WA
```

Put curly braces around data that you want to extract, giving it a name as you do so. Because the **Name** property (and its associated other properties) can appear multiple times, use an asterisk (\*) to indicate that this results in multiple records (rather than extracting a bunch of properties into one record):

```
    {Name\*:Ana Trujillo}

    {City:Redmond}, {State:WA}

    {Name\*:Antonio Moreno}

    {City:Renton}, {State:WA}
```

From this set of examples, `ConvertFrom-String` can now automatically extract object-based output from input files with similar structure.

```powershell
Get-Content .\addresses.output.txt | ConvertFrom-String -TemplateFile .\addresses.template.txt | Format-Table -Auto
```

```output
ExtentText                     Name               City     State
----------                     ----               ----     -----
Ana Trujillo...                Ana Trujillo       Redmond  WA
Antonio Moreno...              Antonio Moreno     Renton   WA
Thomas Hardy...                Thomas Hardy       Seattle  WA
Christina Berglund...          Christina Berglund Redmond  WA
Hanna Moos...                  Hanna Moos         Puyallup WA
```

To do additional data manipulation on extracted text, the **ExtentText** property captures the raw text from which the record was extracted. To provide feedback on this feature, or to share content for which you are having difficulty writing examples, please email <psdmfb@microsoft.com>.