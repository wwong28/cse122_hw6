`timescale 1ns / 1ps

`include "../src/tt_um_project.v"

module tb;

  // Inputs
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  reg ena, clk, rst_n;

  // Outputs
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

  // Instantiate the design
  tt_um_project uut(
    .ui_in(ui_in),
    .uo_out(uo_out),
    .uio_in(uio_in),
    .uio_out(uio_out),
    .uio_oe(uio_oe),
    .ena(ena),
    .clk(clk),
    .rst_n(rst_n)
  );

  integer failed = 0;

  task check;
    input [3:0] digit;
    input [6:0] expected;
    begin
      ui_in = {4'b0000, digit};
      #10;
      if (uo_out[6:0] !== expected) begin
        $display("FAIL: input=%0d, expected=%07b, got=%07b", digit, expected, uo_out[6:0]);
        failed = failed + 1;
      end else begin
        $display("PASS: input=%0d, segments=%07b", digit, uo_out[6:0]);
      end
    end
  endtask

  initial begin
    // Initialize
    clk = 0;
    rst_n = 1;
    ena = 1;
    uio_in = 0;
    ui_in = 0;
    #10;

    // Test all digits 0-9
    check(4'd0, 7'b0111111);
    check(4'd1, 7'b0000110);
    check(4'd2, 7'b1011011);
    check(4'd3, 7'b1001111);
    check(4'd4, 7'b1100110);
    check(4'd5, 7'b1101101);
    check(4'd6, 7'b1111101);
    check(4'd7, 7'b0000111);
    check(4'd8, 7'b1111111);
    check(4'd9, 7'b1101111);

    // Test default case (input > 9 should output all zeros)
    check(4'd10, 7'b0000000);
    check(4'd15, 7'b0000000);

    // Final result
    if (failed == 0)
      $display("ALL TESTS PASSED");
    else
      $display("%0d TEST(S) FAILED", failed);

    $finish;
  end

endmodule
