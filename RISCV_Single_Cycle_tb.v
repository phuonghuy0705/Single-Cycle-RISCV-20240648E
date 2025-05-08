`timescale 1ns / 1ps
module tb_riscv_processor;

    reg clk;
    reg rst;

    riscv_single_cycle_processor uut (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        rst = 1; 
        #7;    
        rst = 0; 

        #100; 

        $finish;
    end


    initial begin
        $readmemh("program.hex", uut.IMEM.mem);
    end

     initial begin
         #1; 
         $monitor("Time=%0t PC=%h Inst=%h | RegWr=%b ALUSrc=%b MemRd=%b MemWr=%b Mem2Reg=%b Branch=%b | ALURes=%h WBData=%h",
                  $time, uut.pc_current, uut.instruction,
                  uut.RegWrite, uut.ALUSrc, uut.MemRead, uut.MemWrite, uut.MemtoReg, uut.Branch,
                  uut.alu_result, uut.write_back_data);
     end

endmodule