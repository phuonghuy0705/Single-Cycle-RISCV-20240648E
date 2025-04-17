`timescale 1ns / 1ps

module ALU_tb;

    // Inputs
    reg [31:0] A, B;
    reg [2:0] ALUControl;

    // Outputs
    wire [31:0] Result;
    wire Carry, OverFlow, Zero, Negative;

    // Instantiate ALU
    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .Carry(Carry),
        .OverFlow(OverFlow),
        .Zero(Zero),
        .Negative(Negative)
    );

    initial begin
        // Test case 1: ADD (A + B)
        A = 32'd15; B = 32'd10; ALUControl = 3'b000;
        #10;
        $display("ADD: A=%d, B=%d, Result=%d, Carry=%b, Overflow=%b, Zero=%b, Negative=%b",
                 A, B, Result, Carry, OverFlow, Zero, Negative);

        // Test case 2: SUB (A - B)
        A = 32'd15; B = 32'd10; ALUControl = 3'b001;
        #10;
        $display("SUB: A=%d, B=%d, Result=%d, Carry=%b, Overflow=%b, Zero=%b, Negative=%b",
                 A, B, Result, Carry, OverFlow, Zero, Negative);

        // Test case 3: AND
        A = 32'hFF00FF00; B = 32'h0F0F0F0F; ALUControl = 3'b010;
        #10;
        $display("AND: A=0x%h, B=0x%h, Result=0x%h", A, B, Result);

        // Test case 4: OR
        A = 32'h0000F0F0; B = 32'hF0F00000; ALUControl = 3'b011;
        #10;
        $display("OR: A=0x%h, B=0x%h, Result=0x%h", A, B, Result);

        // Test case 5: SLT (A < B ? 1 : 0), A < B
        A = 32'd5; B = 32'd10; ALUControl = 3'b101;
        #10;
        $display("SLT: A=%d, B=%d, Result=%d", A, B, Result);

        // Test case 6: XOR
        A = 32'hAAAA5555; B = 32'hFFFF0000; ALUControl = 3'b111;
        #10;
        $display("XOR: A=0x%h, B=0x%h, Result=0x%h", A, B, Result);

        // Test case 7: SUB, Result = 0
        A = 32'd50; B = 32'd50; ALUControl = 3'b001;
        #10;
        $display("SUB-ZERO: Result=%d, Zero=%b", Result, Zero);

        // Test case 8: SUB, Result negative
        A = 32'd10; B = 32'd50; ALUControl = 3'b001;
        #10;
        $display("SUB-NEG: A=%d, B=%d, Result=%d, Negative=%b", A, B, Result, Negative);

        // Test case 9: ADD overflow
        A = 32'h7FFFFFFF; B = 32'd1; ALUControl = 3'b000;
        #10;
        $display("ADD Overflow: A=0x%h, B=0x%h, Result=0x%h, OverFlow=%b", A, B, Result, OverFlow);

        // Test case 10: ADD carry
        A = 32'hFFFFFFFF; B = 32'd1; ALUControl = 3'b000;
        #10;
        $display("ADD Carry: A=0x%h, B=0x%h, Result=0x%h, Carry=%b", A, B, Result, Carry);

        $finish;
    end

endmodule

