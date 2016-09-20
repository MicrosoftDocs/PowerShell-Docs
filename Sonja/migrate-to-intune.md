---
# required metadata

title: Migrate to Intune | Microsoft Intune
description:
keywords:
author: jeffgilb
manager: jeffgilb
ms.date: 04/28/2016
ms.topic: article
ms.prod:
ms.service: microsoft-intune
ms.technology:
ms.assetid: 88936b8a-7453-4410-b6db-29f636ba3e72

# optional metadata

#ROBOTS:
#audience:
#ms.devlang:
ms.reviewer: jeffgilb
ms.suite: ems
#ms.tgt_pltfrm:
#ms.custom:

---

# Migrate to Intune


The migration to Intune from your existing enterprise mobility management solution may follow the general sequence of steps below:

![Migration steps for Intune](./media/migrate-intune-steps.png)

## Notify users

Once you’re comfortable that the Intune pilot deployment has met your requirements, communicate with your users about the upcoming migration of their devices to Intune. Email messages, instructions, and [posters](https://gallery.technet.microsoft.com/Intune-End-User-Enrollment-3a0c9b0c?WT.mc_id=Blog_Intune_General_PCIT) can help set expectations and provide enrollment details on the steps users need to take in order to maintain uninterrupted connectivity to company resources and applications. Make sure your support team is ready to assist users in the migration process.

## Modify your existing enterprise mobility management solution

Depending on how you plan to handle conditional access policies between your existing enterprise mobility management solution and Intune, you may need to disable your existing conditional access policies. You’ll either disable your existing conditional access policies OR scope the existing conditional access policies to not include users/devices you are about to migrate to Intune.  Do not have both Intune and your existing enterprise mobility management solution applying conditional access policies to the same users/devices.

## Enable Intune conditional access policy (optional)

If you’ve decided to immediately enforce the conditional access policies without a grace period for migrating devices, enable conditional access policies in Intune in this step.  Make sure that this decision is well-communicated with your users and your helpdesk team.  If devices aren’t enrolled in Intune and aren’t compliant with Intune policies, users won’t be able to access corporate resources until they enroll in Intune and the devices are compliant with Intune policies.

## Unenrolling devices from your existing enterprise mobility management solution

Devices must be unenrolled from your existing enterprise mobility management solution prior to enrolling in Intune. Our recommendation is to allow users to unenroll their devices themselves for the best user experience.  Be sure to follow the unenrollment guidance from the solution provider to make sure you correctly remove users and devices from your platform, ensuring minimum possible disruption to your end users.

## Enrolling devices in Intune

Users scheduled for migration should immediately enroll in Intune to either regain or prevent loss of access to corporate resources, email, and applications. If you’ve configured conditional access and users try to connect to email before enrolling in Intune, their access is blocked and an enrollment email greets them. This email guides them to enroll their device in Intune.  Alternatively, users can enroll in Intune via the Intune Company Portal app or natively through the operating system on Windows 8.1 and Windows 10 Mobile. Refer to [What to tell your end users about using Microsoft Intune](what-to-tell-your-end-users-about-using-microsoft-intune.md) for further guidance on enrollment steps per platform.

## Configure Intune conditional access (optional)

If you’ve allowed a grace period for conditional access enforcement, enable conditional access policies in Intune to start enforcement when the grace period that you have communicated to your end-users has ended. This will immediately require all devices to meet the requirements of the Intune conditional access policy.

## Enroll remaining devices and users

Now that you have enabled conditional access, all users are required to enroll in Intune and meet your organization’s compliance policies to gain access to corporate resources. If you’ve migrated your users in a phased enrollment (not all at once), repeat the steps above until all the devices and users are enrolled and managed by Intune.

## Retire the previous enterprise mobility management solution

After you’ve migrated all your users and devices to Intune and you’ve validated that the migrations to Intune are successful, you can retire the previous enterprise mobility management solution and/or unsubscribe from the service. Be sure to follow the guidance from the solution provider to make sure you correctly remove any unneeded infrastructure requirements and cancel any subscriptions/licenses.

## Additional migration resources

Do you need extra help with your migration to Intune? We provide expert assistance options to help make sure your migration is trouble-free:

<!--- - [Microsoft Intune Onboarding](/em/solutions/fasttrack-center-benefit-for-enterprise-mobility-suite-ems)--->
- [Microsoft Consulting Services](https://www.microsoft.com/en-us/microsoftservices/default.aspx)
- [Intune technical and non-technical support](/intune/troubleshoot/how-to-get-support-for-microsoft-intune)
- [Microsoft Intune TechNet forum](https://social.technet.microsoft.com/Forums/en-US/home?forum=microsoftintuneprod)

## Get a downloadable copy of this guide

To get a downloadable copy of this entire guide, visit the [TechNet Gallery](https://gallery.technet.microsoft.com/Migrating-to-Intune-ea439387).
