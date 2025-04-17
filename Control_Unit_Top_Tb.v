`timescale 1ns / 1ps

module Control_Unit_Top_tb;

    // Inputs
    reg [6:0] Op, funct7;
    reg [2:0] funct3;

    // Outputs
    wire RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
    wire [1:0] ImmSrc;
    wire [2:0] ALUControl;

    Control_Unit_Top uut (
        .Op(Op),
        .funct7(funct7),
        .funct3(funct3),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUControl(ALUControl)
    );

    initial begin
        // R-type (ADD)
        Op = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0000000;
        #10;
        $display("R-type ADD: RegWrite=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, Branch=%b, ALUControl=%b",
                  RegWrite, ALUSrc, MemWrite, ResultSrc, Branch, ALUControl);

        // R-type (SUB)
        Op = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0100000;
        #10;
        $display("R-type SUB: RegWrite=%b, ALUControl=%b", RegWrite, ALUControl);

        // I-type (ADDI)
        Op = 7'b0010011; funct3 = 3'b000; funct7 = 7'b0000000;
        #10;
        $display("I-type ADDI: RegWrite=%b, ALUSrc=%b, ALUControl=%b", RegWrite, ALUSrc, ALUControl);

        // S-type (SW)
        Op = 7'b0100011; funct3 = 3'b010;
        #10;
        $display("S-type SW: MemWrite=%b, ALUSrc=%b, RegWrite=%b", MemWrite, ALUSrc, RegWrite);

        // B-type (BEQ)
        Op = 7'b1100011; funct3 = 3'b000;
        #10;
        $display("B-type BEQ: Branch=%b, ALUControl=%b", Branch, ALUControl);

        // L-type (LW)
        Op = 7'b0000011; funct3 = 3'b010;
        #10;
        $display("L-type LW: MemWrite=%b, ResultSrc=%b, RegWrite=%b", MemWrite, ResultSrc, RegWrite);

        $finish;
    end

endmodule

