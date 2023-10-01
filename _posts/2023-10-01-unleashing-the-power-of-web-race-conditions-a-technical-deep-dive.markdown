---
layout: post
title:  "Unleashing the power of web race conditions: A technical deep dive"
date:   2023-10-01
categories: race conditions programming
---
References:

1. https://www.youtube.com/watch?v=tKJzsaB1ZvI
2. https://i.blackhat.com/BH-US-23/Presentations/US-23-Kettle-Smashing-the-state-machine.pdf

As professional software developers, we are well aware that vulnerabilities in web applications can sometimes be puzzling, leaving us scratching our heads and wondering, "How is this even possible?" One such category of vulnerabilities that often falls into this enigmatic realm is known as web race conditions. In this technical blog post, we will delve deep into the world of web race conditions, exploring their true potential and introducing a novel technique to detect and exploit them effectively.

## Understanding Web Race Conditions

**Race Conditions in Web Applications**

A race condition occurs when multiple concurrent processes or threads access shared resources simultaneously, leading to unpredictable and often unintended behavior. In web applications, race conditions manifest when specific sequences of user actions or HTTP requests lead to unexpected outcomes. These vulnerabilities are not always apparent and can be challenging to identify and reproduce.

**Classic Examples of Web Race Conditions**

Before we delve into the technical details, let's look at some classic examples of web race conditions:

1. **Reuse of Single-Use Vouchers**: Imagine a scenario where a user attempts to redeem a single-use voucher multiple times within a short time window due to a race condition.

2. **Bypassing Rate Limits**: A race condition might allow a user to bypass rate limits imposed on certain actions, leading to potential abuse.

3. **Reviewing a Product Multiple Times**: In some cases, users might exploit a race condition to submit multiple reviews for a single product.

4. **Recaptcha Exploitation**: One intriguing example involves reusing a valid reCAPTCHA solution multiple times within a short time frame, as reported to Google.

**Beyond Limit Overruns**

While the examples above can be categorized as limit overruns, web race conditions are not limited to these scenarios. They can manifest in unexpected ways, leading to complex and subtle vulnerabilities that are not immediately apparent.

## Unveiling the True Potential

**Race Conditions on the Web: The Untapped Potential**

Josip Franjković's blog post, "Race Conditions on the Web," sheds light on the world of web race conditions. In this post, he describes a vulnerability that took two months to replicate, where Facebook would generate two confirmation codes for two different email addresses using different parameter names in a single email. This was not a typical limit overrun; it was something more complex.

The realization that race condition attacks can be far more intricate and impactful than initially thought prompted a deeper exploration of this attack class. In this blog post, we aim to uncover the true potential of web race conditions, providing you with tools, techniques, case studies, and a live demonstration of their capabilities.

## Introducing the Single-Packet Attack

**Eliminating Network Jitter**

One of the primary challenges in detecting race conditions is dealing with network jitter, which introduces random delays in requests, making it difficult to align the race windows. To overcome this obstacle, we introduce the "single-packet attack."

**How the Single-Packet Attack Works**

The single-packet attack is built on the principles of TCP and HTTP. It involves sending 20 to 30 HTTP requests within a single packet, ensuring that they arrive at the server simultaneously, regardless of network jitter. This innovative technique eliminates the variability introduced by network delays and significantly enhances the efficiency of race condition discovery.

## The Technical Implementation

**Technical Implementation of the Single-Packet Attack**

Implementing the single-packet attack is surprisingly straightforward. By creatively leveraging Nagle's algorithm, which is present in all operating system network stacks, you can avoid the need to code a custom TCP or TLS stack. Instead, you can extend an existing HTTP/2 library to incorporate this feature, making it accessible and adaptable.

## Performance Benchmarking

**Measuring the Impact**

To assess the effectiveness of the single-packet attack, we conducted performance benchmarking. We compared it with the previous best-known technique, last-byte synchronization. The results were compelling:

- Last-Byte Synchronization: Median spread of 4ms, standard deviation of 3ms.
- Single-Packet Attack: Median spread of 1ms, standard deviation of 0.3ms.

In practical terms, the single-packet attack makes remote race conditions appear local by eliminating network jitter, resulting in four to ten times improved performance compared to previous methods.

## Identifying and Exploiting Web Race Conditions

**A Three-Step Methodology**

Detecting and exploiting web race conditions requires a systematic approach. We propose a three-step methodology:

1. **Prediction**: Identify potential collision points in your application where race conditions might occur. Focus on areas with severe consequences.

2. **Probe for Clues**: Benchmark normal behavior and look for anomalies when sending requests concurrently. Deviations from the baseline may indicate the presence of a race condition.

3. **Proof of Concept**: Understand the behavior, replicate it, and explore the impact. Be prepared to investigate deeply and uncover hidden vulnerabilities.

## Case Study: GitLab's Email Verification Process

**Practical Application of the Methodology**

To illustrate the methodology in action, let's examine a case study involving GitLab's email verification process. We initially discovered a race condition that allowed multiple invitations with the same email address, resulting in privilege escalation.

## Going Beyond the Obvious

**Expanding the Scope**

While investigating the GitLab case, we didn't stop at the first exploit we found. We explored the application further, seeking out security-relevant features that relied on the same structural weakness. This approach led to more significant discoveries and higher-impact vulnerabilities.

## Conclusion

Web race conditions are a fascinating and often overlooked class of vulnerabilities that can have a substantial impact on web applications. By understanding their true potential, adopting innovative techniques like the single-packet attack, and following a systematic methodology for detection and exploitation, software developers can enhance the security of their applications.

In a constantly evolving threat landscape, staying ahead of the curve and exploring the intricacies of web race conditions can make all the difference in ensuring the resilience of your web applications. Happy hunting for those elusive vulnerabilities!
