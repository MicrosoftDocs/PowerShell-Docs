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

* When talking about a cmdlet in paragraph, use \` to highlight cmdlet names
* All PowerShell syntax blocks should use ` \` \` \` powershell
* Do not start PowerShell commands with "C:\ PS>"
* Output emitted by PowerShell commands should be commented to prevent it from recieving syntax highlighting

## Lists

* Do not end list items with a period (unless they contain multiple sentences)
* If your list contains multiple sentences, consider using a header 3/4/5 (as applicable) underneath your primary idea

## Links

* Links are always marked up using MarkDown syntax `[friendlyname](url)`
* Links should have a a friendly name when applicable, most likely the title of the linked page. 
 * **Exception**: Links going towards non-Microsoft sites should only have a URL. 


## Line breaks

* You must include semantic line breaks
* You should limit lines to 100char. (Open item: tooling to help us validate this)
* You CAN remove additional line breaks for PS4+, NOT ps3 (needs validation)


first cmdlet reference should always be a link in an article (not reference) . All related links at the bottom should links

Bold property names and parameter names. 
User-provided input in a syntax block: `<YourPropertyName>`
User-provided input 

Asterisk for bold

Italics are underscore
