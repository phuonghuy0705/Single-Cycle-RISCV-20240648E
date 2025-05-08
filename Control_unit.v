module control_unit (
    input  wire [6:0] opcode,        
    input  wire [2:0] funct3,       
    input  wire [6:0] funct7,       
    output reg  RegWrite,         
    output reg  MemRead,          
    output reg  MemWrite,          
    output reg  MemtoReg,           
    output reg  ALUSrc,          
    output reg  Branch,         
    output reg  Jal,             
    output reg  Jalr,            
    output reg [3:0] ALUOp         
);

    localparam OPCODE_RTYPE   = 7'b0110011; // R-type instructions (ADD, SUB, etc.)
    localparam OPCODE_ITYPE   = 7'b0010011; // I-type instructions (ADDI, ANDI, etc.)
    localparam OPCODE_LUI     = 7'b0110111; // LUI
    localparam OPCODE_AUIPC   = 7'b0010111; // AUIPC
    localparam OPCODE_STORE   = 7'b0100011; // S-type instructions (SW, etc.)
    localparam OPCODE_LOAD    = 7'b0000011; // I-type instructions (LW, etc.)
    localparam OPCODE_BRANCH  = 7'b1100011; // B-type instructions (BEQ, BNE, etc.)
    localparam OPCODE_JAL     = 7'b1101111; // JAL
    localparam OPCODE_JALR    = 7'b1100111; // JALR

    always @(*) begin
        RegWrite   = 0;
        MemRead    = 0;
        MemWrite   = 0;
        MemtoReg   = 0;
        ALUSrc     = 0;
        Branch     = 0;
        Jal        = 0;
        Jalr       = 0;
        ALUOp      = 4'b0000;

        case (opcode)
            // R-type
            OPCODE_RTYPE: begin
                RegWrite = 1;
                ALUSrc = 0;
                MemtoReg = 0;
                Branch = 0;
                ALUOp = 4'b0100; 
            end
            
            // I-type (ADDI, ANDI, etc.)
            OPCODE_ITYPE: begin
                RegWrite = 1;
                ALUSrc = 1;
                MemtoReg = 0;
                Branch = 0;
                ALUOp = 4'b0000; 
            end
            
            // LUI
            OPCODE_LUI: begin
                RegWrite = 1;
                ALUSrc = 1;
                MemtoReg = 0;
                Branch = 0;
                ALUOp = 4'b0000; 
            end
            
            // AUIPC
            OPCODE_AUIPC: begin
                RegWrite = 1;
                ALUSrc = 1;
                MemtoReg = 0;
                Branch = 0;
                ALUOp = 4'b0000; 
            end

            // Store (SW, etc.)
            OPCODE_STORE: begin
                MemWrite = 1;
                ALUSrc = 1;
                MemtoReg = 0;
                Branch = 0;
                ALUOp = 4'b0000; 
            end

            // Load (LW, etc.)
            OPCODE_LOAD: begin
                MemRead = 1;
                RegWrite = 1;
                MemtoReg = 1;
                ALUSrc = 1;
                Branch = 0;
                ALUOp = 4'b0000; 
            end

            // Branch (BEQ, BNE, etc.)
            OPCODE_BRANCH: begin
                Branch = 1;
                ALUSrc = 0;
                MemtoReg = 0;
                ALUOp = 4'b0110; 
            end

            // JAL
            OPCODE_JAL: begin
                RegWrite = 1;
                Jal = 1;
                ALUSrc = 0;
                MemtoReg = 0;
                Branch = 0;
                ALUOp = 4'b0000; 
            end

            // JALR
            OPCODE_JALR: begin
                RegWrite = 1;
                Jalr = 1;
                ALUSrc = 1;
                MemtoReg = 0;
                Branch = 0;
                ALUOp = 4'b0000; 
            end

            default: begin
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                MemtoReg = 0;
                ALUSrc = 0;
                Branch = 0;
                Jal = 0;
                Jalr = 0;
                ALUOp = 4'b0000;
            end
        endcase
    end
endmodule

