# fforth

A small, portable Forth written in Posix C.


## What?

fforth is a small, reasonably fast indirect-threaded Forth written in portable
C. It should Just Compile on most Unixy platforms. It's intended as a scripting
language for the Fuzix operating system but should work fine on any small
system. It's got reasonably complete basic bindings to most Unix ssystem calls
--- expect the functions to be there, although any constants probably aren't.

It supports most of the core ANS Forth words, and passes (most of) John 
Hayes' ANS conformance test. Or at least that of the version I found.

For reference, the version of the standard I've been referring to is:
http://lars.nocrew.org/dpans/dpans6.htm

All standard words USE THE ALL CAPITAL LETTERS version of the spelling (so you
need to type `BYE` to quit).

Peculiarities include:

  - `DOES>`

    ANS Forth decrees that you can call DOES> multiple times on a word, where
    each time it changes the code part of the word. fforth doesn't support
    that --- you can only call DOES> once. (Because I haven't figured out how
    to make this work with fforth's non-traditional word architecture.)

  - `READ-FILE` filename

     Opens and then executes Forth code supplied in the named file.

There are also a few useful features for debugging, such as slightly useful
stack traces when errors occur and optional (at compile time) stack bounds
checking. There are probably also lots of exciting bugs.


## How?

If you want to use it:

    cc -o fforth fforth.c

If you want to change it:

	sh fforth.c
	cc -o fforth fforth.c

Yes! The source file is both a C program _and_ a shell script (and an awk
script, and Forth source). When run as a shell script it byte-compiles the
Forth definitions in the C program and regenerates the Forth dictionary ---
this is too fragile to do by hand. The comments in the source should explain
what does what, but to summarise:

  - `//@W`: marks a dictionary entry. This will get updated in place to form a
	linked list.

  - `//@C`: cheesy™ precompiled Forth. Put semi-Forth code on the following
	comment lines; the line immediately afterwards will be updated to contain
	the byte- compiled version. Don't put a trailing semicolon. Only a limited
	subset of the language is supported (no strings, no immediate word
	execution).

  - `//@E`: patches up the attached statement to refer to the last word defined.

In addition, there are some C compilation options:

  - `-DFAST`: don't bounds check the stack (smaller, faster code).

  - `-DMEMORY=xxx`: allocate xxx bytes for the memory pool. This is a fixed
	size and won't be extended if it fills up.

  - `-DSBRK`: allocate memory with sbrk() rather than a fixed pool. This will
	be extended if it fills up. If it cannot be extended due to non-contiguous
	sbrk() memory, the interpeter will panic.

No evil was harmed in the making of this file. Probably.


## Who?

The FluxEngine was designed, built and written by me, David Given. You may
contact me at dg@cowlark.com, or visit my website at http://www.cowlark.com.
There may or may not be anything interesting there.


## License?

fforth is (C) 2015 David Given. It's licensed under the terms of the 2-clause
BSD license (tl;dr: do what you like but don't claim you own it). See the
LICENSE file in the source distribution for details.

As an exception, the `fforth_tests.fth` file was written by John Hayes and is
(C) 1995 Johns Hopkins University / Applied Physics Laboratory. It's freely
distributable --- see the comment at the top of the file for information.

