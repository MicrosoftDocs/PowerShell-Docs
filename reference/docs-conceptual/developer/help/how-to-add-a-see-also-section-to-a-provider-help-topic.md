---
ms.date: 09/12/2016
ms.topic: reference
title: How to Add a See Also Section to a Provider Help Topic
description: How to Add a See Also Section to a Provider Help Topic
---
# How to Add a See Also Section to a Provider Help Topic

This section explains how to populate the **SEE ALSO** section of a provider help topic.

The **SEE ALSO** section consists of a list of topics that are related to the provider or might help
the user better understand and use the provider. The topic list can include cmdlet help, provider
help and conceptual ("about") help topics in Windows PowerShell. It can also include references to
books, paper, and online topics, including an online version of the current provider help topic.

When you refer to online topics, provide the URI or a search term in plain text. The `Get-Help`
cmdlet does not link or redirect to any of the topics in the list. Also, the `Online` parameter of
the `Get-Help` cmdlet does not work with provider help.

The **See Also** section is created from the `RelatedLinks` element and the tags that it contains.
The following XML shows how to add the tags.

### To Add SEE ALSO Topics

1. In the `<AssemblyName>.dll-help.xml` file, within the `providerHelp` element, add a
   `RelatedLinks` element. The `RelatedLinks` element should be the last element in the
   `providerHelp` element. Only one `RelatedLinks` element is permitted in each provider help topic.

   For example:

    ```xml
    <providerHelp>
        <RelatedLinks>
        </RelatedLinks>
    </providerHelp>
    ```

1. For each topic in the **SEE ALSO** section, within the `RelatedLinks` element, add a
   `navigationLink` element. Then, within each `navigationLink` element, add one `linkText` element
   and one `uri` element. If you are not using the `uri` element, you can add it as an empty element
   (\<uri/>).

   For example:

    ```xml
    <providerHelp>
        <RelatedLinks>
            <navigationLink>
                <linkText> </linkText>
                <uri> </uri>
            </navigationLink>
        </RelatedLinks>
    </providerHelp>
    ```

1. Type the topic name between the `linkText` tags. If you are providing a URI, type it between the
   `uri` tags. To indicate the online version of the current provider help topic, between the
   `linkText` tags, type "Online version:" instead of the topic name. Typically, the "Online
   version:" link is the first topic in the SEE ALSO topic list.

   The following example include three SEE ALSO topics. The first refer to the online version of the
   current topic. The second refers to a Windows PowerShell cmdlet help topic. The third refers to
   another online topic.

    ```xml
    <providerHelp>
        <RelatedLinks>
            <navigationLink>
                <linkText> Online version: </linkText>
                <uri>http://www.fabrikam.com/help/myFunction.htm</uri>
            </navigationLink>
            <navigationLink>
                <linkText> about_functions </linkText>
                <uri/>
            </navigationLink>
            <navigationLink>
                <linkText> Windows PowerShell Getting Started Guide </linkText>
                <uri>https://go.microsoft.com/fwlink/?LinkID=89597<uri/>
            </navigationLink>
        </RelatedLinks>
    </providerHelp>
    ```
