
`timescale 1ns / 1ps

module alu_tb;
    // Inputs
    reg [31:0] operand_a;
    reg [31:0] operand_b;
    reg [3:0] alu_op;

    // Outputs
    wire [31:0] result;
    wire zero_flag;
    wire sign_flag;
    wire carry_flag;
    wire overflow_flag;

    // Instantiate the ALU module
    alu uut (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .alu_op(alu_op),
        .result(result),
        .zero_flag(zero_flag),
        .sign_flag(sign_flag),
        .carry_flag(carry_flag),
        .overflow_flag(overflow_flag)
    );

    initial begin
        // Test 1: ADD (No Overflow)
        operand_a = 32'h00000001;
        operand_b = 32'h00000001;
        alu_op = 4'b0000; // OP_ADD
        #10;
        $display("ADD: result=%h, carry_flag=%b, overflow_flag=%b", result, carry_flag, overflow_flag);

        // Test 2: ADD (Overflow)
        operand_a = 32'h7FFFFFFF;
        operand_b = 32'h00000001;
        alu_op = 4'b0000; // OP_ADD
        #10;
        $display("ADD Overflow: result=%h, carry_flag=%b, overflow_flag=%b", result, carry_flag, overflow_flag);

        // Test 3: SUB (No Overflow)
        operand_a = 32'h00000002;
        operand_b = 32'h00000001;
        alu_op = 4'b0001; // OP_SUB
        #10;
        $display("SUB: result=%h, carry_flag=%b, overflow_flag=%b", result, carry_flag, overflow_flag);

        // Test 4: SUB (Overflow)
        operand_a = 32'h80000000;
        operand_b = 32'h00000001;
        alu_op = 4'b0001; // OP_SUB
        #10;
        $display("SUB Overflow: result=%h, carry_flag=%b, overflow_flag=%b", result, carry_flag, overflow_flag);

        // Test 5: AND
        operand_a = 32'hF0F0F0F0;
        operand_b = 32'h0F0F0F0F;
        alu_op = 4'b0010; // OP_AND
        #10;
        $display("AND: result=%h", result);

        // Test 6: OR
        operand_a = 32'hF0F0F0F0;
        operand_b = 32'h0F0F0F0F;
        alu_op = 4'b0011; // OP_OR
        #10;
        $display("OR: result=%h", result);

        // Test 7: XOR
        operand_a = 32'hFFFFFFFF;
        operand_b = 32'h00000000;
        alu_op = 4'b0100; // OP_XOR
        #10;
        $display("XOR: result=%h", result);

        // End of simulation
        $finish;
    end
endmodule
