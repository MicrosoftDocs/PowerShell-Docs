# Actions PowerShell Code

This folder contains the PowerShell used in these actions.

The [scripts folder][scripts] holds the actual scripts which are used by the actions. To
keep the action definitions relatively minimal and to ensure the code can be tested, documented,
and more easily maintained, the functionality of each action is kept in a separate script file. For
more information, check that folder's [readme][scripts] or each script's reference documentation in
that same folder.

The [**gha** module][module] includes helper functions and is only intended to be used by the
scripts in this folder. In the future, much of this functionality _may_ be abstracted away into a
publicly published module. For more information, see the [module's readme][module] or review the
reference documentation for each function.

[module]: ./module/readme.md
[scripts]: ./scripts/readme.md
