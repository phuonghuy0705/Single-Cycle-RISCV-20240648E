`timescale 1ns / 1ps

module Data_Memory_tb;

    // Inputs
    reg clk, rst, WE;
    reg [31:0] A, WD;

    // Output
    wire [31:0] RD;

    Data_Memory uut (
        .clk(clk),
        .rst(rst),
        .WE(WE),
        .WD(WD),
        .A(A),
        .RD(RD)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 0; WE = 0; A = 0; WD = 0;

        // Reset active -> RD = 0
        #10;
        A = 32'd28;
        #10;
        $display("Reset = 0, Reading mem[28] => RD = %h (Expected: 0)", RD);

        // Release reset -> should read value at mem[28] = 0x20
        rst = 1;
        #10;
        $display("Reset = 1, Reading mem[28] => RD = %h (Expected: 00000020)", RD);

        // Write to mem[100]
        A = 32'd100;
        WD = 32'h12345678;
        WE = 1;
        #10;

        // Stop writing
        WE = 0;
        #10;

        // Read from mem[100]
        A = 32'd100;
        #10;
        $display("Reading mem[100] => RD = %h (Expected: 12345678)", RD);

        // Try reading invalid address when reset = 0 again
        rst = 0;
        A = 32'd100;
        #10;
        $display("Reset = 0 again, RD = %h (Expected: 00000000)", RD);

        $finish;
    end

endmodule

