# LPDDR5/LPDDR5X Memory Protocol Example

This example demonstrates the use of the LPDDR5/LPDDR5X memory protocol implementation in JITX.

## Overview

LPDDR5 (Low Power Double Data Rate 5) is a high-speed memory protocol designed for mobile and low-power applications. It offers significant improvements over previous LPDDR generations in terms of bandwidth, power efficiency, and features.

This implementation supports:
- Single, dual, and quad channel configurations
- Single and dual rank configurations
- Differential command clock (CK_t/CK_c)
- Differential data clocks (WCK_t/WCK_c)
- Optional differential read strobe (RDQS_t/RDQS_c)
- Command/Address bus with 7 bits
- Data lanes with 8 bits per lane

## Features

The LPDDR5 implementation includes:
- Bundle definitions for LPDDR5 interfaces
- Signal integrity constraints for proper routing
- Helper functions for connecting and constraining LPDDR5 links

## Example Usage

The example in `lpddr5-example.stanza` shows how to:
1. Define LPDDR5 controller and memory ports
2. Create routing structures with appropriate impedance values
3. Connect and constrain the LPDDR5 interface

## Datasheet Reference

The implementation is based on the Micron LPDDR5/LPDDR5X datasheet (MT62F1536M32D4, MT62F3G32D8, MT62F768M32D2, MT62F768M64D4, MT62F1536M64D8).

## Signal Integrity Constraints

The implementation includes the following signal integrity constraints:
- CK Intra-pair Skew: 0.0 ± 1.0 ps
- CK to CKE Skew: 0.0 ± 8.0 ps
- CK to CS Skew: 0.0 ± 8.0 ps
- CK to CA Skew: 0.0 ± 8.0 ps
- CK to DQS Skew: -500.0 ps to 2500.0 ps
- DQS Intra-pair Skew: 0.0 ± 2.0 ps
- RDQS Intra-pair Skew: 0.0 ± 2.0 ps
- DQS to DQ/DMI Skew: 0.0 ± 5.0 ps
- DQ/DMI to DQ/DMI Skew: 0.0 ± 5.0 ps
- Maximum Signal Loss: 5.0 dB 