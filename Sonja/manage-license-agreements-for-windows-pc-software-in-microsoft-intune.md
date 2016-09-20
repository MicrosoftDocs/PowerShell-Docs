---
# required metadata

title: Manage software license agreements for PCs running the Intune software client | Microsoft Intune
description: Intune lets you manage license agreements for software purchased through Microsoft Volume Licensing agreements, and for software that was purchased by other means.
keywords:
author: robstackmsft
manager: angrobe
ms.date: 09/14/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: c59d8635-3f66-40f5-824a-a71c738e0341

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: owenyen
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Manage license agreements for Windows PC software in Microsoft Intune
Microsoft Intune lets you add and manage license agreement information for software that was purchased through Microsoft Volume Licensing agreements. You can also do this for Microsoft or non-Microsoft software that was purchased by other means. You can organize this information into logical groups.

> [!IMPORTANT]
> This feature is provided for convenience only, and accuracy is not guaranteed. You should not rely on it to confirm compliance with Microsoft Volume Licensing agreements. Microsoft will not use any data gathered to investigate potential violations of, or compliance with, license agreements you may have with us.
>
> Licenses you add to Intune do not affect your license agreements or entitlements to use your software. For example, if you delete a license/agreement pair from Intune, you do not delete or nullify license agreements that exist between you and Microsoft.

In the **Licenses** workspace of the Intune administration console, you can:

-   Add and edit Microsoft Volume Licensing agreements.

-   Add and edit other software licensing agreements.

-   Manage licenses and groups.

-   Compare the entitlement information that Intune retrieves from the Volume Licensing Service Center (VLSC) to the inventory of Microsoft software that Intune detects on your managed Windows PCs.

Additionally, you can generate reports that show installation and license counts for software titles. License reports can help you assess your complete license position for Microsoft software and non-Microsoft software titles.

> [!TIP]
> The **Licenses** workspace is not displayed in the administrator console until you are managing at least one Windows PC with the Intune Windows PC client.

## Add Microsoft Volume Licensing agreements
Intune Volume Licensing agreements provide license information for software that was purchased through Microsoft Volume Licensing agreements. You can add Microsoft Volume Licensing agreements to Intune by providing matched pairs of agreement numbers. The agreement or authorization numbers must be matched to the correct license or enrollment numbers. Agreement number pairs are obtained when you purchase your license agreements from the [Volume Licensing Service Center (VLSC)](http://go.microsoft.com/fwlink/?LinkID=223842).

1.  In the [Microsoft Intune administrator console](https://account.manage.microsoft.com/admin/default.aspx), choose **Licenses**.

2.  On the **Add Agreements** page, under **Choose Agreement Type**, select **Volume Licensing agreement**.

3.  In the **Add Agreement Details** section, choose whether you want to upload a file, or manually add the details.

    -   **Upload a CSV file that contains agreement details**. Choose **Browse** and select the CSV file you want to upload.

        -   The file can contain either two or three columns; two for agreement pairs alone, or three if you want to add a friendly name for each agreement pair.

        -   The total number of characters in an agreement number pair cannot exceed 16 ASCII characters.

        -   Only ASCII characters are supported.

        -   The following characters are not allowed in the agreement name: **~ ! @ # $ ^ &amp; &#42; ( ) = + [ ] { } \ | ; : ' " &lt; &gt; /**. Spaces are allowed in the name.

        -   The file name must be no more than 128 characters in length.

        -   The file must contain at least one agreement pair, and cannot contain more than 5,000 agreement pairs.

        **Format for the file**

        You can create this file by adding your agreement pairs to a plain text document in one of the following formats, depending on the organization type that you have registered with the VLSC. Specify one agreement number pair per line.

        -   **Open Value customers:** *Agreement number*, *repeat agreement number*, *agreement name*

        -   **Open customers:** *Authorization number*, *related license number*, *agreement name*

        -   **Select and Enterprise customers:** *Agreement number*, *related enrollment number*, *agreement name*

        The **Add Agreements** form prompts you to browse for this file when you add a new agreement.

        The following is an example of .csv file content for an Open Value customer.

        `01-07001, 01-07001, Office agreements`

    -   **Manually add agreement details**. Provide the following information, and then type the agreement number pairs in the **Authorization/Agreement number** and **License/Enrollment/Customer number** boxes. After you type both numbers, choose the **Add pair** icon to save your numbers, and then optionally add a new pair.

        -   **Agreement name** - Specify a unique name for the agreement.

            The agreement name can have a maximum of 256 characters, and cannot contain the following characters: **~ ! @ # $ ^ &amp; &#42; ( ) = + [ ] { } \ | ; : ' " &lt; &gt; /**. Spaces are allowed in the name.

        -   **Authorization/Agreement number** - Enter the authorization/agreement number of the license pair.

        -   **License/Enrollment/Customer number** - Enter the license/enrollment/customer number of the license pair.

        > [!NOTE]
        > If you add several agreement number pairs, Intune creates one agreement with the name that you specify, and all pairs that you added are a part of this agreement.

    You can choose **+** to add another agreement number pair, or **-** to remove an agreement number pair you have already entered.

4.  In the **Select License Group** area, do one of the following:

    -   **Add the agreements to the Unassigned Agreements group**. Select this if you do not want to add the new agreements to a license group.

    -   **Add the agreements to a new license group**. Provide a name for the new license group.

    -   **Add the agreements to an existing license group**. In the **Group name** list, select the license group to which you want to add the agreements.

5.  Choose **OK**.

The **All Agreements** view is displayed, and Intune connects to the Microsoft VLSC to validate the agreement number pairs that you provided.

To update the volume license information after you have added license agreements in Intune, in the **Licenses Overview** page, choose **Refresh Now**. This action retrieves the current license information from the [Microsoft Volume Licensing Service Center (VLSC)](http://go.microsoft.com/fwlink/?LinkId=223842).

> [!IMPORTANT]
> Until you refresh the volume licensing information, you may see different information in the agreements list and the entitlement information on the **Agreements Overview** page.

After you refresh the volume license information, you can compare the license information to your detected Microsoft software in the **Apps** workspace. You can also run the following license reports:

-   **License Purchase Reports** - Lets you view the licensed software in license groups you select to help you find gaps in coverage.

-   **License Installation Reports** - Helps you determine if you have sufficient license agreement coverage.

> [!NOTE]
> The **Product Title** displayed for all Microsoft Volume License agreements is **Not available**.

## Add and edit other software licensing agreements
You can also add other types of license agreements to Intune in addition to Microsoft Volume Licensing agreements. These agreements can include non-Microsoft software, or Microsoft software that was purchased through a retailer.

> [!IMPORTANT]
> You must have at least one Windows PC enrolled in Intune before you can add an agreement.  In addition, at least one enrolled computer must have uploaded a licensable software package that you want to use to add a license agreement.

### To add other software agreements

1.  In the [Microsoft Intune administrator console](https://account.manage.microsoft.com/admin/default.aspx), choose **Licenses**.

2.  Choose **Add Agreements** in the **Other Software Licensing Agreements** section.

3.  Select **Other software licensing agreement** in the **Choose Agreement Type** section of the **Add Agreements** page.

4.  In the **Add Agreement Details** area, specify the following:

    -   **Agreement name** (required). The agreement name can have a maximum of 256 characters, and cannot contain the following characters: **~ ! @ # $ ^ &amp; &#42; ( ) = + [ ] { } \ | ; : ' " &lt; &gt; /**. Spaces are allowed in the name.

    -   **Publisher** (required). When you start to type a publisher name, the service retrieves all publisher names that contain the letters that you type. For example, if you type “soft,” the service retrieves all publisher names that contain “soft” as part of the name, such as “Microsoft” and “Microsoft Research.” The publisher names are retrieved from the Software Asset Catalog. You must select the publisher before you can enter the product title.

        > [!IMPORTANT]
        > The company that you want to add might not appear in this list. You can only add software agreements for companies that are already present in the software asset catalog. However, Microsoft continuously works to add the most popular software titles. If you would like to submit a request to have a company added to this list, you can do so at the [Intune Uservoice site](https://microsoftintune.uservoice.com/).

    -   **Product title** (required). When you start to type a product title, the service retrieves all product titles that contain the letters that you type. You must specify a **Publisher** before you can specify a **Product title**.

    -   **License count** (required). Enter the number of purchased licenses.

    -   **License start date**. Enter the start date of license coverage.

    -   **License end date**. Enter the end date of license coverage.

    -   **Agreement details**. You can optionally specify contact information, registration keys, and other information.

5.  In the **Select License Group** area, do one of the following:

    -   Select **Add the agreements to the Unassigned Agreements group** if you do not want to add the new agreements to a new or existing license group. You can add the agreements to user-defined license groups at any time.

    -   Select **Add the agreements to a new license group** to add the new agreements to a new license group. You are prompted to provide a name for the new license group.

    -   Select **Add the agreements to an existing license group** to add the new agreements to an existing license group. In the **Group name** list, select the license group to which you want to add the agreements.

6.  Choose **OK**.

The **All Agreements** list view is displayed.

## Manage license agreements
Software licensing agreements can be added to license groups. You can use license groups to organize your license agreements in units that are logical for your organization. Additionally, you can delete license agreements you previously created.

|||
|-|-|
|Task|Details|
|Create a license group|On the **Overview** page of the **Licenses** workspace, choose **Create License Group** from the **Tasks** menu. **Note:** You can create a maximum total of 500 license groups.|
|Rename a license group|In the **Licenses** workspace, choose a license group, and then choose **Edit License Group** from the **Tasks** Menu.|
|Delete a license group|In the **Licenses** workspace, choose a license group, and then choose **Delete License Group** from the **Tasks** Menu. **Tip:** Any licenses that were in the deleted group are moved to the **Unassigned agreements** license group.|
|Delete a license agreement|In the **Licenses** workspace, choose an agreement, and then choose **Delete**. **Tip:** After you delete Volume Licensing agreements, to update the license information, choose **Refresh Now** on the **Licenses Overview** page or on the **General** tab for a specific license group.|
