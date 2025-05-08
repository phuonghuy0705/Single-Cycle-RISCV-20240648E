module immediate_generator (
    input wire [31:0] instruction,
    output reg [31:0] imm_extended
);
    wire [6:0] opcode = instruction[6:0];

    localparam OPCODE_ADDI   = 7'b0010011; // addi
    localparam OPCODE_LOAD   = 7'b0000011; // lw
    localparam OPCODE_STORE  = 7'b0100011; // sw
    localparam OPCODE_BRANCH = 7'b1100011; // beq
    localparam OPCODE_LUI   = 7'b0110111; // lui 
    localparam OPCODE_JAL   = 7'b1101111;  // jal 
    localparam OPCODE_JALR   = 7'b1100111; //jalr


    always @(*) begin
        case (opcode)
            OPCODE_ADDI, OPCODE_LOAD, OPCODE_JALR: begin // I-type 
                imm_extended = {{20{instruction[31]}}, instruction[31:20]}; 
            end
            OPCODE_STORE: begin // S-type 
                imm_extended = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; 
            end
            OPCODE_BRANCH: begin // B-type 
                imm_extended = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; 
            end
	    OPCODE_LUI: begin // U-type
                imm_extended = {instruction[31:12], 12'b0}; 
            end
            OPCODE_JAL: begin // J-type
                imm_extended = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            end
            default: imm_extended = 32'b0; 
        endcase
    end
endmodule