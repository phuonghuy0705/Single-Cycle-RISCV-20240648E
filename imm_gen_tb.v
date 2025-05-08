
`timescale 1ns / 1ps

module imm_gen_tb;

    // ??nh ngh?a tín hi?u
    reg [31:0] instruction; // ??u vào instruction
    wire [31:0] imm_extended; // ??u ra imm_extended

    // T?o instance c?a immediate_generator
    immediate_generator uut (
        .instruction(instruction),
        .imm_extended(imm_extended)
    );

    // Test case
    initial begin
        // Test case 1: Ki?m tra l?nh ADDI (Immediate type, 12-bit immediate)
        instruction = 32'b00000000000100000000000010010011; // ADDI x1, x0, 1
        #10;
        $display("ADDI: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 00000001

        // Test case 2: Ki?m tra l?nh LUI (U-type, 20-bit immediate)
        instruction = 32'b0000000000010000000000000000110111; // LUI x1, 0x100000
        #10;
        $display("LUI: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 10000000000000000000

        // Test case 3: Ki?m tra l?nh BEQ (Branch type, 13-bit immediate)
        instruction = 32'b00000000000000000000000011100011; // BEQ x0, x1, offset
        #10;
        $display("BEQ: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 00000000000000000000

        // Test case 4: Ki?m tra l?nh JAL (J-type, 20-bit immediate)
        instruction = 32'b000000000000000000010000001010111111; // JAL x1, offset
        #10;
        $display("JAL: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 0000000000010000101011

        // Test case 5: Ki?m tra l?nh STORE (S-type, 12-bit immediate)
        instruction = 32'b00000000000100000000000010100011; // SW x1, offset(x0)
        #10;
        $display("STORE: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 00000000000000000101

        // Test case 6: Ki?m tra l?nh JALR (I-type)
        instruction = 32'b00000000000100000000000011100111; // JALR x1, x0, offset
        #10;
        $display("JALR: instruction = %b, imm_extended = %b", instruction, imm_extended); // Expected: imm_extended = 00000001
       
        $finish; // K?t thúc mô ph?ng
    end
endmodule
