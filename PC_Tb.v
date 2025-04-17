`timescale 1ns / 1ps

module PC_Module_tb;

    reg clk;
    reg rst;
    reg [31:0] PC_Next;
    wire [31:0] PC;

    PC_Module uut (
        .clk(clk),
        .rst(rst),
        .PC(PC),
        .PC_Next(PC_Next)
    );

  
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 0;
        PC_Next = 32'hAABBCCDD;

        #10;
        rst = 1; // Thoát reset

        #10;
        PC_Next = 32'h11223344;

        #10;
        PC_Next = 32'hDEADBEEF;

        #10;
        rst = 0;
        #10;

        $finish;
    end

endmodule

