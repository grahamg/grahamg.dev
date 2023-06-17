---
layout: post
title:  "Proposal: The Pipe Operator for JavaScript"
date:   2023-01-22
categories: programming javascript
---
I give you the *[Proposal for the Pipe Operator for JavaScript](https://github.com/tc39/proposal-pipeline-operator)*.

This is a proposal for JS language feature that optimizes for the fewest possible characters as through
fewer characters means "more readable", or more understandable.

The proposal is an entire language feature and syntax to support a single construct

`a(b(c(d())))`

Which is frankly not anything remotely common enough to warrant a custom syntax.

Their argument against this is that it's hard to read if the nesting is too deep, and the temporaries are unclear,
especially if their it's reused. This is an absurd argument. Why should you be reusing a single temporary unless again
you believe in optimizing for the fewest characters written. Heh, as if that were the core metric for developer productivity.

The proposal attempts to justify this by saying the proposal applies to other cases

`a(b(c(), d()))`

By reusing the % operator as an unnamed token is more readable

`c() |> b(%, c() |> d`

Which is more characters and I'd say much less readable, but also is half-assed: which function should get to be %?

The anchor also has orthogonality problems

`a |> (c |> f(%)) |> d`

The obvious response is "don't do that, it's unreadable", but that fails for asknowledge that the only reason this
occurs is this new syntax being insufficiently thought through. That's because fundamentally the proposal owners
only care about their a(b(c(d()))) case, and try to paper over this with the pretense of covering other cases.
