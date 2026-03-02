/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs - ui_in[3:0] is the 4-bit number (0-9)
    output wire [7:0] uo_out,   // Dedicated outputs - uo_out[6:0] drives segments a-g
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  reg [6:0] segments;

  // Segment encoding: segments = {g, f, e, d, c, b, a}
  // A 1 means the segment is ON
  always @(*) begin
    case (ui_in[3:0])
      4'd0: segments = 7'b0111111; // 0
      4'd1: segments = 7'b0000110; // 1
      4'd2: segments = 7'b1011011; // 2
      4'd3: segments = 7'b1001111; // 3
      4'd4: segments = 7'b1100110; // 4
      4'd5: segments = 7'b1101101; // 5
      4'd6: segments = 7'b1111101; // 6
      4'd7: segments = 7'b0000111; // 7
      4'd8: segments = 7'b1111111; // 8
      4'd9: segments = 7'b1101111; // 9
      default: segments = 7'b0000000; // off for anything > 9
    endcase
  end

  assign uo_out  = {1'b0, segments}; // top bit unused, set to 0
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in, ui_in[7:4], 1'b0};

endmodule