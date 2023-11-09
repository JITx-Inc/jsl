# TabGen - Tool for Creating Tabular data in Stanza

This tool will transform a CSV file into a stanza table.
This is useful for managing tabular data such as Two-Pin SMT chip
size parameters.

# Setup

Run:

```
$> make
```

# Use

Example CSV:

```csv
"Name", "Length", "Width", "Lead-Length", "Lead-Width", "Aliases"
"009005", 0.3 +/- 0.01, 0.15 +/- 0.01, 0.11 +/- 0.01, 0.15 +/- 0.01, "0301m"
"01005", 0.4 +/- 0.02, 0.2 +/- 0.02, 0.1 +/- 0.03, 0.2 +/- 0.02, "0402m"
"0201", 0.6 +/- 0.03, 0.3 +/- 0.03, 0.15 +/- 0.05, 0.3 +/- 0.03, "0603m"
"0202", 0.6 +/- 0.03, 0.6 +/- 0.03, 0.15 +/- 0.05, 0.6 +/- 0.03, "0606m"
...
```

Run:

```
$> tabgen generate src/landpatterns/two-pin.csv \
  -f src/landpattern/two-pin.stanza \
  -pkg-name "jsl/landpatterns/two-pin-table" \
  -force
Extraction Complete
File 'src/landpatterns/two-pin.stanza' Generated
```

Generates:

```
; Auto-Generated File created by 'tabgen'
; Do not manually edit this file.
defpackage jsl/landpatterns/two-pin-table:
  import core
  import jitx

val header:Tuple<String> = ["Name",  "Length",  "Width",  "Lead-Length",  "Lead-Width",  "Aliases"]
val rows:Tuple = [
  [  "009005",     0.3 +/- 0.01,    0.15 +/- 0.01,     0.11 +/- 0.01,    0.15 +/- 0.01,             "0301m"]
  [   "01005",     0.4 +/- 0.02,     0.2 +/- 0.02,      0.1 +/- 0.03,     0.2 +/- 0.02,             "0402m"]
  [    "0201",     0.6 +/- 0.03,     0.3 +/- 0.03,     0.15 +/- 0.05,     0.3 +/- 0.03,             "0603m"]
  [    "0202",     0.6 +/- 0.03,     0.6 +/- 0.03,     0.15 +/- 0.05,     0.6 +/- 0.03,             "0606m"]
  ...
]
```

# Notes

The columns of the CSV file should be strings that will correctly
parse as stanza types. These strings will not be modified when they
are extracted and placed in the resultant file.

Don't use `,` (comma) in the fields of the CSV strings or otherwise. Comma
escaping is currently not supported.