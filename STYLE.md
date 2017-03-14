# Style guide for PowerShell-Docs

## Titles/Headings

* Titles/headings (anything preprended by \#) should be followed with a newline
* Only the first letter of a title and any proper nouns in that title should be capitalized
* Only use \# style headers (as opposed to = or \- style headers):

### Correct

```
# Header 1

## Header 2

### Header 3

```

### Incorrect

```
Header 1
========

Header 2
--------

### Header 3
```

## Syntax

* All PowerShell syntax blocks should use ```powershell, even if they're only one line
* Output emitted by PowerShell should be wrapped in its own syntax block, using only ```


## Lists

* Do not end list items with a period (unless they contain multiple sentences)
* If your list contains multiple sentences, consider using a header 3/4/5 (as applicable) underneath your primary idea

## Links

Links are always marked up using MarkDown syntax `[friendlyname](url)`
Links should have a a friendly name when applicable, most likely the title of the linked page. 
**Exception**: Links going towards non-Microsoft sites should only have a URL. 


##Line breaks:

You MUST include semantic line breaks
You SHOULD limit lines to 100char. (Open item: tooling to help us validate this)
You CAN remove additional line breaks for PS4+, NOT ps3 (needs validation)




Bold, italic, lists?

When talking about a cmdlet in paragraph, use `` to highlight cmdlet names – but first cmdlet reference should always be a link in an article. All links at the bottom should be in related links 

Asterisk for bold

Italics are underscore
