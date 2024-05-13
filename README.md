# JSL - JITX Standard Library

This library is intended to be a companion library to the
JITX environment. The goals for this project are:

1.  Provide a focused API that supports PCB development.
2.  Expressive, consistent interface that makes defining components and circuits easy.
3.  Maintainable and distributable library with the help of [SLM](https://github.com/StanzaOrg/slm).
4.  Well-documented and thoughtful explanations.

** This is currently in ALPHA release. **

# Setup

1.  Check that `jstanza` is on your path
    1.  In Linux/Mac: `whereis jstanza`
    2.  In Windows: `get-command jstanza`
    3.  `jstanza version` should report the current version.
    4.  If there is no `jstanza` on your path - then you will need to add it to your `$PATH` (or in Windows `$env:PATH`).


# Running the Tests

To run the unit tests there are two make targets:

1.  `make tests` - this will run all of the unit tests.
2.  `make test-<TAG>` - this will run only the unit tests associated with the tag `<TAG>`

Example:

```
$> make test-SOIC
jstanza build tests
Build target tests is already up-to-date.
./jsl-tests -tagged SOIC | grep -v "SKIP" | awk NF
[Test 10] test-lead
[PASS]
[Test 11] test-body
[PASS]
[Test 12] test-SOIC-N
[PASS]
[Test 13] test-SOIC-W
[PASS]
[Test 14] test-fine-pitch
[PASS]
[Test 15] test-thermal-lead
[PASS]
[Test 16] test-pad-numbering
[PASS]
[Test 17] test-error-handling
[PASS]
Tests Finished: 8/18 tests passed. 10 tests skipped. 0 tests failed.
Longest Running Tests:
[PASS] test-SOIC-N (13 ms)
[PASS] test-SOIC-W (4935 us)
[PASS] test-fine-pitch (3417 us)
[PASS] test-thermal-lead (2478 us)
[PASS] test-pad-numbering (1439 us)
[PASS] test-error-handling (552 us)
[PASS] test-lead (492 us)
[PASS] test-body (10 us)
```