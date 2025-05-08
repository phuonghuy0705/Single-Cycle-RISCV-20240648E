module alu (
    input  wire [31:0] operand_a,
    input  wire [31:0] operand_b,
    input  wire [3:0]  alu_op, 
    output reg  [31:0] result,
    output reg         zero_flag,
    output reg         sign_flag,
    output reg         carry_flag,
    output reg         overflow_flag
);

    localparam OP_ADD  = 4'b0000;
    localparam OP_SUB  = 4'b0001;
    localparam OP_AND  = 4'b0010;
    localparam OP_OR   = 4'b0011;
    localparam OP_XOR  = 4'b0100;
    localparam OP_SLL  = 4'b0101;
    localparam OP_SRL  = 4'b0110;
    localparam OP_SRA  = 4'b0111;
    localparam OP_SLT  = 4'b1000;
    localparam OP_SLTU = 4'b1001;

    reg [32:0] temp_result;

    always @(*) begin
        carry_flag     = 1'b0;
        overflow_flag  = 1'b0;
        sign_flag      = 1'b0;
        result         = 32'b0;

        case (alu_op)
            OP_ADD: begin
                temp_result = {1'b0, operand_a} + {1'b0, operand_b};
                result = temp_result[31:0];
                carry_flag = temp_result[32]; 
                overflow_flag = (~operand_a[31] & ~operand_b[31] & result[31]) | 
                                ( operand_a[31] &  operand_b[31] & ~result[31]);
            end

            OP_SUB: begin
                temp_result = {1'b0, operand_a} - {1'b0, operand_b};
                result = temp_result[31:0];
                carry_flag = temp_result[32]; 
                overflow_flag = ( operand_a[31] & ~operand_b[31] & ~result[31]) | 
                                (~operand_a[31] &  operand_b[31] &  result[31]);
            end

            OP_AND:  result = operand_a & operand_b;
            OP_OR:   result = operand_a | operand_b;
            OP_XOR:  result = operand_a ^ operand_b;
            OP_SLL:  result = operand_a << operand_b[4:0];
            OP_SRL:  result = operand_a >> operand_b[4:0];
            OP_SRA:  result = $signed(operand_a) >>> operand_b[4:0];
            OP_SLT:  result = ($signed(operand_a) < $signed(operand_b)) ? 32'b1 : 32'b0;
            OP_SLTU: result = (operand_a < operand_b) ? 32'b1 : 32'b0;

            default: result = 32'b0;
        endcase

        zero_flag = (result == 32'b0);
        sign_flag = result[31]; 
    end
endmodule

