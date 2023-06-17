---
layout: post
title:  "User Friendly Resource Naming with Hashes"
date:   2023-05-01
categories: review rfc
---
The following is a disccusion and summary of the RFC, "Naming Things with Hashes": <https://www.rfc-editor.org/rfc/rfc6920.html>

Imagine a world where resources are effortlessly identified using intelligent naming conventions. In the vast realm of protocols and systems, such identification has often been a source of chaos. But fear not, for a groundbreaking solution has arrived: the Named Information (NI) identifier scheme. Let's dive into this fascinating realm and explore how it enhances resource naming with the magic of hash functions.

The NI URI Format: Cracking the Code
Think of NI URIs as the secret code that unlocks the true identity of resources. By combining various components, including the scheme name, authority, digest algorithm, and digest value, NI URIs provide a standardized and structured approach to naming resources. For example, an NI URI might look like this: ni:///sha-256;UyaQV-Ev4rdLoHyJJWCi11OHfrYv9E1aGQAlMO2X_-Q. It's like a digital fingerprint that uniquely identifies a resource in the vast digital universe.

Mapping with .well-known URI: The Gateway to Accessibility
Imagine a scenario where some clients are unaware of the NI scheme. How can they access these named resources? Fear not, for the NI scheme has a secret gateway—the .well-known URI. By cleverly mapping NI URIs to HTTP(S) URLs using the .well-known namespace, clients without NI support can seamlessly access named resources. It's like having a master key that opens doors to a whole new world of resources.

Binary Format: Compact and Powerful
In a world where space is precious, a more compact representation is often desired. That's where the binary format comes into play. It condenses the NI name into a header and hash value, making it more space-efficient. This binary format supports various hash algorithms and truncation lengths, ensuring flexibility while saving valuable resources. Imagine a 128-bit identifier efficiently representing a resource in a protocol that craves efficiency and speed.

Human-Speakable NIH URI Format: The Language of Resources
Now, let's explore the human side of resource naming. Sometimes, we need to speak the names of resources, whether over a phone call or in a voice command. That's where the Human-Speakable (NIH) URI format shines. It provides an intuitive and easily pronounceable representation. For example, an NIH URI might look like this: nih:sha-256;uyaq-v-ev4rd-lohy-jjwci-11ohf-ryv9e-1agqa-lmo2x-q;5. It's like a secret language that bridges the gap between humans and the digital realm.

Summary:
With the Named Information (NI) identifier scheme, resource naming has evolved into a seamless and powerful process. The NI URI format brings structure and standardization, ensuring resources are accurately identified. The mapping with the .well-known URI extends accessibility to all clients, even those unaware of the NI scheme. The binary format optimizes space efficiency, while the human-speakable NIH URI format enables easy communication with resources. Together, these advancements revolutionize the way we name and interact with resources, simplifying our digital lives while enhancing security and usability. So, embrace the power of NI and unlock a world where resources reveal their true identities at a glance.
