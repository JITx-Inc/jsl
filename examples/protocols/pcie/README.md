# PCI-e Example Code

This example illustrates how to utilize the PCI-e helper functions available in JSL.

# Setup

1.  Clone this library (you likely did that to see this file).
2.  Open the root of the JSL directory in VSCode.
3.  Navigate to the `examples/protocols/pcie` directory.
4.  Open the `pcie-main.stanza` file in VSCode.


# Running the Example

To run this example, you need to run `pcie-main.stanza` by entering `<CTRL> Enter` while in that file.
Running the code will result in a layout which can be edited to position the two ICs as well as the 4 pairs of blocking capacitors.

# Adapting the Example

To adapt the example to personalize the code, you should do the following:
1. Start with adapting the `pcie-board.stanza` file to conform to your particular PCB stackup and available vias. Also for impedance-controlled traces, use the specific layers/constraints as agreed upon with your PCB fabricator. 
JITX references on stackup construction, vias, rules and routing structures include:
https://docs.jitx.com/reference/statements/stackupstmt/heading.html
https://docs.jitx.com/reference/statements/viastmt/heading.html
https://docs.jitx.com/reference/statements/rulestmt/heading.html
https://docs.jitx.com/reference/statements/routingstructstmt/heading.html

2. For the components in your system that have PCI-e connections like ICs, connectors, etc adapt the code from the `pcie-src.stanza` to model the nature of the PCI-e links available in your parts. You will find the PCI-e helper code in this directory:
jsl: `src/protocols/pcie.stanza`

3. For your design, at the level where you wish to connect the PCI-e components, adapt the code from `pcie-main.stanza` to fit your design architecture. 

