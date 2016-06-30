# Convert-String
**Convert-String** exposes "replace by magic" functionality. Provide before and after examples of how you want text to look, and **Convert-String** formats your text automatically. Here's a demo - taking somebody's first and last name, and replacing it with their last name, a comma, the first initial of their last name, and a dot. Try it with a regex, and see how long it takes you.

```powershell
"Lee Holmes", "Steve Lee", "Jeffrey Snover" | Convert-String -Example "Bill Gates=Gates, B.","John Smith=Smith, J."

Holmes, L.
Lee, S.
Snover, J.
```
