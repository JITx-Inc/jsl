# DisplayPort Example Code

This example illustrates how to utilize the DisplayPort helper functions available in JSL.

# Setup

1.  Clone this library (you likely did that to see this file).
2.  Open the root of the JSL directory in VSCode.
3.  Navigate to the `examples/protocols/displayport` directory.
4.  Open the `displayport-main.stanza` file in VSCode.


# Running the Example

To run this example, you need to run `displayport-main.stanza` by entering `<CTRL> Enter` while in that file.
Running the code will result in a layout which can be edited to position the two ICs as well as the 4 pairs of 
blocking capacitors and one pair of pull-up resistors.

# Adapting the Example

To adapt the example to personalize the code, you should do the following:
1. Start with adapting the `examples/protocols/common/example-board.stanza` file to conform to your particular PCB stackup and available vias. Also for impedance-controlled traces, use the specific layers/constraints as agreed upon with your PCB fabricator. 
JITX references on stackup construction, vias, rules and routing structures include:
https://docs.jitx.com/reference/statements/stackupstmt/heading.html
https://docs.jitx.com/reference/statements/viastmt/heading.html
https://docs.jitx.com/reference/statements/rulestmt/heading.html
https://docs.jitx.com/reference/statements/routingstructstmt/heading.html

2. For the components in your system that have DisplayPort connections like ICs, connectors, etc adapt the code from the `displayport-src.stanza` to model the nature of the DisplayPort links available in your parts. For passive components like blocking capacitors and pull-up/down resistors, you can model the code using the code in `examples/protocols/common/example-components.staza`. Note that those components are dummy ones and will need to be updated to be usable. You will find the DisplayPort helper code in this directory:
jsl: `src/protocols/displayport.stanza`

3. For your design, at the level where you wish to connect the DisplayPort components, adapt the code from `displayport-main.stanza` to fit your design architecture. 
