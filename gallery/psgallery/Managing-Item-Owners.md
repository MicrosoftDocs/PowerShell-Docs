# Managing Item Owners

Ownership of an item in the PowerShell Gallery is defined by who published the item to the gallery.
Sometimes this metadata needs to be managed beyond the initial item publishing, which means the owner metadata needs to be mutable while the item itself is not.

All item owners are peers. 
This means any item owner can publish a new version of an item. It also means that any item owner can remove any other item owner. 
No owner has more authority than other owners.  

## Setting an Item's Initial Owner 

When a new item is published to PowerShell Gallery, the initial owner is defined by the user that published the item. This is determined by whose API key was used in the Publish-Module cmdlet.

## Adding Owners

Once an item has been published to the PowerShell Gallery, it's easy to invite additional users to become owners of an item.

1. [Log on](https://powershellgallery.com/users/account/LogOn) to the PowerShell Gallery with the account that is the current owner of an item.
2. Navigate to an item page using the 'Items' tab, searching, or clicking your username and then [**Manage My Items**](https://www.powershellgallery.com/account/Packages).
3. When logged on as an item's owner, there is a 'Manage Owners' link on the left side to click.
4. Enter the username of the person to add as an owner and click 'Add'.
5. An email is then sent to the new co-owner, as an invitation to become an owner of an item.
6. Once that user clicks the link, they are a full co-owner with full control over an item, including the ability to remove other users as owners.

**NOTE**: Until the new owner confirms ownership, they *will not* be listed as an owner of an item.
When viewing the **Manage Owners** page, you will see a "pending approval" entry in the current owners.
That invitation can be removed; just as other owners can be removed.
This process of invitations prevents users from falsely adding other users as owners of their items.

Note that the "Authors" metadata is purely freeform text; only "Owners" are controlled.


## Removing Owners
When an item has multiple owners and one needs to be removed, the process is simple:

1. [Log on](https://powershellgallery.com/users/account/LogOn) to PowerShell Gallery with the account that is the current owner of an item;
2. Navigate to an item page using the Items tab, searching, or clicking your username and then [**Manage My Items**](https://www.powershellgallery.com/account/Packages).
3. When logged on as an item's owner, there is a 'Manage Owners' link on the left side to click;
4. Click the 'remove' link next to the owner to be removed.



## Transferring Item Ownership
We sometimes get support requests to transfer item ownership from one user to another, but you can almost always accomplish this yourself.
Transferring ownership from one user to another is simply a combination of the two features above.

1. The current owner invites the new user to become a co-owner and the new user accepts the invite;
2. The new user removes the old user from the list of owners.

This request has come in under a couple forms but the process works the same.

* The item ownership is changing from one developer to another
* The item was accidentally published using the wrong account


## Orphaned Items
One last scenario has occurred, but not many times.
Items have become orphans and the only item owner account cannot be used to add new owners.
Here are some examples of this scenario:

* The owner's account is associated with an email address that no longer exists and the user has forgotten their password
* The registered owner has left the company that produces the item and cannot be reached to update the item ownership
* Due to a bug that has only affected a handful of items, the item is somehow ownerless on the gallery

The PowerShell Gallery Administrators can access the 'Manage Owners' link for any item.
If you are the rightful owner of a item and cannot reach the current owner to gain ownership permissions, then use the 'Report Abuse' link on the gallery to reach the PowerShell Gallery Administrators.
We will then follow a process to verify your ownership of the item.
If we determine you should be an owner of the item, we will use the 'Manage Owners' link for the item ourselves and send you the invite to become an owner.
We will only do this after verifying that you should be an owner and the process for this varies by circumstances.
Often times, we will use the item's Project URL to find a way to contact the project owner, but we may also use Twitter, Email, or other means for contacting the project owner.