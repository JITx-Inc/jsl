# USB Example Code

This example illustrates how to utilize the USB protocol helper functions available in JSL.

# Setup

1.  Clone this library (you likely did that to see this file).
2.  Open the root of the JSL directory in VSCode.
3.  Navigate to the `examples/protocols/usb` directory.
4.  Open the `usb-main.stanza` file in VSCode.


# Running the Example

To run this example, you need to run `usb-main.stanza` by entering `<CTRL> Enter` while in that file.
Running the code will result in a layout which can be edited to position the two ICs as well as the 2 pairs of blocking capacitors.

# Adapting the Example

To adapt the example to personalize the code, you should do the following:
1. Start with adapting the `examples/protocols/common/example-board.stanza` file to conform to your particular PCB stackup and available vias. Also for impedance-controlled traces, use the specific layers/constraints as agreed upon with your PCB fabricator.
JITX references on stackup construction, vias, rules and routing structures include:
https://docs.jitx.com/reference/statements/stackupstmt/heading.html
https://docs.jitx.com/reference/statements/viastmt/heading.html
https://docs.jitx.com/reference/statements/rulestmt/heading.html
https://docs.jitx.com/reference/statements/routingstructstmt/heading.html

1. For the components in your system that have USB connections like ICs, connectors, etc adapt the code from the `usb-src` component to model the nature of the USB links available in your parts. For passive components like blocking capacitors and pull-up/down resistors, you can model the code using the code in `examples/protocols/common/example-components.stanza`. Note that those components are dummy ones and will need to be updated to be usable. You will find the USB helper code in this directory:
jsl: `src/protocols/usb.stanza`
1. For your design, at the level where you wish to connect the USB components, adapt the code from `usb-main.stanza` to fit your design architecture.
   1. Use `constrain-topology` to allow for constructing the topology and then applying the USB specific constraints
   2. For Active Component (MCU) to Passive Component (connector):
      1. Use `topo-pair` to add `dp-coupler` blocking capacitors in the topology
   3. For Active Component (MCU) to Active Component (MCU):
      1. Use `reverse-lane` to implement a Null Modem style connection.

