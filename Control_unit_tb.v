
`timescale 1ns / 1ps

module control_unit_tb;
    // Inputs
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;

    // Outputs
    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire MemtoReg;
    wire ALUSrc;
    wire Branch;
    wire Jal;
    wire Jalr;
    wire [3:0] ALUOp;

    // Instantiate the Control Unit module
    control_unit uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .ALUSrc(ALUSrc),
        .Branch(Branch),
        .Jal(Jal),
        .Jalr(Jalr),
        .ALUOp(ALUOp)
    );

    initial begin
        // Test 1: R-type instruction (ADD, SUB, etc.)
        opcode = 7'b0110011;
        #10;
        $display("R-type: RegWrite=%b, ALUSrc=%b, MemtoReg=%b, Branch=%b, ALUOp=%b",
                 RegWrite, ALUSrc, MemtoReg, Branch, ALUOp);

        // Test 2: I-type instruction (ADDI, ANDI, etc.)
        opcode = 7'b0010011;
        #10;
        $display("I-type: RegWrite=%b, ALUSrc=%b, MemtoReg=%b, Branch=%b, ALUOp=%b",
                 RegWrite, ALUSrc, MemtoReg, Branch, ALUOp);

        // Test 3: LUI
        opcode = 7'b0110111;
        #10;
        $display("LUI: RegWrite=%b, ALUSrc=%b, MemtoReg=%b, Branch=%b, ALUOp=%b",
                 RegWrite, ALUSrc, MemtoReg, Branch, ALUOp);

        // Test 4: AUIPC
        opcode = 7'b0010111;
        #10;
        $display("AUIPC: RegWrite=%b, ALUSrc=%b, MemtoReg=%b, Branch=%b, ALUOp=%b",
                 RegWrite, ALUSrc, MemtoReg, Branch, ALUOp);

        // Test 5: Store (SW)
        opcode = 7'b0100011;
        #10;
        $display("Store: MemWrite=%b, ALUSrc=%b", MemWrite, ALUSrc);

        // Test 6: Load (LW)
        opcode = 7'b0000011;
        #10;
        $display("Load: MemRead=%b, RegWrite=%b, MemtoReg=%b, ALUSrc=%b",
                 MemRead, RegWrite, MemtoReg, ALUSrc);

        // Test 7: Branch (BEQ, BNE, etc.)
        opcode = 7'b1100011;
        #10;
        $display("Branch: Branch=%b, ALUSrc=%b, ALUOp=%b", Branch, ALUSrc, ALUOp);

        // Test 8: JAL
        opcode = 7'b1101111;
        #10;
        $display("JAL: RegWrite=%b, Jal=%b", RegWrite, Jal);

        // Test 9: JALR
        opcode = 7'b1100111;
        #10;
        $display("JALR: RegWrite=%b, Jalr=%b, ALUSrc=%b", RegWrite, Jalr, ALUSrc);

        // Test 10: Invalid opcode (default case)
        opcode = 7'b0000000;
        #10;
        $display("Default case: All outputs should be 0");

        // End of simulation
        $finish;
    end
endmodule
