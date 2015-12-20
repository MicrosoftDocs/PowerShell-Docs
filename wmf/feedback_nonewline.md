# NoNewLine parameter
**Out-File**, **Add-Content**, and **Set-Content** now have a new **–NoNewline** switch which simply omits a new line after the output.

PS C:\\Users\\slee&gt; "This is " | Out-File -FilePath Example.txt -NoNewline

PS C:\\Users\\slee&gt; "a single " | Add-Content -Path Example.txt -NoNewline

PS C:\\Users\\slee&gt; "sentence." | Add-Content -Path Example.txt -NoNewline

PS C:\\Users\\slee&gt; Get-Content .\\Example.txt

This is a single sentence.

Without –NoNewline specified, each fragment would be on a separate line:

PS C:\\Users\\slee&gt; "This is " | Out-File -FilePath Example.txt

PS C:\\Users\\slee&gt; "a single " | Add-Content -Path Example.txt

PS C:\\Users\\slee&gt; "sentence." | Add-Content -Path Example.txt

PS C:\\Users\\slee&gt; Get-Content .\\Example.txt

This is

a single

sentence.
