# Objects, not text

What makes PowerShell different than all other shell scripting languages is that
the *pipeline* takes '.Net' objects instead of text. This means that when
something is written to the output, what goes out is the instance of that object,
not a text representation of the object.

Why is this a big difference?

Well, to start with something. Let's say we want to know the total size of all
images in a folder or directory in your computer.  
In traditional shells you would run a 'dir' or 'ls' command to find all
pictures in the folder and folders below. If we use the CMD console window to
look for all 'jpg' files in current folder and subfolders issuing `dir /s *.jpg`,
we would get something like the next image.

![command prompt list all jpg files](command-prompt-list-all-jpgs.png)

But, the only thing we need are the file sizes. If what we receive is text,
extracting the sizes and adding them it's going to be an interesting challenge;
because we have to inspect each line, filter lines to be sure are file lines not
folder lines, find where in the line is the size information located, convert
the value according to locale setup and sum those values.

Now, can we prove the output is all text?

Let's look at what happens when we issue the following command
`dir /s *.jpg | sort`.

![command prompt list all jpg files sorted](command-prompt-list-all-jpgs-sorted.png)

Well, the output is neatly sorted in alphabetical order, line by line; so, it is
text. We don't want to spend much time here talking about the CMD shell and the
*sort* command; just let's finish this point saying that the *sort* command
sorts it's input as a text file (see:
[Windows Server Sort command](https://technet.microsoft.com/en-us/library/cc771264.aspx)).

## Everything in the pipeline is an object

Now, let's focus on the subject of this topic: in PowerShell everything placed
in the *pipeline* is an object (a '.Net' object).

So, hands down to the task at hand: find the space or total size of all pictures
in the current folder and subfolders. For this purpose we'll write and execute
some PowerShell commands.

> Note  
> Open your PowerShell ISE environment to better follow the rest of this section.
>If you don't remember how to open ISE, check the [learners setup guide](basic-setup.md)

>Note  
>You're not expected to know all the details of the cmdlets we're going to use;
>just follow the explanations, you'll be guided to look into the relevant parts
>first and helped to make all connections.  

>Note  
>Also, for teaching purposes, when possible in this page, we'll use the same
>names you know from CMD in PowerShell instead of the proper cmdlet name
>(verb-noun). Most CMD command names were ported over to PowerShell to ease the
>transition.

Let's try the 'dir' command with some adjustments to PowerShell syntax:  
`dir "*.jpg" -recurse` and `dir "*.jpg" -recurse | sort`; and compare results.  
As you can imagine the '*-recurse*' parameter is the equivalent of '/s' for
searching subdirectories.

![Powershell list all jpgs compared](Powershell-list-all-jpgs-compared.png)

This is disappointing! There are no differences, what's wrong?  
(actually there's a tiny difference, but not what we were expecting; so, for the
moment we'll just ignore the difference)

OK, these are objects or at least that's the claim here.

If they are object they have properties and most probably the sort cmdlet
expects to know the property we want to sort on.  

Let's try a small tweak here: `dir "*.jpg" -recurse | sort -property length`

![powershell list all jpgs length sort](powershell-list-all-jpgs-length-sort.png)

As you can see in the image above, pictures are sorted by length.  
This has to mean the pipeline is receiving something of the kind of a filesystem
object, with a property named length.

In PowerShell you can always examine the objects in the pipeline using the
'*Get-Member*' cmdlet. The following line in the ISE should tell us what kind of
objects are laid in the pipeline for the '*dir*' cmdlet:  
`dir "*.jpg" -recurse | Get-Member`.

![Get-Member for Dir cmdlet](Get-Member-for-Dir-cmdlet.png)

As you can see, the '*Dir*' cmdlet is throwing into the pipeline standard '.Net'
FileInfo objects, with very little additions: like the NoteProperties and the
CodeProperty (compare with [MSDN: FileInfo Class](https://msdn.microsoft.com/en-us/library/system.io.fileinfo.aspx)).

With the knowledge that everything in the pipeline is an object and the concepts
learnt in the [Introduction](fundamental-introduction.md), let's crack open a
cmdlet to summarize the space used by the files in a given folder and folders
under it.

>Note   
>You remember not to panic, because everything will be explained.
>If you haven't read the [Introduction](fundamental-introduction.md) and the
>following lines seem too intimidating to continue...  
>read the Introduction and you'll feel ready.

```
function Report-SizeByFileType {
    [CmdletBinding()]
    Param(
        [parameter (ValueFromPipeline=$true)] $pipeobject
    )

    begin {
        $dict = @{};
    }

    process {
        if($pipeobject -is [System.IO.FileInfo]) {
            $dict[$pipeobject.Extension] += $pipeobject.Length
        }
    }

    end {
        Write-Output $dict
    }
}
```

Writing in the ISE console pane the following command  
`dir  -recurse | Report-SizeByFileType`  
should produce the similar results (if you're located in your pictures folder or
similar folder with some nested subfolders).
