<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

 <!-- trigger -->
## How it works

This project implements a 7-segment display decoder. It takes a 4-bit binary input (representing digits 0–9) via `ui_in[3:0]` and outputs a 7-bit signal on `uo_out[6:0]` that controls which segments (a–g) of a 7-segment display are turned on. Each bit in the output corresponds to one segment of the display. For inputs greater than 9, all segments are turned off.

## How to test

The testbench (`test/tb.v`) is a self-checking Verilog testbench that tests all valid digit inputs (0–9) as well as two invalid inputs (10 and 15) to verify the default case. For each input, it compares the actual output against the expected segment encoding and prints PASS or FAIL. All 12 test cases must pass for the design to be considered correct.

## External hardware

No external hardware is required. To visualize the output, a 7-segment display can be connected to `uo_out[6:0]`.

## GenAI Use
Claude (Anthropic) was used to assist in developing the project idea, outlining the instructions, and suggesting the ideal structure for writing the Verilog design and testbench code. The AI helped generate the segment encodings for each digit and provided guidance on organizing the self-checking testbench. All code was reviewed and verified for correctness through local simulation.
