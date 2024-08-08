# JSL - JITX Standard Library

This library is intended to be a companion library to the
JITX environment. The goals for this project are:

1.  Provide a focused API that supports PCB development.
2.  Expressive, consistent interface that makes defining components and circuits easy.
3.  Maintainable and distributable library with the help of [SLM](https://github.com/StanzaOrg/slm).
4.  Well-documented and thoughtful explanations.

** This is currently in ALPHA release. **

# Setup

1.  If you are in the JITX VSCode environment:
    1.  In Linux/Mac:
        1.  `which $SLM_STANZA`
        2.  `$SLM_STANZA version`
    2.  In Windows Powershell:
        1.  `get-command $env:SLM_STANZA`
        2.  `&$env:SLM_STANZA version`
2.  Outside the VSCode
    1.  You need to have `jstanza` on the `PATH`.
    2.  In Linux/Mac: `which jstanza`
    3.  In Windows: `get-command jstanza`
    4.  `jstanza version` should report the current version.
    5.  If there is no `jstanza` on your path - then you will need to add it to your `$PATH` (or in Windows `$env:PATH`).


# Running the Tests

To run the unit tests there are two make targets:

1.  `make tests` - this will run all of the unit tests.
2.  `make test-<TAG>` - this will run only the unit tests associated with the tag `<TAG>`

Example:

```
$> make test-SOIC
/Users/callendorph/.jitx/current/jstanza run-test jsl/tests/landpatterns/numbering ...  -tagged SOIC | grep -v "SKIP" | awk NF
[Test 21] test-lead
[PASS]
[Test 22] test-body
[PASS]
[Test 23] test-SOIC-N
[PASS]
[Test 24] test-SOIC-W
[PASS]
[Test 25] test-fine-pitch
[PASS]
[Test 26] test-thermal-lead
[PASS]
[Test 27] test-pad-numbering
[PASS]
[Test 28] test-error-handling
[PASS]
[Test 29] test-SOIC-with-pose
[PASS]
[Test 30] test-SOIC-with-rotation
[PASS]
[Test 31] test-thermal-lead-with-pose
[PASS]
Tests Finished: 11/111 tests passed. 100 tests skipped. 0 tests failed.
Longest Running Tests:
[PASS] test-SOIC-N (36 ms)
[PASS] test-fine-pitch (26 ms)
[PASS] test-SOIC-W (10 ms)
[PASS] test-thermal-lead (6181 us)
[PASS] test-thermal-lead-with-pose (5226 us)
[PASS] test-SOIC-with-pose (4847 us)
[PASS] test-pad-numbering (4547 us)
[PASS] test-error-handling (3561 us)
[PASS] test-SOIC-with-rotation (3531 us)
[PASS] test-lead (3124 us)
[PASS] test-body (561 us)

```