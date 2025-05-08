module riscv_single_cycle_processor (
    input clk,
    input rst
);

    wire        RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc, Branch, Jalr;
    wire [3:0]  ALUOp;

    wire [31:0] pc_current;
    wire [31:0] pc_next, pc_plus_4;
    wire [31:0] instruction;
    wire [31:0] imm_extended;
    wire [31:0] rs1_data, rs2_data;
    wire [31:0] alu_operand_b;
    wire [31:0] alu_result;
    wire        alu_zero_flag;
    wire        alu_sign_flag;
    wire        alu_carry_flag;
    wire        alu_overflow_flag;
    wire [31:0] mem_read_data;
    wire [31:0] write_back_data;
    wire [31:0] branch_target_addr;
    wire [31:0] jalr_target_addr;
    wire [1:0]  pc_sel;

    wire [4:0] rs1, rs2, rd;
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd  = instruction[11:7];

    assign jalr_target_addr = (rs1_data + imm_extended) & ~32'b1;
    assign pc_sel = Jalr ? 2'b10 : (Branch & alu_zero_flag ? 2'b01 : 2'b00);

    // Program Counter Register
    pc_reg PC_REG (
        .clk(clk), 
        .rst(rst), 
        .pc_in(pc_next), 
        .pc_out(pc_current)
    );

    adder PC_ADDER (
        .operand_a(pc_current), 
        .operand_b(32'd4), 
        .result(pc_plus_4)
    );

    instruction_memory #( .MEM_DEPTH(256) ) IMEM (
        .address(pc_current), 
        .instruction(instruction)
    );

    control_unit CONTROL (
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]), 
        .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite),
        .MemtoReg(MemtoReg), .ALUSrc(ALUSrc), .ALUOp(ALUOp),
        .Branch(Branch), .Jalr(Jalr)
    );

    register_file REGFILE (
        .clk(clk), .rst(rst),
        .reg_write_en(RegWrite),
        .read_addr1(rs1),
        .read_addr2(rs2), 
        .write_addr(rd),  
        .write_data(write_back_data),
        .read_data1(rs1_data),
        .read_data2(rs2_data)
    );

    immediate_generator IMM_GEN (
        .instruction(instruction),
        .imm_extended(imm_extended)
    );

    mux2to1 #(32) ALU_SRC_MUX (
        .select(ALUSrc),
        .in0(rs2_data),
        .in1(imm_extended),
        .out(alu_operand_b)
    );

    alu ALU_UNIT (
        .operand_a(rs1_data),
        .operand_b(alu_operand_b),
        .alu_op(ALUOp),
        .result(alu_result),
        .zero_flag(alu_zero_flag),
        .sign_flag(alu_sign_flag),
        .carry_flag(alu_carry_flag),
        .overflow_flag(alu_overflow_flag)
    );

    data_memory #( .DATA_MEM_DEPTH(256) ) DMEM (
        .clk(clk),
        .mem_read_en(MemRead),
        .mem_write_en(MemWrite),
        .address(alu_result), 
        .write_data(rs2_data), 
        .read_data(mem_read_data)
    );

    mux2to1 #(32) WB_MUX (
        .select(MemtoReg),
        .in0(alu_result),
        .in1(mem_read_data),
        .out(write_back_data)
    );

    adder BRANCH_ADDER (
        .operand_a(pc_current),
        .operand_b(imm_extended), 
        .result(branch_target_addr)
    );

    mux3to1 #(32) PC_FINAL_MUX (
        .sel(pc_sel),
        .in0(pc_plus_4),
        .in1(branch_target_addr),
        .in2(jalr_target_addr),
        .out(pc_next)
    );

endmodule

