---
layout: post
title:  "Recommended Parameters for SSH Key Generation"
date:   2023-01-16
categories: unix
---
If your not using ED25519 Twisted Edwards curve key pairs, you should be. If you've created your key using software released before 2013 with the default options it's probably insecure (RSA < 2048 bits).

Ed25519 keys are short. Very short. If you're used to copy multiple lines of characters from system to system you'll be happily surprised with the size. The public key is just about 68 characters. It's also much faster in authentication compared to secure RSA (3072+ bits).

With ssh-keygen use the -o option for the new RFC4716 key format and the use of a modern key derivation function powered by bcrypt. Use the -a <num> option for <num> amount of rounds.

`ssh-keygen -a 100 -t ed25519 -f ~/.ssh/key-file -C "user@domain.tld"`

Note the line 'Your identification has been saved in /home/user/.ssh/id_ed25519'. 

Then add the newly generated key to your SSH agent.

`ssh-add ~/.ssh/key-file`
