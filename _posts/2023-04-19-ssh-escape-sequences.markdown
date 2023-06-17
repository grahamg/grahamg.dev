---
layout: post
title:  "SSH Escape Sequences"
date:   2023-04-19
categories: unix
---
In many SSH clients that are built in, there are several "hidden" escape sequences prefixed with the '~' character.

The sequence `~?` prints the help message containing all of the available escape sequences supported. For example,
the Terminal client in MacOS lists the available options noted below.

```
Supported escape sequences:
 ~.   - terminate connection (and any multiplexed sessions)
 ~B   - send a BREAK to the remote system
 ~C   - open a command line
 ~R   - request rekey
 ~V/v - decrease/increase verbosity (LogLevel)
 ~^Z  - suspend ssh
 ~#   - list forwarded connections
 ~&   - background ssh (when waiting for connections to terminate)
 ~?   - this message
 ~~   - send the escape character by typing it twice
(Note that escapes are only recognized immediately after newline.)
```

(For any of these escape sequences to work as intended, it is only recognized immediately after a new line.)

This means that for the escape sequence to take effect a preceding newline is required.

Additionally, if you used SSH to get into host A and then another SSH session to get from host A into host B, to break the A-B connection you need to issue `~~.`
