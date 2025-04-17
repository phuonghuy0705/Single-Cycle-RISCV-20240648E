`timescale 1ns/1ps

module Instruction_Memory_tb;

  // Inputs
  reg rst;
  reg [31:0] A;

  // Outputs
  wire [31:0] RD;

  Instruction_Memory uut (
    .rst(rst),
    .A(A),
    .RD(RD)
  );

  initial begin
    rst = 0;
    A = 0;

    #10;
    $display("RD at reset = %h", RD); // expect 0
    
    rst = 1;
    #10 A = 32'h00000000; // Read memory[0]
    #10 $display("RD = %h", RD); // expect 0x0062E233

    #10 A = 32'h00000004; // Read memory[1]
    #10 $display("RD = %h", RD); // expect 0x00B67433

    #10 A = 32'h00000008; // Read memory[2]
    #10 $display("RD = %h", RD); // expect 0x00B60433

    $stop;
  end

endmodule

