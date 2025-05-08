module data_memory #(
    parameter DATA_MEM_DEPTH = 256) 
(
    input wire        clk,
    input wire        mem_read_en, 
    input wire        mem_write_en, 
    input wire [31:0] address,     
    input wire [31:0] write_data, 
    output reg [31:0] read_data   
);
 
    reg [31:0] data_mem [0:DATA_MEM_DEPTH-1];
    integer j;
    always @(posedge clk) begin
        if (mem_write_en) begin
            data_mem[address >> 2] <= write_data; 
        end
    end

    always @(*) begin
         if (mem_read_en) begin
             read_data = data_mem[address >> 2];
         end else begin
             read_data = 32'b0; 
         end
    end

    initial begin
         
         for (j = 0; j < DATA_MEM_DEPTH; j = j + 1) begin
             data_mem[j] = 32'b0;
         end
    end

endmodule
